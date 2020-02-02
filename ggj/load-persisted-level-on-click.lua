local State = require("nx/state")
local LoadPersistedLevelOnClick = {}

registerComponent(LoadPersistedLevelOnClick, "LoadPersistedLevelOnClick")

function LoadPersistedLevelOnClick:setup()
end

function LoadPersistedLevelOnClick:awake()
    if not State:get("continue-level") then
        self.actor:destroy()
    end
end

function LoadPersistedLevelOnClick:draw(x, y)
end

function LoadPersistedLevelOnClick:Clickable_onClickOn()
    loadLevel(State:get("continue-level") or "game")
end

return LoadPersistedLevelOnClick
