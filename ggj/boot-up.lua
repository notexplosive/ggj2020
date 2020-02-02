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
    local percent = self.progress / 3
    if ALLOW_DEBUG then
        percent = self.progress / 0.1
    end
    love.graphics.rectangle("fill", x, y, w * percent, h)
    if percent > 1 then
        self.actor:scene():destroyAllActors()
        if State:get("power-failed-first-time") then
            EXEC_TUTORIAL(
                "power-failure",
                "Reboot complete!\n\nWhen the StinkBug 0.8 runs out of battery, all systems automatically shut down and the Fission Reactor will jumpstart your battery back to full health.\n\nBe aware of your surroundings when you run out of battery.",
                "Thanks for rebooting for me!"
            )
        end
    end
end

function BootUp:update(dt)
    self.progress = self.progress + dt
end

return BootUp
