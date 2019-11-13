=begin

    This file is part of the Arachni-RPC project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC EM
    web site for more information on licensing and terms of use.

=end

module Arachni
module RPC
class Client

# Transmits {Request} objects and calls callbacks once an {Response} is received.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class Handler < Reactor::Connection
    include Arachni::RPC::Protocol

    # Default amount of tries for failed requests.
    DEFAULT_TRIES = 9

    # @return   [Symbol]    Status of the connection, can be:
    #
    # * `:idle` -- Just initialized.
    # * `:ready` -- A connection has been established.
    # * `:pending` -- Sending request and awaiting response.
    # * `:done` -- Response received and callback invoked -- ready to be reused.
    # * `:closed` -- Connection closed.
    attr_reader :status

    # @return   [Exceptions::ConnectionError]
    attr_reader :error

    # Prepares an RPC connection and sets {#status} to `:idle`.
    #
    # @param    [Hash]  opts
    # @option   opts    [Integer]   :max_retries    (9)
    #   Default amount of tries for failed requests.
    #
    # @option   opts    [Client]   :base
    #   Client instance needed to {Client#push_connection push} ourselves
    #   back to its connection pool once we're done and we're ready to be reused.
    def initialize( opts )
        @opts = opts.dup

        @max_retries = @opts[:max_retries] || DEFAULT_TRIES
        @client      = @opts[:client]

        @opts[:tries] ||= 0
        @tries ||= @opts[:tries]

        @status  = :idle
        @request = nil
    end

    # Sends an RPC request (i.e. performs an RPC call) and sets {#status}
    # to `:pending`.
    #
    # @param    [Request]      req
    def send_request( req )
        @request = req
        @status  = :pending
        super( req )
    end

    # @note Pushes itself to the client's connection pool to be re-used.
    #
    # Handles responses to RPC requests, calls its callback and sets {#status}
    # to `:done`.
    #
    # @param    [Arachni::RPC::Response]    res
    def receive_response( res )
        if res.exception?
            res.obj = Exceptions.from_response( res )
        end

        @request.callback.call( res.obj ) if @request.callback
    ensure
        @request = nil # Help the GC out.
        @error   = nil # Help the GC out.
        @status  = :done

        @opts[:tries] = @tries = 0
        @client.push_connection self
    end

    # Handles closed connections, cleans up the SSL session, retries (if
    # necessary) and sets {#status} to `:closed`.
    #
    # @private
    def on_close( reason )
         if @request
             # If there is a request and a callback and the callback hasn't yet be
             # called (i.e. not done) then we got here by error so retry.
             if @request && @request.callback && !done?
                 if retry?
                     retry_request
                 else
                     @error = e = Exceptions::ConnectionError.new( "Connection closed [#{reason}]" )
                     @request.callback.call( e )
                     @client.connection_failed self
                 end

                 return
             end
         else
             @error = reason
             @client.connection_failed self
         end

        close_without_retry
    end

    # @note If `true`, the connection can be re-used.
    #
    # @return   [Boolean]
    #   `true` when the connection is done, `false` otherwise.
    def done?
        @status == :done
    end

    # Closes the connection without triggering a retry operation and sets
    # {#status} to `:closed`.
    def close_without_retry
        @request = nil
        @status  = :closed
        close_without_callback
    end

    private

    # Converts incoming hash objects to {Response} objects and calls
    # {#receive_response}.
    #
    # @param    [Hash]      obj
    def receive_object( obj )
        receive_response( Response.new( obj ) )
    end

    def retry_request
        opts = @opts.dup
        opts[:tries] += 1

        req = @request.dup

        # The connection will be detached soon, keep a separate reference to
        # the reactor.
        reactor = @reactor

        @tries += 1
        reactor.delay( 0.2 ) do
            address = opts[:socket] ? opts[:socket] : [opts[:host], opts[:port]]
            reactor.connect( *[address, self.class, opts ].flatten ).send_request( req )
        end

        close_without_retry
    end

    def retry?
        @tries < @max_retries
    end

end

end
end
end
