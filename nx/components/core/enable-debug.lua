local EnableDebug = {}

registerComponent(EnableDebug, "EnableDebug")

function EnableDebug:onKeyPress(key, scancode, wasRelease)
    if key == "`" and not wasRelease and ALLOW_DEBUG then
        DEBUG = not DEBUG
    end
end

return EnableDebug
