local WhiteFade = {}

registerComponent(WhiteFade, "WhiteFade")

function WhiteFade:setup(targetLevel, r, g, b)
    self.targetLevel = targetLevel
    self.color = {r, g, b}
end

function WhiteFade:awake()
    self.time = 0
    self.color = {1, 1, 1}
end

function WhiteFade:update(dt)
    self.time = self.time + dt
end

function WhiteFade:draw(x, y)
    local percent = self.time / 3
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], percent)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())

    if percent > 1 then
        if not self.targetLevel then
            titleScreen()
            return
        end

        if self.targetLevel == "end" then
            credits()
            return
        end

        loadLevel(self.targetLevel)
    end
end

return WhiteFade
