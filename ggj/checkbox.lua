local Checkbox = {}

registerComponent(Checkbox, "Checkbox")

function Checkbox:setup(state, message, label)
    self.state = state
    self.message = message
    if label then
        self.actor:addComponent(Components.TextRenderer, label, 12, nil, nil, nil, nil, 0, -12)
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
        love.graphics.circle("fill", x, y, 8)
    end

    love.graphics.circle("line", x, y, 14)
end

function Checkbox:Clickable_onClickOn()
    self.state = not self.state
    self.actor:callForAllComponents("Checkbox_onStateChange", self.message)
    if self.actor.Parent then
        self.actor.Parent:get():callForAllComponents("Checkbox_onStateChange", self.message)
    end
end

return Checkbox
