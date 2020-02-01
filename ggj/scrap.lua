local Scrap = {}

registerComponent(Scrap, "Scrap")

function Scrap:awake()
    self.actor:addComponent(Components.SpriteRenderer, "metal-gear", "all")
end

return Scrap
