local SceneBorder = {}

registerComponent(SceneBorder, "SceneBorder")

function SceneBorder:setup()
end

function SceneBorder:awake()
end

function SceneBorder:draw(x, y)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", 0, 0, self.actor:scene():getDimensions())
end

function SceneBorder:update(dt)
end

return SceneBorder
