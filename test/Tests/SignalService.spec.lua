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
               context.addSignal(signalObject)

               local connection = signalObject:Connect(function()
                    
               end)

               local connection2 = signalObject:Connect(function()
                    
               end)

               signalObject:Destroy()
               expect(connection.Connected).to.be.equal(false)
               expect(connection2.Connected).to.be.equal(false)
               expect(SignalService.isSignal(signalObject)).to.be.equal(false)
          end)
     end)

     describe("connect", function()
          it("should return a connection", function(context)
               local signalObject = SignalService.new()
               context.addSignal(signalObject)

               local connection = signalObject:Connect(function()
                    
               end)

               expect(SignalService.isSignal(connection)).to.be.equal(true)
               expect(connection.Connected).to.be.equal(true)
          end)
     end)

     describe("fire", function()
          it("should fire the signal with the correct arguments", function(context)
               local signalObject = SignalService.new()
               context.addSignal(signalObject)

               signalObject:Connect(function(string)
                    expect(string).to.be.equal("correct!")
               end)

               signalObject:Fire("correct!")
          end)
     end)

     describe("disconnect", function()
          it("should disconnect the connection", function(context)
               local signalObject = SignalService.new()
               context.addSignal(signalObject)

               local connection = signalObject:Connect(function() end)

               connection:Disconnect()
               expect(connection.Connected).to.be.equal(false)
          end)
     end)

     describe("disconnectAll", function()
          it("should disconnect all connections", function(context)
               local signalObject = SignalService.new()
               context.addSignal(signalObject)

               local connection = signalObject:Connect(function() end)

               local connection2 = signalObject:Connect(function() end)

               signalObject:DisconnectAll()
               expect(connection.Connected).to.be.equal(false)
               expect(connection2.Connected).to.be.equal(false)
          end)
     end)

     describe("wait", function()
          it("should yield the thread then when fired, resume with the correct arguments", function(context)
               local signalObject = SignalService.new()
               context.addSignal(signalObject)

               coroutine.wrap(function()
                    os.execute("sleep 1")
                    signalObject:Fire("this", "is correct")
               end)()

               local string, string2 = signalObject:Wait()

               expect(string).to.be.equal("this")
               expect(string2).to.be.equal("is correct")
          end)
     end)

     describe("onDispatch", function()
          it("should add a new dispatch", function(context)
               local signalObject = SignalService.new()
               context.addSignal(signalObject)

               signalObject:onDispatch({
                    NewDispatch = function()
                         
                    end
               })

               expect(signalObject.__dispatchHandler.NewDispatch).to.be.a("function")
          end)
     end)

     describe("dispatch", function()
          it("should dispatch with the correct arguments", function(context)
               local signalObject = SignalService.new()
               context.addSignal(signalObject)

               signalObject:onDispatch({
                    NewDispatch = function(action)
                         print(action.string)
                         expect(action.string).to.be.equal("This is a dispatch running")
                    end
               })

               signalObject:Dispatch({
                    type = "NewDispatch",
                    string = "This is a dispatch running"
               })
          end)
     end)
end