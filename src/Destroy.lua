local function ClearTableDescendants(tableToClear)
	for index, value in pairs(tableToClear) do
		if typeof(value) == "table" then
			table.clear(tableToClear[index])
			ClearTableDescendants(tableToClear[index])
		end
	end
end

--[[

]]
---@param self Signal
local function Destroy(self)
	ClearTableDescendants(self)
	table.clear(self)
end

return Destroy
