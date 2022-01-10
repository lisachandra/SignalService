local SignalService = require(script.Parent)

local function Dispatch(self, action)
	assert(SignalService.isSignal(self) and type(action) == "table" and type(action.type) == "string")

	return self.__dispatchHandler(action)
end

return Dispatch
