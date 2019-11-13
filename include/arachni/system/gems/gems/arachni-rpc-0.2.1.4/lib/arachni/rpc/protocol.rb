=begin

    This file is part of the Arachni-RPC project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC EM
    web site for more information on licensing and terms of use.

=end

module Arachni
module RPC

# Provides helper transport methods for {Message} transmission.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
module Protocol
    include Reactor::Connection::TLS

    # Initializes an SSL session once the connection has been established and
    # sets {#status} to `:ready`.
    #
    # @private
    def on_connect
        start_tls(
            ca:          @opts[:ssl_ca],
            private_key: @opts[:ssl_pkey],
            certificate: @opts[:ssl_cert]
        )

        @status = :ready
    end

    # @param    [Message]    msg
    #   Message to send to the peer.
    def send_message( msg )
        send_object( msg.prepare_for_tx )
    end
    alias :send_request  :send_message
    alias :send_response :send_message

    # Receives data from the network.
    #
    # Rhe data will be chunks of a serialized object which will be buffered
    # until the whole transmission has finished.
    #
    # It will then unserialize it and pass it to {#receive_object}.
    def on_read( data )
        (@buf ||= '') << data

        while @buf.size >= 4
            if @buf.size >= 4 + ( size = @buf.unpack( 'N' ).first )
                @buf.slice!( 0, 4 )
                receive_object( unserialize( @buf.slice!( 0, size ) ) )
            else
                break
            end
        end
    end

    private

    # Stub method, should be implemented by servers.
    #
    # @param    [Request]     request
    # @abstract
    def receive_request( request )
        p request
    end

    # Stub method, should be implemented by clients.
    #
    # @param    [Response]    response
    # @abstract
    def receive_response( response )
        p response
    end

    #   Object to send.
    def send_object( obj )
        data = serialize( obj )
        write [data.bytesize, data].pack( 'Na*' )
    end

    # Returns the preferred serializer based on the `serializer` option of the
    # server.
    #
    # @return   [.load, .dump]
    #   Serializer to be used (Defaults to `YAML`).
    def serializer
        @opts[:serializer] || YAML
    end

    def serialize( obj )
        serializer.dump obj
    end

    def unserialize( obj )
        serializer.load( obj )
    end

end

end
end
