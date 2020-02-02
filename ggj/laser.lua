local Laser = {}

registerComponent(Laser, "Laser")

function Laser:awake()
    self.firing = false
    self.fireTimer = 0
end

function Laser:getBatteryUsage()
    if self.firing then
        return 7
    end
    return 0
end

function Laser:update(dt)
    self.fireTimer = self.fireTimer - dt
    if self.firing then
        if self.fireTimer < 0 then
            self.fireTimer = 0.1
            local shot = self.actor:scene():addActor()
            shot:setPos(self.actor:pos() + Vector.newPolar(16, self.actor:angle()))
            shot:addComponent(Components.Velocity, Vector.newPolar(700, self.actor:angle()))
            shot:addComponent(Components.CircleRenderer, 5, {1, 0, 0})
            shot:addComponent(Components.LaserBullet)
        end
    end
end

function Laser:set(b)
    self.firing = b
end

return Laser
