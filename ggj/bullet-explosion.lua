local BulletExplosion = {}

registerComponent(BulletExplosion, "BulletExplosion")

function BulletExplosion:awake()
    self.actor:addComponent(Components.SpriteRenderer, "bullet-explosion", "all")
    self.actor:addComponent(Components.Lifetime, 1)
    self.actor:setAngle(love.math.random() * math.pi * 2)
end

return BulletExplosion