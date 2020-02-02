local WhiteBG = {}

registerComponent(WhiteBG, "WhiteBG")

function WhiteBG:setup()
end

function WhiteBG:awake()
    self.time = 0
end

function WhiteBG:draw(x, y)
    love.graphics.setColor(1, 1, 1, 1 - self.time / 1)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())

    if self.time < 0 then
        self.actor:destroy()
    end
end

function WhiteBG:update(dt)
    self.time = self.time + dt
end

return WhiteBG
