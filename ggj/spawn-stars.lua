local SpawnStars = {}

registerComponent(SpawnStars, "SpawnStars", {"PlayerRef"})

function SpawnStars:setup(layer)
    local width, height = love.graphics.getDimensions()
    for i = 1, 100 do
        local actor = self.actor:scene():addActor()
        local x = love.math.random(-width / 2, width / 2)
        local y = love.math.random(-height / 2, height / 2)
        actor:setPos(x, y)

        
        if (love.math.random() > 0.95) then
            local sp = actor:addComponent(Components.SpriteRenderer, "star4", "all")
        elseif (love.math.random() > 0.85) then
            local sp = actor:addComponent(Components.SpriteRenderer, "star3", "all")
        elseif (love.math.random() > 0.70) then
            local sp = actor:addComponent(Components.SpriteRenderer, "star2", "all")
        else
            local sp = actor:addComponent(Components.SpriteRenderer, "star1", "all")
        end

        actor.PlayHead:pause()
        actor:addComponent(Components.RandomLoopTime, 1, 10)
        --actor.PlayHead.time = love.math.random(0, actor.PlayHead.maxTime * 10) / 10
        actor:addComponent(Components.Parent, self.actor)
        actor.SpriteRenderer.color[4] = 1 / layer
        actor:addComponent(Components.Parallax, layer)
    end
end

function SpawnStars:update(dt)
end

return SpawnStars
