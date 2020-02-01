local CollideRadius = {}

registerComponent(CollideRadius, "CollideRadius")

function CollideRadius:setup(radius)
    self.radius = radius
end

function CollideRadius:draw(x, y)
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("line", x, y, self.radius)
end

function CollideRadius:get()
    return self.radius
end

return CollideRadius
