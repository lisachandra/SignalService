--[[

]]
---@param self Connection
local function Disconnect(self)
	self.__signal.__callbacks[self.__callbackId] = nil
end

return Disconnect
