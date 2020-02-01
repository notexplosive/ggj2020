local ResourceIndicator = {}

registerComponent(ResourceIndicator, "ResourceIndicator", {"TextRenderer", "PlayerRef"})

function ResourceIndicator:setup()
end

function ResourceIndicator:awake()
end

function ResourceIndicator:draw(x, y)
end

function ResourceIndicator:update(dt)
    local player = self.actor.PlayerRef:get()
    if player then
        self.actor.TextRenderer.text = player.Inventory:getScrap()
    end
end

return ResourceIndicator
