local LaserControl = {}

registerComponent(LaserControl, "LaserControl")

function LaserControl:update(dt)
    local enabled = self.actor.Checkbox.state
    local player = self.actor.PlayerRef:get()
    if player then
        player.Laser:set(enabled)
    end
end

function LaserControl:onDisable()
    self.actor.Checkbox.state = false
end

return LaserControl
