local LaserBullet = {}

registerComponent(LaserBullet, "LaserBullet")

function LaserBullet:setup(owner)
    self.owner = owner
    self.actor:addComponent(Components.SpriteRenderer, "bullet", "all")
end

function LaserBullet:start()
    assert(self.owner, "setup not run")
end

function LaserBullet:awake()
    self.actor:addComponent(Components.CollideRadius, 8)
    self.actor:addComponent(Components.Lifetime, 1)
end

function LaserBullet:onDestroy()
    local actor = self.actor:scene():addActor()
    actor:setPos(self.actor:pos())
    actor:addComponent(Components.BulletExplosion)
end

return LaserBullet
