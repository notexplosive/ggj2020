local Asteroid = {}

registerComponent(Asteroid, "Asteroid")

function Asteroid:setup(asteroidSize)
    self.asteroidSize = asteroidSize
    local collisionSize = 230
    local health = 1

    if asteroidSize == 7 then
        self.actor:addComponent(Components.SpriteRenderer, "planetoid")
        collisionSize = 230
        health = 8
    elseif asteroidSize == 6 then
        self.actor:addComponent(Components.SpriteRenderer, "big-rock")
        collisionSize = 32 - 4
        health = 4
    elseif asteroidSize == 5 then
        self.actor:addComponent(Components.SpriteRenderer, "bean-rock")
        collisionSize = 32 - 8
        health = 3
    elseif asteroidSize == 4 then
        self.actor:addComponent(Components.SpriteRenderer, "chunk-rock")
        collisionSize = 32 - 12
        health = 2
    elseif asteroidSize == 3 then
        self.actor:addComponent(Components.SpriteRenderer, "just-rock")
        collisionSize = 32 - 17
    elseif asteroidSize == 2 then
        self.actor:addComponent(Components.SpriteRenderer, "smol-rock")
        collisionSize = 32 - 23
    else
        self.actor:addComponent(Components.SpriteRenderer, "smol-smol-rock")
        collisionSize = 32 - 26
    end

    self.actor:addComponent(Components.CollideRadius, collisionSize)
    self.actor:addComponent(Components.ShowOnMap, {1, 1, 0}, collisionSize)
    self.actor:addComponent(Components.Velocity)
    self.actor:addComponent(Components.StayWithinBounds)
    self.actor:addComponent(Components.Solid)
    self.actor:addComponent(Components.EnemyHealth, health)

    -- self.actor:addComponent(Components.BoundingBox)
    -- self.actor:addComponent(Components.Hoverable)
    -- self.actor:addComponent(Components.HoverableRenderer)
    -- self.actor:addComponent(Components.Clickable)
    -- self.actor:addComponent(Components.DestroyOnClick)
end

function Asteroid:onDestroy()
    self:createExplosion(0, 0)
    if self.asteroidSize == 7 then
        for i = 1, self.asteroidSize - 2 do
            self:createDebris(i + 1)
        end
        self:createDebris(6)
    elseif self.asteroidSize > 3 then
        for i = 1, self.asteroidSize - 2 do
            self:createDebris(i + 1)
        end
    elseif self.asteroidSize > 4 then
        self:createDebris(love.math.random(1, 4))
    elseif self.asteroidSize > 1 then
        for i = 1, self.asteroidSize do
            self:createScrap(-10 + i * 10, love.math.random() * 10 - 5)
        end
    else
        self:createScrap(0, 0)
    end
end

function Asteroid:createScrap(x, y)
    local offsetVector = self.actor:pos()
    offsetVector = offsetVector + Vector.new(x, y)
    local scrapActor = self.actor:scene():addActor()
    scrapActor:setPos(offsetVector)
    scrapActor:addComponent(Components.Scrap)
end

function Asteroid:createDebris(asteroidSize)
    local xDir = love.math.random() * 2 - 1
    local yDir = love.math.random() * 2 - 1
    local offsetMagnitude = 16
    if self.asteroidSize == 7 then
        offsetMagnitude = 170
    end

    local offsetVector = self.actor:pos()
    offsetVector = offsetVector + (Vector.new(xDir, yDir) * offsetMagnitude)

    local actor = self.actor:scene():addActor()
    actor:setPos(offsetVector)
    actor:addComponent(Components.Asteroid, asteroidSize)
    actor.Velocity:set(xDir * 50, yDir * 50)
end

function Asteroid:createExplosion(x, y)
    local sound = Assets.sounds.boom:get()
    sound:setVolume(1.2)
    sound:play()

    local actor = self.actor:scene():addActor()
    local offsetVector = self.actor:pos()
    offsetVector = offsetVector + Vector.new(x, y)
    actor:setPos(offsetVector)
    if self.asteroidSize == 7 then
        actor:addComponent(Components.PlanetoidExplosion)
    else
        actor:addComponent(Components.Explosion)
    end
end

return Asteroid
