local SignalService = require(script.Parent)

local function DisconnectAll(self)
	if not SignalService.isSignal(self) then
		local message = "Expected `:` not `.` while calling function Fire"

		error(message, 2)
	end

	for _, connection in pairs(self.__connections) do
		self.__connections[connection.__id] = nil
        self.__callbacks[connection.__id] = nil

        setmetatable(connection, {__mode = "kv"})
	end
end

return DisconnectAll
