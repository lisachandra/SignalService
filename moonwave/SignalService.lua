--# selene: allow (unused_variable)

-- SignalService type

--[=[
    @class SignalService
]=]
local SignalService = {}

--[=[
    Creates a new signal
    ```lua
    ---@type Signal -- This is for IntelliSense
    local Signal = SignalService.new()
    ```

    @return Signal
]=]
function SignalService.new() end

--[=[
    Returns true if the passed in signal is a signal, returns false if it's not
    ```lua
    local boolean = SignalService.isSignal(SignalService.new()) -- True
    ```

    @param signalToCheck Signal
    @return boolean
]=]
function SignalService.isSignal(signalToCheck) end

-- Signal type

--[=[
    @class Signal
]=]
local Signal = {}

--[=[
    Fires the signal causing all connected callbacks to fire
    ```lua
    Signal:Connect(function(arg1, boolean, integer)
        print(arg1, tostring(boolean), tostring(integer))
        -- Outputs `Argument1 true 3`
    end)

    Signal:Fire("Argument1", true, 3) -- arguments can be anything you want
    ```

    @param ... any
]=]
function Signal:Fire(...) end

--[=[
    Yields the thread and resumes with it's arguments when the signal is fired
    ```lua
    task.delay(2, function()
        Signal:Fire("it waited!")
    end)

    -- this will yield the thread for approximately 2 seconds
    local randomInteger = Signal:Wait() -- returns "it waited!" 
    ```

    @return any
    @yields
]=]
function Signal:Wait() end

--[=[
    Connects a callback to the signal that will be fired when  
    `<Signal>:Fire()` is called  

    and  

    Returns a connection that can be disconnected by calling  
    `<Connection>:Disconnect()`
    ```lua
    ---@type Connection -- This is for IntelliSense
    local Connection = Signal:Connect(function(arg1, boolean, integer)
        print(arg1, tostring(boolean), tostring(integer))
        -- Outputs `Argument1 true 3`
    end)

    Signal:Fire("Argument1", true, 3)
    ```

    @param callbackFunction fun()
    @return Connection
]=]
function Signal:Connect(callbackFunction) end

--[=[
    Runs `<Signal>:DisconnectAll()` then destroys/cleans the signal for GC
    ```lua
    Signal:Destroy()
    local boolean = SignalService.isSignal(Signal) -- false
    ```
]=]
function Signal:Destroy() end

--[=[
    Similar to [`<Rodux.Store>:dispatch()`](https://roblox.github.io/rodux/api-reference/#storedispatch)
    ```lua
    Signal:onDispatch({
        NEW_DISPATCH = function(action)
            print(action.string) -- This is a dispatch running
        end
    })

    Signal:Dispatch({
        type = "NEW_DISPATCH",
        string = "This is a dispatch running"
    })
    ```

    @param action table
    @return any
]=]
function Signal:Dispatch(action) end

--[=[
    Similar to [`Rodux.createReducer()`](https://roblox.github.io/rodux/api-reference/#roduxcreatereducer)
    ```lua
    Signal:onDispatch({
        NEW_DISPATCH = function(action)
            print(action.string) -- This is a dispatch running
        end
    })

    Signal:Dispatch({
        type = "NEW_DISPATCH", -- the type field is required for dispatching
        string = "This is a dispatch running"
    })
    ```

    @param dispatchHandlers table
]=]
function Signal:onDispatch(dispatchHandlers) end

--[=[
    Runs `<Connection>:Disconnect()` on every connection that is in the signal
    ```lua
    local Connection1 = Signal:Connect(function() end)
    local Connection2 = Signal:Connect(function() end)
    Signal:DisconnectAll()

    print(Connection1.Connected, Connection2.Connected) -- false false
    ```
]=]
function Signal:DisconnectAll() end

-- Connection type

--[=[
    @class Connection
]=]
local Connection = {}

--[=[
    Disconnects/Destroys the connection for GC
    and sets the `Connection.Connected` property to false
    ```lua
    local Connection = Signal:Connect(function() end)
    Connection:Disconnect()

    print(Connection.Connected) -- false
    ```
]=]
function Connection:Disconnect() end
