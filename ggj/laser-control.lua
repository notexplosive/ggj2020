local LaserControl = {}

registerComponent(LaserControl, "LaserControl")

function LaserControl:setup()
end

function LaserControl:awake()
end

function LaserControl:draw(x, y)
end

function LaserControl:update(dt)
    local enabled = self.actor.Checkbox.state
    local player = self.actor.PlayerRef:get()
    if player then
        player.Laser:set(enabled)
    end
end

return LaserControl
