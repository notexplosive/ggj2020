local Explosion = {}

registerComponent(Explosion, "Explosion")

function Explosion:awake()
    self.actor:addComponent(Components.SpriteRenderer, "explosion", "all")
    self.actor:addComponent(Components.Lifetime, 1)
    self.actor:setAngle(love.math.random() * math.pi * 2)
end

return Explosion