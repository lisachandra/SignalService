local Symbol = {}

function Symbol.named(name: string?)
    local symbol = newproxy(true)

    getmetatable(symbol).__tostring = function()
        return name or ""
    end

    return symbol
end

return Symbol
