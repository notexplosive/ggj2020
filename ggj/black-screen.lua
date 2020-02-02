local BlackScreen = {}

registerComponent(BlackScreen, "BlackScreen")

function BlackScreen:draw(x, y)
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
end

function BlackScreen:onMouseMove(dt)
    self.actor:scene():consumeHover()
end

return BlackScreen
