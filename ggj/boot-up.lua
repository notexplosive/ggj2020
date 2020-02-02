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
    love.graphics.rectangle("fill", x, y, w * percent, h)
    if percent > 1 then
        self.actor:scene():destroyAllActors()
    end
end

function BootUp:update(dt)
    self.progress = self.progress + dt
end

return BootUp
