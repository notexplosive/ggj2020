local SpawnStars = {}

registerComponent(SpawnStars, "SpawnStars", {"PlayerRef"})

function SpawnStars:setup(layer)
    self.layer = layer
    local width, height = love.graphics.getDimensions()
    for i = 1, 100 do
        local actor = self.actor:scene():addActor()
        local x = love.math.random(-width / 2, width / 2)
        local y = love.math.random(-height / 2, height / 2)
        actor:setPos(x, y)
        local sp = actor:addComponent(Components.SpriteRenderer, "star1", "all")
        actor.PlayHead.time = love.math.random(0, actor.PlayHead.maxTime * 10) / 10
        actor:addComponent(Components.Parent, self.actor)
        actor.SpriteRenderer.color[4] = 1 / self.layer
    end
end

function SpawnStars:update(dt)
    local player = self.actor.PlayerRef:get()
    if player then
        local vel = player.Velocity:get() * dt
        for i, star in self.actor.Children:each() do
            star:move(-vel / (100 * self.layer / 2))

            local x, y = star:pos():xy()
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

            star:setPos(x, y)
        end
    end
end

return SpawnStars
