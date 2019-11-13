=begin

    This file is part of the Arachni-RPC project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC
    web site for more information on licensing and terms of use.

=end

module Arachni
module RPC

# Maps the methods of remote objects to local ones.
#
# You start like:
#
#     client = Arachni::RPC::Client.new( host: 'localhost', port: 7331 )
#     bench  = Arachni::RPC::Proxy.new( client, 'bench' )
#
# And it allows you to do this:
#
#     result = bench.foo( 1, 2, 3 )
#
# Instead of:
#
#     result = client.call( 'bench.foo', 1, 2, 3 )
#
# The server on the other end must have an appropriate handler set, like:
#
#     class Bench
#         def foo( i = 0 )
#             return i
#         end
#     end
#
#     server = Arachni::RPC::Server.new( host: 'localhost', port: 7331 )
#     server.add_handler( 'bench', Bench.new )
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class Proxy

    class <<self

        # @param    [Symbol]    method_name
        #   Method whose response to translate.
        # @param    [Block]    translator
        #   Block to be passed the response and return a translated object.
        def translate( method_name, &translator )
            define_method method_name do |*args, &b|
                # For blocking calls.
                if !b
                    data = forward( method_name, *args )
                    return data.rpc_exception? ?
                        data : translator.call( data, *args )
                end

                # For non-blocking calls.
                forward( method_name, *args ) do |data|
                    b.call( data.rpc_exception? ?
                                data : translator.call( data, *args ) )
                end
            end
        end
    end

    # @param    [Client]    client
    # @param    [String]    handler
    def initialize( client, handler )
        @client  = client
        @handler = handler
    end

    def forward( sym, *args, &block )
        @client.call( "#{@handler}.#{sym.to_s}", *args, &block )
    end

    private

    # Used to provide the illusion of locality for remote methods.
    def method_missing( *args, &block )
        forward( *args, &block )
    end

end

end
end
