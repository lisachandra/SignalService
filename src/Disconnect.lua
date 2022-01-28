local SignalService = require(script.Parent)

local function Disconnect(self)
	if not SignalService.isSignal(self) then
		local message = "Expected `:` not `.` while calling function Disconnect"

		error(message, 2)
	end

	self._signal._connections[self._key] = nil
	self._signal._callbacks[self._key] = nil

	setmetatable(self, { __mode = "kv" })
end

return Disconnect
