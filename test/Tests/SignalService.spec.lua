--# selene: allow(undefined_variable)
return function()
    local Packages = script.Parent.Parent:WaitForChild("Packages")
    local SignalService = require(Packages:WaitForChild("SignalService"))

    describe("isSignal", function()
        it("should be true", function()
            local signalObject = setmetatable({}, {
                __tostring = function()
                    return "Signal"
                end
            })

            expect(SignalService.isSignal(signalObject)).to.be.equal(true)
        end)

        it("should be false", function()
            local fakeSignalObject = {}
            expect(SignalService.isSignal(fakeSignalObject)).to.be.equal(false)
        end)
    end)

    describe("new", function()
        it("should create a new signal", function(context)
            local signalObject = SignalService.new()
            context.addSignal(signalObject)

            expect(SignalService.isSignal(signalObject)).to.be.equal(true)
        end)
    end)

    describe("destroy", function()
        it("should destroy the signal and disconnect all connections", function(context)
            local signalObject = SignalService.new()

            local connection = signalObject:Connect(function() end)
            local connection1 = signalObject:Connect(function() end)

            signalObject:Destroy()
            expect(signalObject.__callbacks[connection1.__id]).to.be.equal(nil)
            expect(signalObject.__callbacks[connection.__id]).to.be.equal(nil)
            expect(SignalService.isSignal(signalObject)).to.be.equal(false)
        end)
    end)

    describe("connect", function()
        it("should return a connection and add a callback handler", function(context)
            local signalObject = SignalService.new()
            context.addSignal(signalObject)

            local connection = signalObject:Connect(function() end)

            expect(signalObject.__callbacks[connection.__id]).to.be.a("function")
            expect(signalObject.__connections[connection.__id]).to.be.a("table")
            expect(SignalService.isSignal(connection)).to.be.equal(true)
        end)
    end)

    describe("fire", function()
        it("should fire the signal with the correct arguments", function(context)
            local signalObject = SignalService.new()
            local stringArg
            context.addSignal(signalObject)

            signalObject:Connect(function(arg1)
                stringArg = arg1
            end)

            signalObject:Fire("correct!")
            expect(stringArg).to.be.equal("correct!")
        end)
    end)

    describe("disconnect", function()
        it("should disconnect the connection and remove all references to it", function(context)
            local signalObject = SignalService.new()
            context.addSignal(signalObject)

            local connection = signalObject:Connect(function() end)

            connection:Disconnect()
            expect(signalObject.__callbacks[connection.__id]).to.be.equal(nil)
            expect(signalObject.__connections[connection.__id]).to.be.equal(nil)
        end)
    end)

    describe("disconnectAll", function()
        it("should disconnect all connections", function(context)
            local signalObject = SignalService.new()
            context.addSignal(signalObject)

            local connection = signalObject:Connect(function() end)

            local connection1 = signalObject:Connect(function() end)

            signalObject:DisconnectAll()
            expect(signalObject.__callbacks[connection.__id]).to.be.equal(nil)
            expect(signalObject.__connections[connection.__id]).to.be.equal(nil)

            expect(signalObject.__callbacks[connection1.__id]).to.be.equal(nil)
            expect(signalObject.__connections[connection1.__id]).to.be.equal(nil)
        end)
    end)

    describe("wait", function()
        it("should yield the thread then when fired, resume with the correct arguments", function(context)
            local signalObject = SignalService.new()
            local stringArg, stringArg1
            context.addSignal(signalObject)
            
            coroutine.wrap(function()
                stringArg, stringArg1 = signalObject:Wait()
            end)()

            signalObject:Fire("this", "is correct")
        
            expect(stringArg).to.be.equal("this")
            expect(stringArg1).to.be.equal("is correct")
        end)
    end)

    describe("onDispatch", function()
        it("should add a new dispatch", function(context)
            local signalObject = SignalService.new()
            context.addSignal(signalObject)

            signalObject:onDispatch({
                NewDispatch = function() end
            })

            expect(signalObject.__dispatchHandler.NewDispatch).to.be.a("function")
        end)
    end)

    describe("dispatch", function()
        it("should dispatch with the correct arguments", function(context)
            local signalObject = SignalService.new()
            local stringArg
            context.addSignal(signalObject)

            signalObject:onDispatch({
                NewDispatch = function(action)
                        stringArg = action.stringArg
                    end
                }
            )
                
            signalObject:Dispatch({
                type = "NewDispatch",
                stringArg = "This is a dispatch running"
            })

            expect(stringArg).to.be.equal("This is a dispatch running")
        end)
    end)
end