local LaserBullet = {}

registerComponent(LaserBullet, "LaserBullet")

function LaserBullet:awake()
    self.actor:addComponent(Components.CollideRadius, self.actor.CircleRenderer.radius)
end

return LaserBullet
