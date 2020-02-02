local PlanetoidExplosion = {}

registerComponent(PlanetoidExplosion, "PlanetoidExplosion")

function PlanetoidExplosion:awake()
    self.actor:addComponent(Components.SpriteRenderer, "planetoid-explosion", "all")
    self.actor:addComponent(Components.Lifetime, 1)
    self.actor:setAngle(love.math.random() * math.pi * 2)
end

return PlanetoidExplosion