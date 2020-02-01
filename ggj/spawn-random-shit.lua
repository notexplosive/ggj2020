local SpawnRandomShit = {}

registerComponent(SpawnRandomShit, "SpawnRandomShit")

function SpawnRandomShit:setup(count, width, height)
    for i = 1, count do
        local x = love.math.random(-width, width)
        local y = love.math.random(-height, height)
        local act = self.actor:scene():addActor()
        act:setPos(x, y)
        act:addComponent(Components.CircleRenderer, 10)
    end
end

function SpawnRandomShit:awake()
end

function SpawnRandomShit:draw(x, y)
end

function SpawnRandomShit:update(dt)
end

return SpawnRandomShit
