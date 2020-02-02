local Explosion = {}

registerComponent(Explosion, "Explosion")

function Explosion:awake()
    self.actor:addComponent(Components.SpriteRenderer, "explosion", "all")
    self.actor:addComponent(Components.Lifetime, 1)
end

return Explosion