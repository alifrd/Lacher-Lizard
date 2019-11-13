=begin

    This file is part of the Arachni-RPC project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC
    web site for more information on licensing and terms of use.

=end

# RPC Exceptions have methods that help identify them based on type.
#
# So in order to allow evaluations like:
#
#    my_object.rpc_connection_error?
#
# to be possible on all objects these helper methods need to be available for
# all objects.
#
# By default they'll return false, individual RPC Exceptions will overwrite them
# to return true when applicable.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class Object

    # @return   [Bool]  false
    def rpc_connection_error?
        false
    end

    # @return   [Bool]  false
    def rpc_remote_exception?
        false
    end

    # @return   [Bool]  false
    def rpc_invalid_object_error?
        false
    end

    # @return   [Bool]  false
    def rpc_invalid_method_error?
        false
    end

    # @return   [Bool]  false
    def rpc_invalid_token_error?
        false
    end

    # @return   [Bool]  true
    def rpc_ssl_error?
        false
    end

    # @return   [Bool]  false
    def rpc_exception?
        false
    end

end

module Arachni
module RPC
module Exceptions

    # Returns an exception based on the response object.
    #
    # @param    [Arachni::RPC::Response]    response
    #
    # @return   [Exception]
    def self.from_response( response )
        exception = response.exception
        klass = Arachni::RPC::Exceptions.const_get( exception['type'].to_sym )
        e = klass.new( exception['message'] )
        e.set_backtrace( exception['backtrace'] )
        e
    end

    class Base < ::RuntimeError

        # @return   [Bool]  true
        def rpc_exception?
            true
        end
    end

    # Signifies an abruptly terminated connection.
    #
    # Look for network or SSL errors or a dead server or a mistyped server address/port.
    class ConnectionError < Base

        # @return   [Bool]  true
        def rpc_connection_error?
            true
        end
    end

    # Signifies an exception that occurred on the server-side.
    #
    # Look errors on the remote method and review the server output for more details.
    class RemoteException < Base

        # @return   [Bool]  true
        def rpc_remote_exception?
            true
        end
    end

    # An invalid object has been called.
    #
    # Make sure that there is a server-side handler for the object you called.
    class InvalidObject < Base

        # @return   [Bool]  true
        def rpc_invalid_object_error?
            true
        end

    end

    # An invalid method has been called.
    #
    # Occurs when a remote method doesn't exist or isn't public.
    class InvalidMethod < Base

        # @return   [Bool]  true
        def rpc_invalid_method_error?
            true
        end

    end

    # Signifies an authentication token mismatch between the client and the server.
    class InvalidToken  < Base

        # @return   [Bool]  true
        def rpc_invalid_token_error?
            true
        end

    end

    # Signifies an authentication token mismatch between the client and the server.
    class SSLPeerVerificationFailed < ConnectionError

        # @return   [Bool]  true
        def rpc_ssl_error?
            true
        end

    end

end
end
end
