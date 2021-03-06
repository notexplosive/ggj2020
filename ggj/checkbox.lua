local Checkbox = {}

registerComponent(Checkbox, "Checkbox")

function Checkbox:setup(state, message, label)
    self.state = state
    self.message = message
    if label then
        self.actor:addComponent(Components.TextRenderer, label, 14, nil, nil, nil, nil, 0, -15)
    end
end

function Checkbox:awake()
    self.actor:addComponent(Components.BoundingBox, 32, 32)
    self.actor:addComponent(Components.Hoverable)
    self.actor:addComponent(Components.Clickable)
end

function Checkbox:draw(x, y)
    local x, y = self.actor.BoundingBox:getRect():center():xy()
    love.graphics.setColor(1, 1, 1, 1)

    if self.state then
        if self._hover then
            love.graphics.circle("fill", x, y, 10)
        else
            love.graphics.circle("fill", x, y, 8)
        end
    end

    love.graphics.circle("line", x, y, 14)

    if self._hover then
        love.graphics.circle("fill", x, y, 5)
    end
end

function Checkbox:Clickable_onClickOn()
    self.state = not self.state

    if self.state then
        Assets.sounds["check-on"]:stopThenPlay()
    else
        Assets.sounds["check-off"]:stopThenPlay()
    end

    self.actor:callForAllComponents("Checkbox_onStateChange", self.message, self.state)
    if self.actor.Parent then
        self.actor.Parent:get():callForAllComponents("Checkbox_onStateChange", self.message, self.state)
    end
end

function Checkbox:Hoverable_onHover()
    self._hover = true
end

function Checkbox:Hoverable_onHoverEnd()
    self._hover = false
end

return Checkbox
