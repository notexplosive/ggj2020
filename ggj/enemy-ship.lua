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
    self.actor:addComponent(Components.Solid)
    self:SetVelocityByAngle()
    self.actor:addComponent(Components.EnemyHealth, 1)
    self.actor:addComponent(Components.MissileTargetable)
    self.actor:addComponent(Components.PlayerRef)

    self.chasing = false
    self.hitPlayer = 0
end

function EnemyShip:update(dt)
    local rotateSpeed = 0.9

    if self.hitPlayer > 0 then
        self.hitPlayer = self.hitPlayer - dt
        return
    end

    if self.playerPointer then
        local dirToPlayer = self.playerPointer:pos() - self.actor:pos()
        if self:shouldChasePlayer(dirToPlayer) then
            dirToPlayer = dirToPlayer:normalized()
            self.actor.Velocity:set(dirToPlayer * 120)
            self.actor:setAngle(Vector.angle(dirToPlayer))
        else
            self.actor:setAngle(self.actor:angle() + dt * rotateSpeed)
            self:SetVelocityByAngle()
        end
    else
        self.playerPointer = self.actor.PlayerRef:get()
    end
end

function EnemyShip:shouldChasePlayer(dirToPlayer)
    local distance = dirToPlayer:length()
    if distance < 250 then
        return true
    elseif distance > 500 then
        return false
    else
        return true
    end
end

function EnemyShip:SetVelocityByAngle()
    local angle = self.actor:angle()
    local moveSpeed = 130
    self.actor.Velocity:set(math.cos(angle) * moveSpeed, math.sin(angle) * moveSpeed)
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
