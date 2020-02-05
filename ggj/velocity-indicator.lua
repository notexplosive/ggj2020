local VelocityIndicator = {}

registerComponent(VelocityIndicator, "VelocityIndicator", {"PlayerRef"})

function VelocityIndicator:start()
    self.actor:scene().sceneRenderer.backgroundColor = {0, 0.25, 0}
end

function VelocityIndicator:draw(x, y)
    local player = self.actor.PlayerRef:get()
    if player then
        local velocity = player.Velocity
        local nitro = self.actor.PlayerRef:get().Nitro
        local nitroIsRunning = nitro:get()

        local vec = velocity:get()
        local slowTerminal = nitro:getSlowSpeed()
        local terminalWithNitro = nitro:getFastSpeed()

        local terminal = slowTerminal

        if nitroIsRunning then
            terminal = terminalWithNitro
        end

        local percentVec = vec / terminalWithNitro
        local maxSlowPercent = slowTerminal / terminalWithNitro
        local radius = self.actor:scene().width / 3

        love.graphics.setColor(1, 1, 1, 1)
        local centerPos = Vector.new(self.actor:scene().width / 2, self.actor:scene().height / 2)
        love.graphics.circle("line", centerPos.x, centerPos.y, radius)
        if nitroIsRunning then
            love.graphics.setColor(1, 1, 1, 0.25)
        end
        love.graphics.circle("line", centerPos.x, centerPos.y, maxSlowPercent * radius)
        love.graphics.setColor(1, 1, 1, 1)

        local offsetPos = centerPos + percentVec * radius
        love.graphics.circle("fill", offsetPos.x, offsetPos.y, 5)
        love.graphics.line(centerPos.x, centerPos.y, offsetPos.x, offsetPos.y)
        local directionPos = centerPos + Vector.newPolar(radius, player:angle())
        love.graphics.setColor(0.5, 1, 0.5, 1)
        love.graphics.line(centerPos.x, centerPos.y, directionPos.x, directionPos.y)
    end
end

function VelocityIndicator:update(dt)
end

return VelocityIndicator
