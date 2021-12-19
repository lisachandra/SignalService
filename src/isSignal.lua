--[[

]]
---@param signalObject Signal | Connection
---@return boolean
local function isSignal(signalObject)
	local bool = signalObject.__type and true or false

	return bool
end

return isSignal
