local _waitForGame = game:IsLoaded() or game.Loaded:Wait()

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local SignalService = require(Packages:WaitForChild("SignalService"))

local signalObject = SignalService.new()
local connection = signalObject:Connect(function() end)

local connection2 = signalObject:Connect(function() end)

signalObject:DisconnectAll()

print(connection.Connected)
print(connection2.Connected)
