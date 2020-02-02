local BatteryIndicator = {}

registerComponent(BatteryIndicator, "BatteryIndicator", {"TextRenderer", "PlayerRef"})

function BatteryIndicator:setup()
end

function BatteryIndicator:awake()
    local sp = self.actor:addComponent(Components.SpriteRenderer, "battery", "all", 2)
    --sp:setLoop(false)
end

function BatteryIndicator:draw(x, y)
    love.graphics.circle("fill", x, y, 5)
end

function BatteryIndicator:update(dt)
    local player = self.actor.PlayerRef:get()
    if player then
        local status = math.floor(player.Battery:getPercent() * 100) .. ", " .. player.Battery:calculateUsage()
        self.actor.TextRenderer.text = status
        self.actor.PlayHead:set((self.actor.PlayHead.maxTime-0.1)*player.Battery:getPercent())
    end
end

return BatteryIndicator
