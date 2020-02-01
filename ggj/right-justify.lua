local RightJustify = {}

registerComponent(RightJustify, "RightJustify", {"BoundingBox"})

function RightJustify:update(dt)
    self.actor:setPos(love.graphics.getWidth() - self.actor.BoundingBox:width(), self.actor:pos().y)
end

return RightJustify
