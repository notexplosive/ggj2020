local FullscreenCheckbox = {}

registerComponent(FullscreenCheckbox, "FullscreenCheckbox")

function FullscreenCheckbox:update()
    self.actor.Checkbox.state = love.window.getFullscreen()
end

function FullscreenCheckbox:Checkbox_onStateChange(message, state)
    love.window.setFullscreen(state)
end

return FullscreenCheckbox
