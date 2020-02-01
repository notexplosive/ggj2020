local LayoutWidgets = {}

registerComponent(LayoutWidgets, "LayoutWidgets")

function LayoutWidgets:setup()
end

function LayoutWidgets:update(dt)
    local leftWidgets = {}
    local rightWidgets = {}
    for i, widget in self.actor:scene():eachActorWith(Components.SceneRenderer) do
        local isRight = widget.RightJustify
        if isRight then
            append(rightWidgets, widget)
        else
            append(leftWidgets, widget)
        end
    end

    self:layoutColumn(leftWidgets, 0)
    self:layoutColumn(rightWidgets, love.graphics.getWidth() - rightWidgets[1].BoundingBox:width())
end

function LayoutWidgets:layoutColumn(widgets, x)
    assert(widgets)
    local y = 0
    for i, widget in ipairs(widgets) do
        widget:setPos(0, y)
        y = y + widget.BoundingBox:height()
    end
end

return LayoutWidgets
