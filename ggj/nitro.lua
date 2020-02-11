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

        EXEC_TUTORIAL(
            "use-nitro",
            "Activating NITRO...\n\n" ..
                "NITRO will raise your terminal velocity." ..
                    "\n\nNITRO does not provide any speed so you will still need to use your thrusters if you want to go fast.",
            "See you, space cowboy"
        )
    else
        self.actor.Velocity.terminalSpeed = self.normalTerminalSpeed
    end

    self.enabled = b
end

function Nitro:getFastSpeed()
    return self.fastTerminalSpeed
end

function Nitro:getSlowSpeed()
    return self.normalTerminalSpeed
end

return Nitro
