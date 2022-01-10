local strict = require(script:WaitForChild("strict"))

--[[
     A service that allows you to create custom events  
     Github: [https://github.com/zxibs/SignalService](https://github.com/zxibs/SignalService)
]]
local SignalService = strict({
	new = require(script:WaitForChild("new")),
	isSignal = require(script:WaitForChild("isSignal")),
}, "SignalService")

return SignalService
