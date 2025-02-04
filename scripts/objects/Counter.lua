---@class Counter
local Counter, super = Class()

function Counter:init(start_value)
    self.value = start_value or 0
    self.callbacks = {}
end

function Counter:tick()
    self.value = self.value + 1
    if self.callbacks[self.value] then
        for i, v in ipairs(self.callbacks[self.value]) do
            v()
        end
        self.callbacks[self.value] = nil
    end
end

function Counter:after(ticks, callback)
    self.callbacks[self.value + ticks] = self.callbacks[self.value + ticks] or {}
    table.insert(self.callbacks[self.value + ticks], callback)
end

return Counter