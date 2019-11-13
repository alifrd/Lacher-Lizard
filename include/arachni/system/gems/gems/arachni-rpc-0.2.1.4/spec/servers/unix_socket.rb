require_relative 'server'

opts = rpc_opts.merge(
    socket:     '/tmp/arachni-rpc-test',
    serializer: Marshal
)

start_server( opts )
