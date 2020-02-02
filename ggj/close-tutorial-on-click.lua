local CloseTutorialOnClick = {}

registerComponent(CloseTutorialOnClick, "CloseTutorialOnClick")

function CloseTutorialOnClick:Clickable_onClickOn(button)
    if button == 1 then
        self.actor:scene().sceneRenderer.actor.visible = false
    end
end

return CloseTutorialOnClick
