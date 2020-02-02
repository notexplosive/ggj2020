local Nitro = {}

registerComponent(Nitro, "Nitro")

function Nitro:awake()
    self.normalTerminalSpeed = self.actor.Velocity.terminalSpeed
    self.fastTerminalSpeed = self.normalTerminalSpeed * 4
end

function Nitro:getBatteryUsage()
    if self.enabled then
        return 15
    end
    return 0
end

function Nitro:isFastEnoughForJump()
    return math.abs(self.actor.Velocity:get():length() - self.fastTerminalSpeed) < 5
end

function Nitro:get()
    return self.actor.Velocity.terminalSpeed == self.fastTerminalSpeed
end

function Nitro:set(b)
    if b then
        self.actor.Velocity.terminalSpeed = self.fastTerminalSpeed
    else
        self.actor.Velocity.terminalSpeed = self.normalTerminalSpeed
    end

    self.enabled = b
end

return Nitro
