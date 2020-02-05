local LaserButton = {}

registerComponent(LaserButton, "LaserButton")

function LaserButton:awake()
    self.actor:addComponentSafe(Components.Hoverable)
    self.actor:addComponentSafe(Components.Clickable)
end

function LaserButton:Clickable_onClickOn(button)
    if button == 1 then
        local player = self.actor.PlayerRef:get()
        if player then
            player.Laser:singleShot()
        end
    end
end

return LaserButton
