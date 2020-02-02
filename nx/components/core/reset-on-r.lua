local CloseOnEscape = {}

registerComponent(CloseOnEscape, "CloseOnEscape")

function CloseOnEscape:onKeyPress(key)
    if key == "r" then
        startGame()
    end
end

return CloseOnEscape
