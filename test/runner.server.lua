local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TestEZ = ReplicatedStorage.TestEZ

local Tests = ReplicatedStorage.Tests:GetChildren()

for index, TestModule in ipairs(Tests) do
    Tests[index] = require(TestModule)
end

TestEZ.TestBootstrap:run(Tests)
