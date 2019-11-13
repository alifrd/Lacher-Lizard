=begin

    This file is part of the Arachni-RPC EM project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC EM
    web site for more information on licensing and terms of use.

=end

module Arachni
module RPC
class Server

# Receives {Request} objects and transmits {Response} objects.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class Handler < Reactor::Connection
    include Reactor::Connection::PeerInfo
    include Arachni::RPC::Protocol

    # @return   [Request]
    #   Working RPC request.
    attr_reader :request

    # @param    [Server]    server
    #   RPC server.
    def initialize( server )
        @server  = server
        @opts    = server.opts.dup
        @request = nil
    end

    # Handles closed connections and cleans up the SSL session.
    #
    # @private
    def on_close( _ )
        @server = nil
    end

    # * Handles {Request}
    # * Sets the {#request}.
    # * Sends back {Response}.
    #
    # @param    [Request]     req
    def receive_request( req )
        @request = req

        # Create an empty response to be filled in little by little.
        res  = Response.new
        peer = peer_ip_address

        begin
            # Make sure the client is allowed to make RPC calls.
            authenticate!

            # Grab the partially filled in response which includes the result
            # of the RPC call and merge it with out prepared response.
            res.merge!( @server.call( self ) )

        # Handle exceptions and convert them to a simple hash, ready to be
        # passed to the client.
        rescue Exception => e
            type = ''

            # If it's an RPC exception pass the type along as is...
            if e.rpc_exception?
                type = e.class.name.split( ':' )[-1]

            # ...otherwise set it to a RemoteException.
            else
                type = 'RemoteException'
            end

            # RPC conventions for exception transmission.
            res.exception = {
                'type'      => type,
                'message'   => e.to_s,
                'backtrace' => e.backtrace
            }

            msg = "#{e.to_s}\n#{e.backtrace.join( "\n" )}"
            @server.logger.error( 'Exception' ){ msg + " [on behalf of #{peer}]" }
        end

        # Pass the result of the RPC call back to the client but *only* if it
        # wasn't async, otherwise {Server#call} will have already taken care of it.
        send_response( res ) if !res.async?
    end

    private

    # Converts incoming hash objects to {Request} objects and calls
    # {#receive_request}.
    #
    # @param    [Hash]      obj
    def receive_object( obj )
        receive_request( Request.new( obj ) )
    end

    # @param    [Symbol]    severity
    #
    #   Severity of the logged event:
    #
    #   * `:debug`
    #   * `:info`
    #   * `:warn`
    #   * `:error`
    #   * `:fatal`
    #   * `:unknown`
    #
    # @param    [String]    category
    #   Category of message (SSL, Call, etc.).
    # @param    [String]    msg
    #   Message to log.
    def log( severity, category, msg )
        sev_sym = Logger.const_get( severity.to_s.upcase.to_sym )
        @server.logger.add( sev_sym, msg, category )
    end

    # Authenticates the client based on the token in the request.
    #
    # It will raise an exception if the token doesn't check-out.
    def authenticate!
        return if valid_token?( @request.token )

        msg = "Token missing or invalid while calling: #{@request.message}"

        @server.logger.error( 'Authenticator' ){
            msg + " [on behalf of #{peer_ip_address}]"
        }

        fail Exceptions::InvalidToken.new( msg )
    end

    # Compares the authentication token in the param with the one of the server.
    #
    # @param    [String]    token
    #
    # @return   [Bool]
    def valid_token?( token )
        token == @server.token
    end

end
end
end
end
