local SignalService = require(script.Parent)

local function onDispatchCheck(self, dispatchHandlers)
    if type(dispatchHandlers) ~= "table" then
        return false, "bad argument #2, (dictionary expected got " .. type(dispatchHandlers) ..")" .. debug.traceback()
    end

    if SignalService.isSignal(self) then
        for i, v in pairs(dispatchHandlers) do
            if type(i) == "number" then
                return false, "bad argument #2, (dictionary expected got array)" .. debug.traceback()
            end

            if type(v) ~= "function" then
                return false, "bad argument #2, in key " .. i .. "(function expected got " .. type(v) .. ")".. debug.traceback()
            end
        end

        return true
    else
        return SignalService.isSignal(self)
    end
end

local function onDispatch(self, dispatchHandlers)
	assert(onDispatchCheck(self, dispatchHandlers))

	rawset(
		self,
		"__dispatchHandler",
		setmetatable(dispatchHandlers, {
			__call = function(_self, action)
				local actionType = action.type
				action.type = nil

				return self.__dispatchHandler[actionType](action)
			end,
		})
	)
end

return onDispatch
