local strict = require(script.Parent:WaitForChild("strict"))
local SignalService = require(script.Parent)

local connectionsMt = {
    __index = function(self, index)
        if type(rawget(self, index)) == "function" then
            return function(_self, ...)
                return self[index](_self, ...)
            end
        end

        return self[index]
    end,

    __newindex = function(self, index, value)
        self[index] = value
    end
}

local function createId(self)
	math.randomseed(#self.__connections)
	return tostring(math.random(math.huge, 1))
end

local function Connect(self, callbackFunction)
    -- selene: allow(incorrect_standard_library_use)
    assert(SignalService.isSignal(self) and type(callbackFunction) == "function")

	local id = createId(self)
	self.__callbacks[id] = callbackFunction

	local Connection = {
		__signal = self,
		__id = id,

		Connected = true,

		Disconnect = require(script.Parent:WaitForChild("Disconnect")),
	}

	Connection = strict(Connection, "Connection")
	self.__connections[id] = setmetatable({}, connectionsMt)

	return Connection
end

return Connect
