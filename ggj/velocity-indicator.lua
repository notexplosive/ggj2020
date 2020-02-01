local VelocityIndicator = {}

registerComponent(VelocityIndicator, "VelocityIndicator", {"PlayerRef"})

function VelocityIndicator:awake()
end

function VelocityIndicator:draw(x, y)
    local player = self.actor.PlayerRef:get()
    if player then
        love.graphics.print(player.Velocity:get():length())
    end
end

function VelocityIndicator:update(dt)
end

return VelocityIndicator
