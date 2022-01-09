local SignalService = require(script.Parent)
local t = require(script.Parent.Parent:WaitForChild("t")) or require(script.Parent.Parent.Parent.Parent:WaitForChild("t"))

local dispatchCheck = t.tuple(
	SignalService.isSignal,
	t.interface({
		type = t.string,
	})
)

local function Dispatch(self, action)
	assert(dispatchCheck(self, action))

	return self.__dispatchHandler(action)
end

return Dispatch
