local ButtonBorder = {}

registerComponent(ButtonBorder, "ButtonBorder", {"BoundingBox"})

function ButtonBorder:setup()
end

function ButtonBorder:awake()
end

function ButtonBorder:draw(x, y)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", self.actor.BoundingBox:getRect():xywh())

    if self._hover then
        love.graphics.rectangle("line", self.actor.BoundingBox:getRect():inflate(-5, -5):xywh())
    end
end

function ButtonBorder:Hoverable_onHover()
    self._hover = true
end

function ButtonBorder:Hoverable_onHoverEnd()
    self._hover = false
end

function ButtonBorder:Clickable_onClickOn()
    local sound = Assets.sounds["ui-beep"]:get()
    sound:setPitch(1.2)
    sound:play()
end

return ButtonBorder
