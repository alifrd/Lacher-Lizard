=begin

    This file is part of the Arachni-RPC project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC EM
    web site for more information on licensing and terms of use.

=end

module Arachni
module RPC

require_relative 'client/handler'

# Simple RPC client capable of:
#
# * TLS encryption.
# * Asynchronous and synchronous requests.
# * Handling remote asynchronous calls that defer their result.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class Client

    # Default amount of connections to maintain in the re-use pool.
    DEFAULT_CONNECTION_POOL_SIZE = 1

    # @return   [Hash]
    #   Options hash.
    attr_reader :opts

    # @return   [Integer]
    #   Amount of connections in the pool.
    attr_reader :connection_count

    # @example Example options:
    #
    #    {
    #        :host  => 'localhost',
    #        :port  => 7331,
    #
    #        # optional authentication token, if it doesn't match the one
    #        # set on the server-side you'll be getting exceptions.
    #        :token => 'superdupersecret',
    #
    #        :serializer => Marshal,
    #
    #        :max_retries => 0,
    #
    #        # In order to enable peer verification one must first provide
    #        # the following:
    #        # SSL CA certificate
    #        :ssl_ca     => cwd + '/../spec/pems/cacert.pem',
    #        # SSL private key
    #        :ssl_pkey   => cwd + '/../spec/pems/client/key.pem',
    #        # SSL certificate
    #        :ssl_cert   => cwd + '/../spec/pems/client/cert.pem'
    #    }
    #
    # @param    [Hash]  opts
    # @option   opts    [String]    :host   Hostname/IP address.
    # @option   opts    [Integer]   :port   Port number.
    # @option   opts    [String]   :socket   Path to UNIX domain socket.
    # @option   opts    [Integer]   :connection_pool_size (1)
    #   Amount of connections to keep open.
    # @option   opts    [String]    :token  Optional authentication token.
    # @option   opts    [.dump, .load]      :serializer (YAML)
    #   Serializer to use for message transmission.
    # @option   opts    [Integer]   :max_retries
    #   How many times to retry failed requests.
    # @option   opts    [String]    :ssl_ca  SSL CA certificate.
    # @option   opts    [String]    :ssl_pkey  SSL private key.
    # @option   opts    [String]    :ssl_cert  SSL certificate.
    def initialize( opts )
        @opts  = opts.merge( role: :client )
        @token = @opts[:token]

        @host, @port = @opts[:host], @opts[:port].to_i
        @socket = @opts[:socket]

        if !@socket && !(@host || @port)
            fail ArgumentError, 'Needs either a :socket or :host and :port options.'
        end

        @port = @port.to_i

        if @host && @port <= 0
            fail ArgumentError, "Invalid port: #{@port}"
        end

        @pool_size = @opts[:connection_pool_size] || DEFAULT_CONNECTION_POOL_SIZE

        @reactor = Reactor.global

        @connections      = @reactor.create_queue
        @connection_count = 0
    end

    # Connection factory, will re-use or create new connections as needed to
    # accommodate the workload.
    #
    # @param    [Block] block
    #   Block to be passed a {Handler connection}.
    #
    # @return   [Boolean]
    #   `true` if a new connection had to be established, `false` if an existing
    #   one was re-used.
    def connect( &block )
        ensure_reactor_running

        if @connections.empty? && @connection_count < @pool_size
            opts = @socket ? @socket : [@host, @port]
            block.call @reactor.connect( *[opts, Handler, @opts.merge( client: self )].flatten )
            increment_connection_counter
            return true
        end

        pop_block = proc do |conn|
            # Some connections may have died while they were waiting in the
            # queue, get rid of them and start all over in case the queue has
            # been emptied.
            if !conn.done?
                connection_failed conn
                connect( &block )
                next
            end

            block.call conn
        end

        @connections.pop( &pop_block )

        false
    end

    # Close all connections.
    def close
        ensure_reactor_running

        @reactor.on_tick do |task|
            @connections.pop(&:close_without_retry)
            task.done if @connections.empty?
        end
    end

    def increment_connection_counter
        @connection_count += 1
    end

    # {Handler#done? Finished} {Handler}s push themselves here to be re-used.
    #
    # @param    [Handler]   connection
    def push_connection( connection )
        ensure_reactor_running

        @connections << connection
    end

    # Handles failed connections.
    #
    # @param    [Handler]   connection
    def connection_failed( connection )
        ensure_reactor_running

        @connection_count -= 1
        connection.close_without_retry
    end

    # Calls a remote method and grabs the result.
    #
    # There are 2 ways to perform a call, async (non-blocking) and sync (blocking).
    #
    # @example To perform an async call you need to provide a block to handle the result.
    #
    #    server.call( 'handler.method', arg1, arg2 ) do |res|
    #        do_stuff( res )
    #    end
    #
    # @example To perform a sync (blocking), call without a block.
    #
    #    res = server.call( 'handler.method', arg1, arg2 )
    #
    # @param    [String]    msg
    #   RPC message in the form of `handler.method`.
    # @param    [Array]     args
    #   Collection of arguments to be passed to the method.
    # @param    [Block]      block
    def call( msg, *args, &block )
        ensure_reactor_running

        req = Request.new(
            message:  msg,
            args:     args,
            callback: block,
            token:    @token
        )

        block_given? ? call_async( req ) : call_sync( req )
    end

    private

    def set_exception( req, e )
        msg = @socket ? " for '#{@socket}'." : " for '#{@host}:#{@port}'."

        exc = (e.is_a?( Reactor::Connection::Error::SSL ) ?
                Exceptions::SSLPeerVerificationFailed : Exceptions::ConnectionError
                ).new( e.to_s + msg )

        exc.set_backtrace e.backtrace
        req.callback.call exc
    end

    def call_async( req, &block )
        req.callback = block if block_given?

        begin
            connect do |connection|
                error = (connection.is_a?( Exception ) and connection) || connection.error
                next set_exception( req, error ) if error

                connection.send_request( req )
            end
        rescue => e
            set_exception( req, e )
        end
    end

    def call_sync( req )
        # If we're in the Reactor thread use a Fiber and if we're not use a Thread.
        if @reactor.in_same_thread?
            fail 'Cannot perform synchronous calls when running in the ' +
                     "#{Arachni::Reactor} loop."
        end

        q = Queue.new
        call_async( req ) { |obj| q << obj }
        ret = q.pop

        raise ret if ret.is_a?( Exception )

        ret
    end

    def ensure_reactor_running
        return if @reactor.running?
        @reactor.run_in_thread
    end

end

end
end
