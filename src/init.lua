export type Connection = {
	_signal: Signal,
	_key: string,

	Connected: boolean,

	Disconnect: (self: Connection) -> (),
}

export type Signal = {
	_connections: { [userdata]: Connection },
	_callbacks: { [userdata]: (...any) -> () },
	_waiters: { [number]: thread },

	Fire: (self: Signal, ...any) -> (),
	Wait: (self: Signal) -> ...any,
	Connect: (self: Signal, callbackFn: (...any) -> ()) -> Connection,
	Destroy: (self: Signal) -> (),
	Dispatch: (self: Signal, action: { type: string }) -> (),
	onDispatch: (self: Signal, dispatchHandlers: { [string]: (action: { type: string }) -> () }) -> (),
	DisconnectAll: (self: Signal) -> (),
}

export type SignalService = {
	new: () -> Signal,
	isSignal: (signalObject: Signal?) -> (boolean, string?),
}

local strict = require(script:WaitForChild("strict"))

--[[
     A service that allows you to create custom events  
     Github: [https://github.com/zxibs/SignalService](https://github.com/zxibs/SignalService)
]]
local SignalService: SignalService = strict({
	new = require(script:WaitForChild("new")),
	isSignal = require(script:WaitForChild("isSignal")),
}, "SignalService")

return SignalService
