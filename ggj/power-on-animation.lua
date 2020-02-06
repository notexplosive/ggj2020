local PowerOnAnimation = {}

registerComponent(PowerOnAnimation, "PowerOnAnimation")

function PowerOnAnimation:awake()
    self.finalRects = {}
    self.startingRects = {}
    self.brokenRects = {}

    local widgets = uiScene:getAllActorsWith(Components.Widget)
    shuffle(widgets)

    for i, widget in ipairs(widgets) do
        local rect = widget.BoundingBox:getRect()
        if not widget.Widget:isInactive() then
            local center = rect:center()
            append(self.finalRects, rect:inflate(-8, -8))
            append(self.startingRects, Rect.new(center.x, rect:y(), 0, rect:height()))
        else
            append(self.brokenRects, rect:inflate(-8, -8))
        end
    end

    self.dt = 0
    self.index = 1
    self.time = 0
end

function PowerOnAnimation:draw(x, y)
    self.index = math.floor(self.time * 2.5)

    for i, rect in ipairs(self.startingRects) do
        local finalRect = self.finalRects[i]
        if self.index > i then
            local dw = self.dt * 60 * 15

            rect:setX(rect:x() - dw)
            rect:setWidth(rect:width() + dw * 2)

            if rect:width() > finalRect:width() then
                rect:setWidth(finalRect:width())
                rect:setX(finalRect:x())

                love.graphics.setColor(0.25, 0.5, 0.5, 0.25)
                love.graphics.rectangle("fill", rect:xywh())
            end

            love.graphics.setColor(0.5, 1, 0.5, 0.5)
            love.graphics.rectangle("line", rect:xywh())
        end

        love.graphics.setColor(0, 1, 0.5, 0.5)
        love.graphics.rectangle("line", finalRect:xywh())
    end

    for i, rect in ipairs(self.brokenRects) do
        love.graphics.setColor(0.75, 0.2, 0.2, 0.5)
        love.graphics.rectangle("line", rect:xywh())
    end
end

function PowerOnAnimation:update(dt)
    self.dt = dt
    self.time = self.time + dt
end

return PowerOnAnimation
