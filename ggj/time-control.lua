local TimeControl = {}

registerComponent(TimeControl, "TimeControl", {"Checkbox"})

TIMESCALE = 1

function TimeControl:setup()
end

function TimeControl:awake()
end

function TimeControl:draw(x, y)
end

function TimeControl:update(dt)
    local enabled = self.actor.Checkbox.state
    if enabled then
        TIMESCALE = 0.01
    else
        TIMESCALE = 1
    end
end

return TimeControl
