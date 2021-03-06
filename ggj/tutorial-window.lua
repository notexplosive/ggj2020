local State = require("nx/state")
local TutorialWindow = {}

registerComponent(TutorialWindow, "TutorialWindow")

function TutorialWindow:awake()
    EXEC_TUTORIAL = function(flagName, text, confirmText)
        if not State:get("tutorial-" .. flagName) then
            State:set("tutorial-" .. flagName)
            self.actor.visible = true
            local textRenderers = self.actor.SceneRenderer.scene:getAllActorsWith(Components.BoundedTextRenderer)
            textRenderers[1].BoundedTextRenderer.text = text
            if confirmText then
                textRenderers[2].BoundedTextRenderer.text = confirmText or "OK"
            end
        end
    end
    self.actor.visible = false
end

function TutorialWindow:draw()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
end

function TutorialWindow:update(dt)
    gameScene.freeze = self.actor.visible
    backgroundScene.freeze = self.actor.visible
end

return TutorialWindow
