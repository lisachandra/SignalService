--# selene: allow(undefined_variable)
return function()
    local SignalService = require(script.Parent.Parent.SignalService)

    beforeAll(function(context)
        context.signals = {}

        context.addSignal = function(signal)
            context.signals[#context.signals + 1] = signal
        end
    end)

    afterAll(function(context)
        for _, signal in pairs(context.signals) do
            if SignalService.isSignal(signal) then
                signal:Destroy()
            end
        end
    end)
end