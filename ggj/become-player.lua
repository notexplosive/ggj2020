local BecomePlayer = {}

registerComponent(BecomePlayer, "BecomePlayer")

function BecomePlayer:setup()
end

function BecomePlayer:awake()
    self.actor:addComponent(Components.SpriteRenderer, "temp-ship")
    self.actor:addComponent(Components.CameraFollowMe)
    self.actor:addComponent(Components.SectorBoundsRef)
    self.actor:addComponent(Components.Velocity)
    self.actor:addComponent(Components.Laser)
    self.actor:addComponent(Components.StayWithinBounds)
    self.actor:addComponent(Components.Player)
    self.actor:addComponent(Components.TimeControlRef)
    self.actor:addComponent(Components.Inventory)
    self.actor:addComponent(Components.PlayerControl)
    self.actor:addComponent(Components.Nitro)
    self.actor:addComponent(Components.Battery, 400)
    self.actor:addComponent(Components.ShowOnMap, {0, 1, 0}, 64)
    self.actor:addComponent(Components.CollideRadius, 16)
end

return BecomePlayer
