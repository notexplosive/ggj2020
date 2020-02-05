local Velocity = {}

registerComponent(Velocity, "Velocity")

function Velocity:setup(v, y)
    self.vec = Vector.new(v, y)
end

function Velocity:reverseSetup()
    return self.vec:clone()
end

function Velocity:awake()
    self.vec = Vector.new()
    self.terminalSpeed = 128
end

function Velocity:update(dt)
    self.actor:move(self.vec * dt)
end

function Velocity:getTerminalSpeed()
    return self.terminalSpeed
end

function Velocity:get()
    return self.vec:clone()
end

function Velocity:set(v, y)
    self.vec = Vector.new(v, y)
    local length = self.vec:length()
    if length > self.terminalSpeed then
        self.vec = self.vec:normalized() * self.terminalSpeed

        EXEC_TUTORIAL(
            "velocity-tut",
            "Green widgets are non-interactive. They just expose information and statistics about your ship.\n\nThe widget in the top left for instance is the Velocity widget. It indicates the direction your facing and the direction your moving. If the white vector is at the edge of the circle, that means you're at the maximum speed allowed by the Intergalactic Police Force and your ship will not allow you to move any faster.\n\nIf you would like to increase your maximum speed, enable NITRO.",
            "Gotta go fast!"
        )
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
