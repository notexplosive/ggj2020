local Battery = {}

registerComponent(Battery, "Battery", {"PlayerControl", "TimeControlRef"})

function Battery:setup(quantity)
    self.quantity = quantity
    self.max = quantity
end

function Battery:update(dt)
    local delta = self:calculateUsage()
    self.quantity = self.quantity - delta * dt

    if self.quantity > self.max then
        self.quantity = self.max
    end
end

function Battery:calculateUsage()
    return self.actor.PlayerControl:getBatteryUsage() + self.actor.TimeControlRef:getBatteryUsage() - 5
end

function Battery:getPercent()
    return self.quantity / self.max
end

return Battery
