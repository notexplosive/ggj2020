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
    local widgetUsage = 0
    for i, widget in uiScene:eachActorWith(Components.Widget) do
        widgetUsage = widgetUsage + widget.Widget:getBatteryUsage()
    end

    local solarPower = 10
    return self.actor.PlayerControl:getBatteryUsage() + self.actor.TimeControlRef:getBatteryUsage() +
        self.actor.Laser:getBatteryUsage() +
        widgetUsage -
        solarPower
end

function Battery:getPercent()
    return self.quantity / self.max
end

return Battery
