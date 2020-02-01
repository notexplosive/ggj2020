local InvertThrusterCheckbox = {}

registerComponent(InvertThrusterCheckbox, "InvertThrusterCheckbox", {"Checkbox"})

function InvertThrusterCheckbox:setup()
end

function InvertThrusterCheckbox:awake()
    for i, column in self.actor:scene():eachActorWith(Components.CreateCheckboxColumn) do
        if column.CreateCheckboxColumn.playerControlValue == "thrustRight" then
            self.rCol = column
        end

        if column.CreateCheckboxColumn.playerControlValue == "thrustLeft" then
            self.lCol = column
        end
    end
end

function InvertThrusterCheckbox:Checkbox_onStateChange(message)
    local state = self.actor.Checkbox.state
    local rPos = self.rCol:pos()
    local lPos = self.lCol:pos()

    self.rCol:setPos(lPos)
    self.lCol:setPos(rPos)
end

return InvertThrusterCheckbox
