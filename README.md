# SignalService

This service allows you to create custom events, see the documentation for more info: (documentation is not available yet.)

# Changelog

(almost) All changes in this project will be documented here.

This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.2.0 - 2021-12-20

### Added

- SignalService is now on [wally](https://github.com/UpliftGames/wally)!
- `Signal:Destroy()` now sets the signal's metatable to nil and runs `Signal:DisconnectAll()` before destroying
- A __tostring metatable that returns the ClassName (Signal or Connection) to `strict.lua`
- A SignalService class

### Changed

- Signal is now called SignalService
- `SignalService:Destroy()` function and moved it to Signal class (`Signal:Destroy()`)
- `Signal:DisconnectAll()` now uses `Connection:Disconnect()` to all connections instead of setting the callback function to nil

### Fixed

- `Connection:Disconnect()` not setting the `Connection.Connected` property to false
- `Signal:DisconnectAll()` not disconnecting all of the connections when called at (almost) the same time

## 0.1.0 - 2021-12-19

Initial development release
