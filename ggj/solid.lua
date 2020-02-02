local Solid = {}

registerComponent(Solid, "Solid", {"Velocity"})

function Solid:onCollide(other)
    local vec = self.actor:pos() - other:pos()
    self.actor.Velocity:set(vec:normalized() * vec:length())
end

return Solid

