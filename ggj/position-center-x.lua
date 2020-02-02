local PositionCenterX = {}

registerComponent(PositionCenterX, "PositionCenterX")

function PositionCenterX:setup()
end

function PositionCenterX:awake()
    self:update(0)
end

function PositionCenterX:update(dt)
    local bbxOffset = 0
    if self.actor.BoundingBox then
        bbxOffset = self.actor.BoundingBox:width() / 2
    end
    self.actor:setPos(self.actor:scene().width / 2 - bbxOffset, self.actor:pos().y)
end

return PositionCenterX
