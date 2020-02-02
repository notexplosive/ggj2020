local Asteroid = {}

registerComponent(Asteroid, "Asteroid")

function Asteroid:onCollide(other)
    if other.LaserBullet then
        other:destroy()
    end
end

return Asteroid
