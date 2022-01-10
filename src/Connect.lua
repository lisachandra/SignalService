local strict = require(script.Parent:WaitForChild("strict"))
local SignalService = require(script.Parent)

local function createId(self)
	math.randomseed(#self.__connections)
    
	return tostring(math.random(math.huge, 1))
end

local function Connect(self, callbackFunction)
    -- selene: allow(incorrect_standard_library_use)
    assert(SignalService.isSignal(self) and type(callbackFunction) == "function")

	local id = createId(self)
	self.__callbacks[id] = callbackFunction

	local Connection = strict({
		__signal = self,
		__id = id,

		Disconnect = require(script.Parent:WaitForChild("Disconnect")),
	}, "Connection")

    getmetatable(Connection).__index = function(_self, index)
        if index == "Connection" then
            return self.__callbacks[id] ~= nil and self.__connections ~= nil
        else
            local message = ("%q (%s) is not a valid member of %s"):format(tostring(key), typeof(key), name)

			error(message, 2)
        end
    end

	self.__connections[id] = Connection
	return Connection
end

return Connect
