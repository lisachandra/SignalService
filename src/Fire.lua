local SignalService = require(script.Parent)

local function Fire(self, ...)
	if not SignalService.isSignal(self) then
		local message = "Expected `:` not `.` while calling function Fire"

		error(message, 2)
	end

	for _, callback in pairs(self._callbacks) do
		coroutine.wrap(callback)(...)
	end

	for index, waiterThread in pairs(self._waiters) do
		coroutine.resume(waiterThread, ...)
		self._waiters[index] = nil
	end
end

return Fire
