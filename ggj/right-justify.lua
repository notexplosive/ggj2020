local RightJustify = {}

registerComponent(RightJustify, "RightJustify", {"BoundingBox"})

function RightJustify:setup()
end

function RightJustify:awake()
end

function RightJustify:update(dt)
    self.actor:setPos(self.actor:scene().width - self.actor.BoundingBox:width())
end

return RightJustify
