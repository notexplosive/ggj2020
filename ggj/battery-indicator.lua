local BatteryIndicator = {}

registerComponent(BatteryIndicator, "BatteryIndicator", {"TextRenderer", "PlayerRef"})

function BatteryIndicator:setup()
end

function BatteryIndicator:awake()
end

function BatteryIndicator:draw(x, y)
end

function BatteryIndicator:update(dt)
    local player = self.actor.PlayerRef:get()
    if player then
        local status = math.floor(player.Battery:getPercent() * 100) .. ", " .. player.Battery:calculateUsage()
        self.actor.TextRenderer.text = status
    end
end

return BatteryIndicator
