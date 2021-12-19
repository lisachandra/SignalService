local strict = require(script.Parent.strict)

--[[

]]
---@return Signal
local function new()
	--[[
        
    ]]
	---@class Signal
	local Signal = {
		__callbacks = {},
		__waiters = {},

		Fire = require(script.Parent.Fire),
		Wait = require(script.Parent.Wait),
		Connect = require(script.Parent.Connect),
		Destroy = require(script.Parent.Destroy),
		DisconnectAll = require(script.Parent.DisconnectAll),
	}

	return strict(Signal, "Signal")
end

return new
