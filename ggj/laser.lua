local Laser = {}

registerComponent(Laser, "Laser")

function Laser:awake()
    self.firing = false
    self.fireTimer = 0
    self.singleShotDrain = love.timer.getTime()
end

function Laser:getBatteryUsage()
    if love.timer.getTime() < self.singleShotDrain then
        return 14
    elseif self.firing then
        return 7
    end
    return 0
end

function Laser:update(dt)
    self.fireTimer = self.fireTimer - dt
    if self.firing then
        self:fireShot()
    end
end

function Laser:set(b)
    self.firing = b
end

function Laser:singleShot()
    self.singleShotDrain = love.timer.getTime() + 0.1
    self:fireShot()
end

function Laser:fireShot()
    if self.fireTimer < 0 then
        self.fireTimer = 0.1
        local shot = self.actor:scene():addActor()
        shot:setPos(self.actor:pos() + Vector.newPolar(16, self.actor:angle()))
        shot:addComponent(
            Components.Velocity,
            Vector.newPolar(700 + self.actor.Velocity:get():length(), self.actor:angle())
        )
        shot:addComponent(Components.LaserBullet, self.actor)
    end
end

return Laser
