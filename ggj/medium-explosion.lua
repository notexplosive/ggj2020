local MediumExplosion = {}

registerComponent(MediumExplosion, "MediumExplosion")

function MediumExplosion:awake()
    self.actor:addComponent(Components.SpriteRenderer, "ship-explosion", "all")
    self.actor:addComponent(Components.Lifetime, 1)
    self.actor:setAngle(love.math.random() * math.pi * 2)
end

return MediumExplosion