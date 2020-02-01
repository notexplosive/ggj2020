local VelocityIndicator = {}

registerComponent(VelocityIndicator, "VelocityIndicator", {"PlayerRef"})

function VelocityIndicator:awake()
end

function VelocityIndicator:draw(x, y)
    local player = self.actor.PlayerRef:get()
    if player then
        local velocity = player.Velocity
        local vec = velocity:get()
        local terminal = velocity:getTerminalSpeed()
        local percentVec = vec / terminal
        local radius = self.actor:scene().width / 2

        love.graphics.setColor(1, 1, 1, 1)
        local centerPos = Vector.new(self.actor:scene().width / 2, self.actor:scene().height / 2)
        love.graphics.circle("line", centerPos.x, centerPos.y, radius)
        love.graphics.circle("line", centerPos.x, centerPos.y, 10)
        local offsetPos = centerPos + percentVec * radius
        love.graphics.circle("line", offsetPos.x, offsetPos.y, 10)
        love.graphics.line(centerPos.x, centerPos.y, offsetPos.x, offsetPos.y)
    end
end

function VelocityIndicator:update(dt)
end

return VelocityIndicator
