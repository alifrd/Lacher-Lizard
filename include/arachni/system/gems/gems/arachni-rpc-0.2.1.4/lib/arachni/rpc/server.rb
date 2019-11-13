=begin

    This file is part of the Arachni-RPC EM project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC EM
    web site for more information on licensing and terms of use.

=end

require 'set'
require 'logger'

module Arachni
module RPC

require_relative 'server/handler'

# RPC server.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class Server

    # @return   [String]
    #   Authentication token.
    attr_reader :token

    # @return   [Hash]
    #   Configuration options.
    attr_reader :opts

    # @return   [Logger]
    attr_reader :logger

    # Starts the RPC server.
    #
    # @example  Example options:
    #
    #    {
    #        :host  => 'localhost',
    #        :port  => 7331,
    #
    #        # optional authentication token, if it doesn't match the one
    #        # set on the server-side you'll be getting exceptions.
    #        :token => 'superdupersecret',
    #
    #        # optional serializer (defaults to YAML)
    #        :serializer => Marshal,
    #
    #        # In order to enable peer verification one must first provide
    #        # the following:
    #        #
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
    # @option   opts    [String]    :token  Optional authentication token.
    # @option   opts    [.dump, .load]      :serializer (YAML)
    #   Serializer to use for message transmission.
    # @option   opts    [.dump, .load]      :fallback_serializer
    #   Optional fallback serializer to be used when the primary one fails.
    # @option   opts    [Integer]   :max_retries
    #   How many times to retry failed requests.
    # @option   opts    [String]    :ssl_ca  SSL CA certificate.
    # @option   opts    [String]    :ssl_pkey  SSL private key.
    # @option   opts    [String]    :ssl_cert  SSL certificate.
    def initialize( opts )
        @opts = opts

        if @opts[:ssl_pkey] && @opts[:ssl_cert]
            if !File.exist?( @opts[:ssl_pkey] )
                raise "Could not find private key at: #{@opts[:ssl_pkey]}"
            end

            if !File.exist?( @opts[:ssl_cert] )
                raise "Could not find certificate at: #{@opts[:ssl_cert]}"
            end
        end

        @token = @opts[:token]

        @logger = ::Logger.new( STDOUT )
        @logger.level = Logger::INFO

        @host, @port = @opts[:host], @opts[:port]
        @socket = @opts[:socket]

        if !@socket && !(@host || @port)
            fail ArgumentError, 'Needs either a :socket or :host and :port options.'
        end

        @port = @port.to_i

        @reactor = Reactor.global

        clear_handlers
    end

    # @example
    #
    #    server.add_async_check do |method|
    #        #
    #        # Must return 'true' for async and 'false' for sync.
    #        #
    #        # Very simple check here...
    #        #
    #        'async' ==  method.name.to_s.split( '_' )[0]
    #    end
    #
    # @param    [Block]  block
    #   Block to identify methods that pass their result to a block instead of
    #   simply returning them (which is the most usual operation of async methods).
    def add_async_check( &block )
        @async_checks << block
    end

    # @example
    #
    #    server.add_handler( 'myclass', MyClass.new )
    #
    # @param    [String]    name
    #   Name by which to make the object available over RPC.
    # @param    [Object]    obj
    #   Instantiated server object to expose.
    def add_handler( name, obj )
        @objects[name]       = obj
        @methods[name]       = Set.new
        @async_methods[name] = Set.new

        obj.class.public_instance_methods( false ).each do |method|
            @methods[name]       << method.to_s
            @async_methods[name] << method.to_s if async_check( obj.method( method ) )
        end
    end

    # Clears all handlers and their associated information like methods and
    # async check blocks.
    #
    # @see #add_handler
    # @see #add_async_check
    def clear_handlers
        @objects = {}
        @methods = {}

        @async_checks  = []
        @async_methods = {}
    end

    # Runs the server and blocks while `Arachni::Reactor` is running.
    def run
        @reactor.run { start }
    end

    # Starts the server but does not block.
    def start
        @logger.info( 'System' ){ 'RPC Server started.' }
        @logger.info( 'System' ) do
            interface = @socket ? @socket : "#{@host}:#{@port}"
            "Listening on #{interface}"
        end

        opts = @socket ? @socket : [@host, @port]
        @reactor.listen( *[opts, Handler, self].flatten )
    end

    # @note If the called method is asynchronous it will be sent by this method
    #   directly, otherwise it will be handled by the {Handler}.
    #
    # @param    [Handler]   connection
    #   Connection with request information.
    #
    # @return   [Response]
    def call( connection )
        req          = connection.request
        peer_ip_addr = connection.peer_address

        expr, args = req.message, req.args
        meth_name, obj_name = parse_expr( expr )

        log_call( peer_ip_addr, expr, *args )

        if !object_exist?( obj_name )
            msg = "Trying to access non-existent object '#{obj_name}'."
            @logger.error( 'Call' ){ msg + " [on behalf of #{peer_ip_addr}]" }
            raise Exceptions::InvalidObject.new( msg )
        end

        if !public_method?( obj_name, meth_name )
            msg = "Trying to access non-public method '#{meth_name}'."
            @logger.error( 'Call' ){ msg + " [on behalf of #{peer_ip_addr}]" }
            raise Exceptions::InvalidMethod.new( msg )
        end

        # The handler needs to know if this is an async call because if it is
        # we'll have already send the response and it doesn't need to do
        # transmit anything.
        res = Response.new
        res.async! if async?( obj_name, meth_name )

        if res.async?
            @objects[obj_name].send( meth_name.to_sym, *args ) do |obj|
                res.obj = obj
                connection.send_response( res )
            end
        else
            res.obj = @objects[obj_name].send( meth_name.to_sym, *args )
        end

        res
    end

    # @return   [TrueClass]
    def alive?
        true
    end

    # Shuts down the server after 2 seconds
    def shutdown
        wait_for = 2

        @logger.info( 'System' ){ "Shutting down in #{wait_for} seconds..." }

        # Don't die before returning...
        @reactor.delay( wait_for ) do
            @reactor.stop
        end
        true
    end

    private

    def async?( objname, method )
        @async_methods[objname].include?( method )
    end

    def async_check( method )
        @async_checks.each { |check| return true if check.call( method ) }
        false
    end

    def log_call( peer_ip_addr, expr, *args )
        msg = "#{expr}"

        # this should be in a @logger.debug call but it'll get out of sync
        if @logger.level == Logger::DEBUG
            cargs = args.map { |arg| arg.inspect }
            msg += "( #{cargs.join( ', ' )} )"
        end

        msg += " [#{peer_ip_addr}]"

        @logger.info( 'Call' ){ msg }
    end

    def parse_expr( expr )
        parts = expr.to_s.split( '.' )
        # method name, object name
        [ parts.pop, parts.join( '.' ) ]
    end

    def object_exist?( obj_name )
        @objects[obj_name] ? true : false
    end

    def public_method?( obj_name, method )
        @methods[obj_name].include?( method )
    end

end

end
end
