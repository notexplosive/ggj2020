local State = require("nx/state")
local InvertThrusterCheckbox = {}

registerComponent(InvertThrusterCheckbox, "InvertThrusterCheckbox", {"Checkbox"})

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

function InvertThrusterCheckbox:start()
    local state = State:get("invert-thrusters")
    if state then
        self.actor.Checkbox:Clickable_onClickOn()
    end
end

function InvertThrusterCheckbox:Checkbox_onStateChange(message)
    local state = self.actor.Checkbox.state
    State:persist("invert-thrusters", state)
    local rPos = self.rCol:pos()
    local lPos = self.lCol:pos()

    self.rCol:setPos(lPos)
    self.lCol:setPos(rPos)
end

return InvertThrusterCheckbox
