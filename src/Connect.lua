local strict = require(script.Parent.strict)

--[[

]]
---@param self Signal
---@param callback function
---@return Connection
local function Connect(self, callback)
	local callbackId = #self.__callbacks + 1
	table.insert(self.__callbacks, callbackId, callback)

	--[[
        
    ]]
	---@class Connection
	local Connection = {
		__signal = self,
		__callbackId = callbackId,

		Connected = true,

		Disconnect = require(script.Parent.Disconnect),
	}

	return strict(Connection, "Connection")
end

return Connect
