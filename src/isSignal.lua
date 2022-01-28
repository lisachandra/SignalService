local function isSignal(signalObject)
	local Type = tostring(signalObject)

	if (Type == "Signal" or Type == "Connection") and type(signalObject) == "table" then
		return true
	else
		return false, "Signal/Connection expected, got " .. typeof(signalObject)
	end
end

return isSignal
