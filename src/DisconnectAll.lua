--[[

]]
---@param self Signal
local function DisconnectAll(self)
	for index, _ in pairs(self.__callbacks) do
		self.__callbacks[index] = nil
	end
end

return DisconnectAll
