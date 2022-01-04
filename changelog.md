# Changelog

(almost) All changes in this project will be documented here.

This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.4.2 - 2022-01-04

### Added

- SignalService, Signal and Connection types to init.lua

### Removed

- intellisense module

## 0.4.1 - 2021-12-24

### Added

- [Moonwave documentation](https://zxibs.github.io/SignalService/)

## 0.4.0 - 2021-12-24

### Added

- `<Signal>:Dispatch()` which is very similar to [`Rodux.Store:dispatch()`](https://roblox.github.io/rodux/api-reference/#storedispatch)
- `<Signal>:onDispatch()` which is very similar to [`Rodux.createReducer()`](https://roblox.github.io/rodux/api-reference/#roduxcreatereducer)

## 0.3.1 - 2021-12-22

### Added

- A strict interface to SignalService

## 0.3.0 - 2021-12-22

### Added

- Type checks using [t module](https://github.com/osyrisrblx/t).

## 0.2.2 - 2021-12-22

### Added

- [Intellisense module](https://github.com/zxibs/SignalService/blob/main/src/intellisense.lua)

### Changed

- Unique ID generation for connections to avoid the very unlikely case of an id being the same as another

### Fixed

- Callbacks not firing

### Removed

- Removed EmmyLua annotations and moved it to the [intellisense module](https://github.com/zxibs/SignalService/blob/main/src/intellisense.lua)

## 0.2.1 - 2021-12-20

### Changed

- [Wally package](https://wally.run/package/zxibs/signalservice) now only includes the files inside src.

## 0.2.0 - 2021-12-20

### Added

- SignalService is now on [wally](https://wally.run/package/zxibs/signalservice)!
- `<Signal>:Destroy()` now sets the signal's metatable to nil and runs `<Signal>:DisconnectAll()` before destroying
- A __tostring metatable that returns the ClassName (Signal or Connection) to `strict.lua`
- A SignalService class

### Changed

- Signal is now called SignalService
- `<SignalService>:Destroy()` function and moved it to Signal class (`<Signal>:Destroy()`)
- `<Signal>:DisconnectAll()` now uses `<Connection>:Disconnect()` to all connections instead of setting the callback function to nil

### Fixed

- `<Connection>:Disconnect()` not setting the `<Connection>.Connected` property to false
- `<Signal>:DisconnectAll()` not disconnecting all of the connections when called at (almost) the same time

## 0.1.0 - 2021-12-19

Initial development release
