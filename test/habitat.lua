package.path = package.path .. ";?/init.lua"

local lemur = require("lemur")

local habitat = lemur.habitat.new()
local ReplicatedStorage = habitat.game:GetService("ReplicatedStorage")

local Packages = habitat:loadFromFs("test/Packages")
local TestEZ = habitat:loadFromFs("test/testez/src")
local Tests = habitat:loadFromFs("test/Tests")

Packages.Parent = ReplicatedStorage
TestEZ.Parent = ReplicatedStorage
Tests.Parent = ReplicatedStorage

Packages.Name = "Packages"
TestEZ.Name = "TestEZ"
Tests.Name = "Tests"

local Runner = habitat:loadFromFs("test/runner.server.lua")
habitat:require(Runner)
