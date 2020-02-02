local EnemyHealth = {}

registerComponent(EnemyHealth, "EnemyHealth")

function EnemyHealth:setup(maxHealth)
    self.maxHealth = maxHealth
    self.health = maxHealth
end


function EnemyHealth:onCollide(other)
    if other.LaserBullet then
        other:destroy()
        self.health = self.health - 1
    end
    if self.health < 1 then
        self.actor:destroy()
    end 
end

return EnemyHealth