local Stargate = {}

registerComponent(Stargate, "Stargate")

function Stargate:awake()
    self.actor:addComponent(Components.SpriteRenderer, "stargate", "inactive")
end

return Stargate