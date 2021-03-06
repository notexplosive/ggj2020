local Scene = require("nx/game/scene")
local State = require("nx/state")
local sceneLayers = require("nx/scene-layers")
local Battery = {}

registerComponent(Battery, "Battery", {"ShipControl", "TimeControlRef"})

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

    if self.quantity / self.max < 0.10 then
        if Assets.sounds["battery-low"]:play() then
            statusLog("Low battery!")
        end
    end

    if self.quantity <= 0 then
        self.quantity = self.max
        uiScene:onDisable()
        sceneLayers:set(4, Scene.fromPath("overlay"))
        State:set("power-failed-first-time")
    end
end

function Battery:calculateUsage()
    local widgetUsage = 0
    for i, widget in uiScene:eachActorWith(Components.Widget) do
        widgetUsage = widgetUsage + widget.Widget:getBatteryUsage()
    end

    local solarPower = 20
    return self.actor.ShipControl:getBatteryUsage() + self.actor.TimeControlRef:getBatteryUsage() +
        self.actor.Laser:getBatteryUsage() +
        self.actor.Nitro:getBatteryUsage() +
        self.actor.MissileLauncher:getBatteryUsage() +
        widgetUsage -
        solarPower
end

function Battery:onKeyPress(key, scancode, wasRelease)
    if key == "[" then
        self.quantity = -1
    end
end

function Battery:getPercent()
    return self.quantity / self.max
end

return Battery
