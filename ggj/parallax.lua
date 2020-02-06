local Parallax = {}

registerComponent(Parallax, "Parallax")

function Parallax:setup(layer)
    self.layer = layer
    self.actor:addComponent(Components.PlayerRef)
end

function Parallax:update(dt)
    local player = self.actor.PlayerRef:get()
    if player then
        local vel = player.Velocity:get() * dt
        self.actor:move(-vel / (6 * self.layer / 2))

        local x, y = self.actor:pos():xy()
        if x < 0 then
            x = x + love.graphics.getWidth()
        end

        if y < 0 then
            y = y + love.graphics.getHeight()
        end

        if x > love.graphics.getWidth() then
            x = x - love.graphics.getWidth()
        end

        if y > love.graphics.getHeight() then
            y = y - love.graphics.getHeight()
        end

        self.actor:setPos(x, y)
    end
end

return Parallax
