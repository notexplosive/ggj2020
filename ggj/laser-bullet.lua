local LaserBullet = {}

registerComponent(LaserBullet, "LaserBullet")

function LaserBullet:setup(owner)
    self.owner = owner
end

function LaserBullet:start()
    assert(self.owner, "setup not run")
end

function LaserBullet:awake()
    self.actor:addComponent(Components.CollideRadius, self.actor.CircleRenderer.radius)
    self.actor:addComponent(Components.Lifetime, 1)
end

return LaserBullet
