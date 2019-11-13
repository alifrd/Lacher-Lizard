require 'ap'
require 'timeout'
require_relative '../lib/arachni/rpc'
require_relative 'servers/server'

def cwd
    File.expand_path( File.dirname( __FILE__ ) )
end

def start_client( opts )
    Arachni::RPC::Client.new( opts )
end

def quiet_spawn( file )
    path = File.join( File.expand_path( File.dirname( __FILE__ ) ), 'servers', "#{file}.rb" )
    Process.spawn RbConfig.ruby, path#, out: '/dev/null'
end

server_pids = []
RSpec.configure do |config|
    config.color = true
    config.add_formatter :documentation

    config.before( :suite ) do
        File.delete( '/tmp/arachni-rpc-test' ) rescue nil

        files = %w(basic with_ssl_primitives)
        files << 'unix_socket' if Arachni::Reactor.supports_unix_sockets?

        files.each do |name|
            server_pids << quiet_spawn( name ).tap { |pid| Process.detach( pid ) }
        end
        sleep 5
    end

    config.after( :suite ) do
        server_pids.each { |pid| Process.kill( 'KILL', pid ) }
    end
end
