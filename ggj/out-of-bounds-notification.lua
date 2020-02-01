local OutOfBoundsNotification = {}

registerComponent(OutOfBoundsNotification, "OutOfBoundsNotification")

function OutOfBoundsNotification:update(dt)
    local player = self.actor.PlayerRef:get()
    self.actor.visible = false
    if player then
        self.actor.visible = player.StayWithinBounds.isOutOfBounds
    end
end

return OutOfBoundsNotification
