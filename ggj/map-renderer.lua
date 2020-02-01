local MapRenderer = {}

registerComponent(MapRenderer, "MapRenderer", {"SectorBoundsRef"})

function MapRenderer:start()
    self.actor:scene().sceneRenderer.backgroundColor = {0, 0.25, 0}
end

function MapRenderer:draw(x, y)
    local bounds = self.actor.SectorBoundsRef:get()
    local foo = true
    if bounds:width() < bounds:height() then
        foo = false
    end

    local widgetSize = Size.new(self.actor:scene():getDimensions())
    local boundsSize = Size.new(bounds:wh())

    local boundsRatio = math.min(boundsSize.width / boundsSize.height, boundsSize.height / boundsSize.width)
    local minWidgetEdge = math.min(widgetSize:wh())
    local maxBoundsEdge = math.max(boundsSize:wh())
    local mapSize = boundsSize / maxBoundsEdge * minWidgetEdge
    local mapCanvas = Rect.new(0, 32, mapSize:wh())

    love.graphics.setColor(0, 0.25, 0.5)
    love.graphics.rectangle("fill", mapCanvas:xywh())
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", mapCanvas:xywh())

    for i, actor in gameScene:eachActorWith(Components.ShowOnMap) do
        local x, y = (actor:pos() / maxBoundsEdge * minWidgetEdge + mapCanvas.pos):xy()
        local scale = 1 / maxBoundsEdge * minWidgetEdge

        x = clamp(x, mapCanvas:left(), mapCanvas:right())
        y = clamp(y, mapCanvas:top(), mapCanvas:bottom())
        actor.ShowOnMap:drawMapIcon(x, y, scale)
    end
end

return MapRenderer
