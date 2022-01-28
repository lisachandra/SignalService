-- MIT License

-- Copyright (c) 2021 lisachandra

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- SignalService
-- This service allows you to create custom events, see the documentation for more info: https://zxibs.github.io/SignalService/

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
