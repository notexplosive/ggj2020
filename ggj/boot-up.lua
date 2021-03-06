local State = require("nx/state")
local BootUp = {}

registerComponent(BootUp, "BootUp")

function BootUp:awake()
    self.progress = 0
end

function BootUp:draw(x, y)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", self.actor.BoundingBox:getRect():xywh())
    local x, y, w, h = self.actor.BoundingBox:getRect():xywh()
    local percent = self.progress / 6
    love.graphics.rectangle("fill", x, y, w * percent, h)
    if percent > 1 then
        self.actor:scene():destroyAllActors()
        if State:get("power-failed-first-time") then
            EXEC_TUTORIAL(
                "power-failure",
                "Reboot complete!\n\n" ..
                    "When the StinkBug 0.8 runs out of battery, all systems including the viewing window conveniently shut down." ..
                        "The battery passively regenerates power over time, but only if you're not consuming too much power by doing things like re-printing missiles or using your thrusters.",
                "How convenient! Thanks for rebooting for me!"
            )
        end
    end
end

function BootUp:update(dt)
    self.progress = self.progress + dt
end

return BootUp
