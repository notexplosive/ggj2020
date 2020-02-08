local ToggleFullscreenWithKeyboard = {}

registerComponent(ToggleFullscreenWithKeyboard, "ToggleFullscreenWithKeyboard")

function ToggleFullscreenWithKeyboard:awake()
    self.actor:addComponentSafe(Components.TrackModifierKeys)
end

function ToggleFullscreenWithKeyboard:draw(x, y)
end

function ToggleFullscreenWithKeyboard:onKeyPress(key, scancode, wasRelease)
    if not wasRelease then
        if key == "return" and self.actor.TrackModifierKeys.alt then
            love.window.setFullscreen(not love.window.getFullscreen())
        end
    end
end

return ToggleFullscreenWithKeyboard
