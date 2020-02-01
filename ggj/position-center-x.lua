local PositionCenterX = {}

registerComponent(PositionCenterX, "PositionCenterX")

function PositionCenterX:setup()
end

function PositionCenterX:awake()
end

function PositionCenterX:update(dt)
    self.actor:setPos(self.actor:scene().width / 2, 0)
end

return PositionCenterX