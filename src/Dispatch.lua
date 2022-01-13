local SignalService = require(script.Parent)

local function dispatchCheck(self, action)
    if SignalService.isSignal(self) then
        if type(action) ~= "table" then
            return false, "bad argument #2 (table expected, got ".. type(action) ..")" .. debug.traceback()
        end

        if type(rawget(action, "type")) ~= "string" then
            return false, "bad argument #2 (type (string) field expected, got " .. type(rawget(action, "type")) .. ")" .. debug.traceback()
        end

        if not rawget(self, "__dispatchHandler") then
            return false, "error in function Dispatch (You must add a dispatch handler using onDispatch before dispatching an action!)" .. debug.traceback()
        end

		return true
	else
		return false, "Expected `:` not `.` while calling function Dispatch" .. debug.traceback()
    end
end

local function Dispatch(self, action)
	assert(dispatchCheck(self, action))

	return self.__dispatchHandler(action)
end

return Dispatch
