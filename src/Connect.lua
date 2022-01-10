local strict = require(script.Parent:WaitForChild("strict"))
local t = require(script.Parent.Parent:WaitForChild("t")) or require(script.Parent.Parent.Parent.Parent:WaitForChild("t"))
local SignalService = require(script.Parent)

local connectCheck = t.tuple(SignalService.isSignal, t.callback)

local function createId(self)
	math.randomseed(#self.__connections)

    return math.random(1, math.huge)
end

local function Connect(self, callbackFunction)
	assert(connectCheck(self, callbackFunction))

	local id = createId(self)
	self.__callbacks[id] = callbackFunction

	local Connection = {
		__signal = self,
		__id = id,

		Connected = true,

		Disconnect = require(script.Parent:WaitForChild("Disconnect")),
	}

	Connection = strict(Connection, "Connection")
	self.__connections[id] = Connection
	return Connection
end

return Connect
