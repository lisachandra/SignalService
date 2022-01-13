local strict = require(script.Parent:WaitForChild("strict"))
local SignalService = require(script.Parent)

local function createId(self)
	math.randomseed(#self.__connections)

	return tostring(math.random(math.huge, 1))
end

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

	local id = createId(self)
	self.__callbacks[id] = callbackFunction

	local Connection = strict({
		__signal = self,
		__id = id,

		Disconnect = require(script.Parent:WaitForChild("Disconnect")),
	}, "Connection")

	self.__connections[id] = Connection
	return Connection
end

return Connect
