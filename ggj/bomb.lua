local Bomb = {}

registerComponent(Bomb, "Bomb")

function Bomb:awake()
    self.actor:addComponent(Components.SpriteRenderer, "bomb")
    collisionSize = 32
    health = 1

    self.actor:addComponent(Components.CollideRadius, collisionSize)
    self.actor:addComponent(Components.Velocity)
    self.actor:addComponent(Components.ShowOnMap, {1, 0, 1}, 128)
    self.actor:addComponent(Components.StayWithinBounds)
    self.actor:addComponent(Components.Solid)
    self.actor:addComponent(Components.EnemyHealth, health)
    self.actor:addComponent(Components.PlayerRef)
end

function Bomb:onCollide(other)
    self.actor:destroy()
    if other.Player then
        other.visible = false
    end
end

function Bomb:onDestroy()
    self:createExplosion(0, 0)

    self.playerPointer = self.actor.PlayerRef:get()
    if self.playerPointer then
        local dirToPlayer = self.playerPointer:pos() - self.actor:pos()
        local distance = dirToPlayer:length()
        if distance < 280 then
            uiScene:addActor():addComponent(Components.WhiteFade)
        end
    end

    local sound = Assets.sounds.boom:get()
    sound:setPitch(1.0)
    sound:play()

    local sound2 = Assets.sounds.spring:get()
    sound2:setPitch(0.1)
    sound2:play()
end

function Bomb:createExplosion(x, y)
    local actor = self.actor:scene():addActor()
    local offsetVector = self.actor:pos()
    offsetVector = offsetVector + Vector.new(x, y)
    actor:setPos(offsetVector)
    actor:addComponent(Components.PlanetoidExplosion)
    actor:addComponent(Components.GameOverExplosion)
end

return Bomb
