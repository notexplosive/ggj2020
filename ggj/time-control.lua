local TimeControl = {}

registerComponent(TimeControl, "TimeControl", {"Checkbox"})

TIMESCALE = 1

function TimeControl:update(dt)
    local enabled = self.actor.Checkbox.state
    if enabled then
        TIMESCALE = 0.1
    else
        TIMESCALE = 1
    end

    musicTrack:setPitch(TIMESCALE)
end

function TimeControl:onDisable()
    TIMESCALE = 1
    self.actor.Checkbox.state = false
end

return TimeControl
