local TimeControlRef = {}

registerComponent(TimeControlRef, "TimeControlRef")

function TimeControlRef:getBatteryUsage()
    if TIMESCALE ~= 1 then
        return 50
    end

    return 0
end

return TimeControlRef
