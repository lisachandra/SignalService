local strict = require(script.Parent:WaitForChild("strict"))

local Symbol = require(script.Parent:WaitForChild("Symbol"))
local SignalService = require(script.Parent)

local function connectCheck(self, callbackFunction)
	if SignalService.isSignal(self) then
		if type(callbackFunction) ~= "function" then
			return false,
				"bad argument #2 (function expected, got " .. type(callbackFunction) .. ")" .. debug.traceback()
		end

		return true
	else
		return false, "Expected `:` not `.` while calling function Connect" .. debug.traceback()
	end
end

local function Connect(self, callbackFunction)
	assert(connectCheck(self, callbackFunction))

	local key = Symbol.named("Connection")
	self._callbacks[key] = callbackFunction

	local Connection = strict({
		_signal = self,
		_key = key,

        Connected = true,

		Disconnect = require(script.Parent:WaitForChild("Disconnect")),
	}, "Connection")

	self._connections[key] = Connection
	return Connection
end

return Connect
