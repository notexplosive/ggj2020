local SpawnRandomShit = {}

registerComponent(SpawnRandomShit, "SpawnRandomShit")

function SpawnRandomShit:setup(count, width, height)
    for i = 1, count do
        local x = love.math.random(-width, width)
        local y = love.math.random(-height, height)
        local act = self.actor:scene():addActor()
        act:setPos(x, y)
        --act:addComponent(Components.CircleRenderer, 10)
        local sp = act:addComponent(Components.SpriteRenderer, "star1", "all")
        act.PlayHead.time = love.math.random(0, act.PlayHead.maxTime)
    end
end

function SpawnRandomShit:awake()
end

function SpawnRandomShit:draw(x, y)
end

function SpawnRandomShit:update(dt)
end

return SpawnRandomShit
