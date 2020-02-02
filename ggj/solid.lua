local Solid = {}

registerComponent(Solid, "Solid", {"Velocity"})

function Solid:onCollide(other)
    local scale = self.actor.CollideRadius:get() / other.CollideRadius:get()
    if scale <= 1 then
        local vec = self.actor:pos() - other:pos()
        self.actor.Velocity:set(vec:normalized() * vec:length())
    end
end

return Solid

