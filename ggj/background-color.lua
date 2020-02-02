local BackgroundColor = {}

registerComponent(BackgroundColor, "BackgroundColor")

function BackgroundColor:setup(r, g, b, a)
    self.color = {r, g, b, a or 1}
end

function BackgroundColor:start()
    assert(self.actor:scene().sceneRenderer, "requires to be in a sceneRenderer'd subscene")
    self.actor:scene().sceneRenderer.backgroundColor = unpack(self.color)
end

function BackgroundColor:draw(x, y)
end

function BackgroundColor:update(dt)
end

return BackgroundColor
