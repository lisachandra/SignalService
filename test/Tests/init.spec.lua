--# selene: allow(undefined_variable)
return function()
     local Packages = script.Parent.Parent:WaitForChild("Packages")
     local SignalService = require(Packages:WaitForChild("SignalService"))

     beforeAll(function(context)
          context.signalsToDestroy = {}

          context.addSignal = function(signal)
               context.signalsToDestroy[#context.signalsToDestroy + 1] = signal
          end
     end)

     afterAll(function(context)
          for _, signal in pairs(context.signalsToDestroy) do
               if SignalService.isSignal(signal) then
                    signal:Destroy()
               end
          end
     end)
end