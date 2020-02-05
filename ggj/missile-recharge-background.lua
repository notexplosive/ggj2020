local MissileRechargeBackground = {}

registerComponent(MissileRechargeBackground, "MissileRechargeBackground")

function MissileRechargeBackground:awake()
end

function MissileRechargeBackground:draw(x, y)
    local player = self.actor.PlayerRef:get()
    if player then
        local w, h = self.actor:scene():getDimensions()
        local percent = player.MissileLauncher:cooldownPercent()
        w = w * percent
        love.graphics.setColor(0.5, 1, 0.5, 1 - percent)
        love.graphics.rectangle("fill", 0, 0, w, h)
    end
end

function MissileRechargeBackground:update(dt)
end

return MissileRechargeBackground
