# ChangeLog

## Version 0.2.1.4

- `Arachni::Reactor` dependency update.

## Version 0.2.1.3

- `Arachni::Reactor` dependency update.

## Version 0.2.1.2

- `Arachni::Reactor` dependency update.

## Version 0.2.1.1

- `Arachni::Reactor` dependency update.

## Version 0.2.1

- `Arachni::RPC::Client`: Updated to ensure that the `Arachni::Reactor` is
    running prior to RPC operations.

## Version 0.2.0

- Added `Arachni::Reactor`-based RPC client/server implementation.

## Version 0.1.3

- Removed `Arachni::RPC::Request#do_not_defer` and `Arachni::RPC::Request#defer?`.
- All RPC exceptions now inherit from `RuntimeError` instead of `Exception`.

## Version 0.1.2

- Code cleanup.
- `Arachni::RPC::Request#do_not_defer!` => `Arachni::RPC::Request#do_not_defer`.
