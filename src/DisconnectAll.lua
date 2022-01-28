local SignalService = require(script.Parent)

local function DisconnectAll(self)
	if not SignalService.isSignal(self) then
		local message = "Expected `:` not `.` while calling function DisconnectAll"

		error(message, 2)
	end

	for _, connection in pairs(self._connections) do
		connection:Disconnect()
	end
end

return DisconnectAll
