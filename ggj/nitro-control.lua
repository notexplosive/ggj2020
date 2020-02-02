local NitroControl = {}

registerComponent(NitroControl, "NitroControl")

function NitroControl:update(dt)
    local enabled = self.actor.Checkbox.state
    local player = self.actor.PlayerRef:get()
    if player then
        player.Nitro:set(enabled)
    end
end

function NitroControl:Checkbox_onStateChange(m, b)
    if b then
        Assets.sounds.nitro:play()
    else
        Assets.sounds.nitro:stop()
    end
end

function NitroControl:onDisable()
    self.actor.Checkbox.state = false

    local player = self.actor.PlayerRef:get()
    if player then
        player.Nitro:set(false)
    end
end

return NitroControl
