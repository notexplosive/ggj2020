local PlanetoidExplosion = {}

registerComponent(PlanetoidExplosion, "PlanetoidExplosion")

function PlanetoidExplosion:awake()
    self.actor:addComponent(Components.SpriteRenderer, "planetoid-explosion", "all")
    self.actor:addComponent(Components.Lifetime, 1)
    self.actor:setAngle(love.math.random() * math.pi * 2)

    local sound = Assets.sounds.boom:get()
    sound:setVolume(1.2)
    sound:play()
end

return PlanetoidExplosion
