local MissileButton = {}

registerComponent(MissileButton, "MissileButton")

function MissileButton:awake()
    self.actor:addComponentSafe(Components.Hoverable)
    self.actor:addComponentSafe(Components.HoverableRenderer)
    self.actor:addComponentSafe(Components.Clickable)
end

function MissileButton:Clickable_onClickOn(button)
    if button == 1 then
        local player = self.actor.PlayerRef:get()
        if player then
            player.MissileLauncher:shoot()
        end
    end
end

return MissileButton
