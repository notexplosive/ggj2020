local MissileLauncher = {}

registerComponent(MissileLauncher, "MissileLauncher")

local missileCooldown = 15

function MissileLauncher:awake()
    self.cooldown = 0
end

function MissileLauncher:draw(x, y)
end

function MissileLauncher:update(dt)
    if self.cooldown > 0 then
        self.cooldown = self.cooldown - dt
    end
end

function MissileLauncher:shoot()
    if self.cooldown <= 0 then
        local missile = self.actor:scene():addActor()
        missile:setPos(self.actor:pos())
        missile:setAngle(self.actor:angle())
        missile:addComponent(Components.Velocity, self.actor.Velocity:reverseSetup())
        missile:addComponent(Components.Missile)

        self.cooldown = missileCooldown
    end
end

function MissileLauncher:cooldownPercent()
    return 1 - self.cooldown / missileCooldown
end

function MissileLauncher:getBatteryUsage()
    if self.cooldown > 0 then
        return 10
    else
        return 0
    end
end

return MissileLauncher
