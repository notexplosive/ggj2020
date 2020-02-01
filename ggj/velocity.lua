local Velocity = {}

registerComponent(Velocity, "Velocity")

function Velocity:setup(v, y)
    self.vec = Vector.new(v, y)
end

function Velocity:awake()
    self.vec = Vector.new()
    self.terminalSpeed = 50
end

function Velocity:update(dt)
    self.actor:move(self.vec * dt)
end

function Velocity:get()
    return self.vec:clone()
end

function Velocity:set(v, y)
    self.vec = Vector.new(v, y)
    local length = self.vec:length()
    if length > self.terminalSpeed then
        self.vec = self.vec:normalized() * length
    end
end

function Velocity:add(v, y)
    local vec = Vector.new(v, y)
    self:set(self.vec + vec)
end

function Velocity:setX(x)
    self.vec.x = x
end

function Velocity:setY(y)
    self.vec.y = y
end

return Velocity
