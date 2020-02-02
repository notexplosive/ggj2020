local CloseOnEscape = {}

registerComponent(CloseOnEscape, "CloseOnEscape")

function CloseOnEscape:onKeyPress(key)
    if key == "r" then
        loadLevel("game")
    end
end

return CloseOnEscape
