local WhiteFade = {}

registerComponent(WhiteFade, "WhiteFade")

function WhiteFade:awake()
    self.time = 0
end

function WhiteFade:update(dt)
    self.time = self.time + dt
end

function WhiteFade:draw(x, y)
    local percent = self.time / 3
    love.graphics.setColor(1, 1, 1, percent)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())

    if percent > 1 then
        titleScreen()
    end
end

return WhiteFade
