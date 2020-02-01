local CreateCheckboxColumn = {}

registerComponent(CreateCheckboxColumn, "CreateCheckboxColumn", {"PlayerRef"})

function CreateCheckboxColumn:setup(count, playerControlValue)
    local scene = self.actor:scene()
    local total = count - 1
    for i = 0, total do
        local checkbox = scene:addActor()
        local message = total - i
        local startingState = false or message == 0
        checkbox:addComponent(Components.Parent, self.actor)
        checkbox:addComponent(Components.Checkbox, startingState, message)
        checkbox:setPos(self.actor:pos() + Vector.new(0, i * checkbox.BoundingBox:height()))
    end

    self.max = count
    self.playerControlValue = playerControlValue
end

function CreateCheckboxColumn:Checkbox_onStateChange(message)
    self:setVal(tonumber(message))
end

function CreateCheckboxColumn:setVal(val)
    for i, checkbox in ipairs(self.actor.Children:get()) do
        checkbox.Checkbox.state = checkbox.Checkbox.message <= val
    end

    local player = self.actor.PlayerRef:get()
    if player then
        player.PlayerControl:setInputVal(self.playerControlValue, val)
    end
end

function CreateCheckboxColumn:onNotify(message)
    if message == "max" then
        self:setVal(self.max - 1)
    end

    if message == "zero" then
        self:setVal(0)
    end
end

return CreateCheckboxColumn
