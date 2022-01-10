local SignalService = require(script.Parent)

local function Fire(self, ...)
	if not SignalService.isSignal(self) then
		local message = "Expected `:` not `.` while calling function Fire"

		error(message, 2)
	end

	for _, callback in pairs(self.__callbacks) do
		coroutine.wrap(callback)(...)
	end

	for index, waiterThread in pairs(self.__waiters) do
		coroutine.resume(waiterThread, ...)
		self.__waiters[index] = nil
	end
end

return Fire
