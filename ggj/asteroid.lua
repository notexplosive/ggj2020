local Asteroid = {}

registerComponent(Asteroid, "Asteroid")

function Asteroid:setup(asteroidSize)
    self.asteroidSize = asteroidSize
    self.health = asteroidSize * asteroidSize
    self.health = asteroidSize
    local collisionSize = 230

    if asteroidSize == 7 then
        self.actor:addComponent(Components.SpriteRenderer, "planetoid")
        collisionSize = 230
    elseif asteroidSize == 6 then
        self.actor:addComponent(Components.SpriteRenderer, "big-rock")
        collisionSize = 32 - 4
    elseif asteroidSize == 5 then
        self.actor:addComponent(Components.SpriteRenderer, "bean-rock")
        collisionSize = 32 - 8
    elseif asteroidSize == 4 then
        self.actor:addComponent(Components.SpriteRenderer, "chunk-rock")
        collisionSize = 32 - 12
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
    
end

function Asteroid:onCollide(other)
    if other.LaserBullet then
        other:destroy()
        self.health = self.health - 1
    end
    if self.health < 1 then
        self.actor:destroy()
    end 
end

function Asteroid:onDestroy()
    self:createExplosion(0,0)

    if self.asteroidSize > 4 then
        for i=1, self.asteroidSize - 3 do
            self:createDebris()
        end
    elseif self.asteroidSize > 1 then
        self:createDebris()
    else
        
    end
end

function Asteroid:createDebris()
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
    actor:addComponent(Components.Asteroid, self.asteroidSize - 1)
    actor.Velocity:set(xDir * 50, yDir * 50)

    self:createExplosion(xDir * offsetMagnitude, yDir * offsetMagnitude)
end

function Asteroid:createExplosion(x, y)
    local actor = self.actor:scene():addActor()
    local offsetVector = self.actor:pos()
    offsetVector = offsetVector + Vector.new(x, y)
    actor:setPos(offsetVector)
    actor:addComponent(Components.Explosion)
end

return Asteroid
