local SignalService = require(script.Parent)

local function ClearTableDescendants(tableToClear)
	for index, value in pairs(tableToClear) do
		if type(value) == "table" then
			setmetatable(tableToClear[index], { __mode = "kv" })
			ClearTableDescendants(tableToClear[index])
		end
	end
end

local function Destroy(self)
	if not SignalService.isSignal(self) then
		local message = "Expected `:` not `.` while calling function Fire"

		error(message, 2)
	end

	self:DisconnectAll()
	ClearTableDescendants(self)
	setmetatable(self, { __mode = "kv" })
end

return Destroy
