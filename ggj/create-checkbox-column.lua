local CreateCheckboxColumn = {}

registerComponent(CreateCheckboxColumn, "CreateCheckboxColumn", {"PlayerRef"})

function CreateCheckboxColumn:setup(count, ShipControlValue, label)
    local scene = self.actor:scene()
    local total = count - 1
    for i = 0, total do
        local checkbox = scene:addActor()
        local message = total - i
        local startingState = false or message == 0
        checkbox:addComponent(Components.Parent, self.actor)
        checkbox:addComponent(Components.Checkbox, startingState, message)
        checkbox:addComponent(Components.AffixPos, self.actor, Vector.new(0, i * checkbox.BoundingBox:height()))
    end

    self.max = count
    self.ShipControlValue = ShipControlValue

    local tx = self.actor:addComponent(Components.TextRenderer, label, 14, 10000, "center")
    tx.offset = Vector.new(16, -15)
end

function CreateCheckboxColumn:Checkbox_onStateChange(message, state)
    local num = tonumber(message)
    if not state then
        num = num - 1

        if num <= 0 then
            num = 0
        end
    end

    self:setVal(num)
end

function CreateCheckboxColumn:setVal(val)
    for i, checkbox in ipairs(self.actor.Children:get()) do
        checkbox.Checkbox.state = checkbox.Checkbox.message <= val
    end

    local player = self.actor.PlayerRef:get()
    if player then
        player.ShipControl:setInputVal(self.ShipControlValue, val)
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

function CreateCheckboxColumn:onDisable()
    self:setVal(0)
end

return CreateCheckboxColumn
