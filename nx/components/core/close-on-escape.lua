local CloseOnEscape = {}

registerComponent(CloseOnEscape, "CloseOnEscape")

function CloseOnEscape:onKeyPress(key)
    if key == "escape" then
        love.event.quit(0)
    end
end

return CloseOnEscape
