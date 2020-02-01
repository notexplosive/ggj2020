local ShowOnMap = {}

registerComponent(ShowOnMap, "ShowOnMap")

function ShowOnMap:setup(color, radius)
    self.radius = radius
    self.color = color
end

function ShowOnMap:drawMapIcon(x, y, scale)
    love.graphics.setColor(self.color or {1, 1, 1, 1})
    local radius = 5
    if self.radius then
        radius = self.radius * scale
    end
    love.graphics.circle("fill", x, y, radius)
end

return ShowOnMap
