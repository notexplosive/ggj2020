local EnemyShip = {}

registerComponent(EnemyShip, "EnemyShip")

function EnemyShip:awake()
    self.actor:addComponent(Components.SpriteRenderer, "enemy-ship")
    self.actor:setAngle(love.math.random() * math.pi * 2)

    local collisionSize = 16
    self.actor:addComponent(Components.CollideRadius, collisionSize)
    self.actor:addComponent(Components.ShowOnMap, {0.9, 0.4, 0.4}, 64)
    self.actor:addComponent(Components.Velocity)
    self.actor:addComponent(Components.StayWithinBounds)
    self.actor:addComponent(Components.ShipControl)
    self.actor:addComponent(Components.EnemyAI)
    self.actor:addComponent(Components.Solid)
    self.actor:addComponent(Components.EnemyHealth, 4)
    self.actor:addComponent(Components.MissileTargetable)
    self.actor:addComponent(Components.PlayerRef)

    self.chasing = false
    self.hitPlayer = 0
end

function EnemyShip:onCollide(other)
    if other.Player then
        self.hitPlayer = 1.5
    end
end

function EnemyShip:onDestroy()
    self:createExplosion(0, 0)

    local sound = Assets.sounds.boom:get()
    sound:setVolume(1.2)
    sound:play()

    for j = 1, 3 do
        for i = 1, 3 do
            local xOff = love.math.random() * 4 - 12 + i * 10
            local yOff = love.math.random() * 4 - 12 + j * 10
            self:createScrap(xOff, yOff)
        end
    end
end

function EnemyShip:createScrap(x, y)
    local offsetVector = self.actor:pos()
    offsetVector = offsetVector + Vector.new(x, y)
    local scrapActor = self.actor:scene():addActor()
    scrapActor:setPos(offsetVector)
    scrapActor:addComponent(Components.Scrap)
end

function EnemyShip:createExplosion(x, y)
    local actor = self.actor:scene():addActor()
    local offsetVector = self.actor:pos()
    offsetVector = offsetVector + Vector.new(x, y)
    actor:setPos(offsetVector)
    actor:addComponent(Components.Explosion)
end

return EnemyShip
