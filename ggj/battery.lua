local Scene = require("nx/game/scene")
local sceneLayers = require("nx/scene-layers")
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

    if self.quantity <= 0 then
        self.quantity = self.max
        uiScene:onDisable()
        sceneLayers:set(4, Scene.fromPath("overlay"))
        EXEC_TUTORIAL(
            "power-failure",
            "Reboot complete!\n\nWhen the StinkBug 0.8 runs out of battery, all systems automatically shut down and the Fission Reactor will jumpstart your battery back to full health.\n\nBe aware of your surroundings when you run out of battery."
        )
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
