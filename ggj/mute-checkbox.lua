local MuteCheckbox = {}

registerComponent(MuteCheckbox, "MuteCheckbox")

local defaultVol = love.audio.getVolume()

function MuteCheckbox:Checkbox_onStateChange(msg, state)
    if state then
        love.audio.setVolume(0)
    else
        love.audio.setVolume(defaultVol)
    end
end

function MuteCheckbox:awake()
    if love.audio.getVolume() == 0 then
        self.actor.Checkbox.state = true
    end
end

function MuteCheckbox:update(dt)
end

return MuteCheckbox
