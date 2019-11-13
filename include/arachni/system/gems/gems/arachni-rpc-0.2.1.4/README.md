# Arachni-RPC

<table>
    <tr>
        <th>Version</th>
        <td>0.2.1.4</td>
    </tr>
    <tr>
        <th>Github page</th>
        <td><a href="http://github.com/Arachni/arachni-rpc">http://github.com/Arachni/arachni-rpc</a></td>
     <tr/>
    <tr>
        <th>Code Documentation</th>
        <td><a href="http://rubydoc.info/github/Arachni/arachni-rpc/">http://rubydoc.info/github/Arachni/arachni-rpc/</a></td>
    </tr>
    <tr>
       <th>Author</th>
       <td><a href="mailto:tasos.laskos@arachni-scanner.com">Tasos "Zapotek" Laskos</a></td>
    </tr>
    <tr>
        <th>Twitter</th>
        <td><a href="http://twitter.com/Zap0tek">@Zap0tek</a></td>
    </tr>
    <tr>
        <th>Copyright</th>
        <td>2011-2017 <a href="http://www.sarosys.com">Sarosys LLC</a></td>
    </tr>
    <tr>
        <th>License</th>
        <td><a href="file.LICENSE.html">3-clause BSD</a></td>
    </tr>
</table>

## Synopsis

Arachni-RPC is a simple and lightweight Remote Procedure Call protocol and implementation
which provides the basis for <a href="http://arachni-scanner.com">Arachni</a>'s
distributed infrastructure.

(Based on the [Arachni::Reactor](https://github.com/Arachni/arachni-reactor) framework.)

## Features

 - Extremely lightweight.
 - Very simple design.
 - TLS encryption.
 - Configurable serializer.
    - Can intercept RPC responses and translate them into native objects for
        when using serializers that only support basic types, like JSON or MessagePack.
 - Token-based authentication.
 - Pure-Ruby.
 - Multi-platform, tested on:
    - Linux
    - OSX
    - Windows

## Installation

    gem install arachni-rpc

## Running the Specs

    bundle install
    rake spec

## Protocol specifications

You can find the RPC protocol specification at the
[Wiki](https://github.com/Arachni/arachni-rpc/wiki).

## Bug reports/Feature requests

Please send your feedback using GitHub's issue system at
[http://github.com/arachni/arachni-rpc/issues](http://github.com/arachni/arachni-rpc/issues).


## License

Arachni-RPC is provided under the 3-clause BSD license.
See the `LICENSE` file for more information.
