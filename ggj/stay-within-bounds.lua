local StayWithinBounds = {}

registerComponent(StayWithinBounds, "StayWithinBounds", {"Velocity"})

function StayWithinBounds:update(dt)
    local boundsRect = self.actor.SectorBoundsRef:get()
    local isOutOfBounds = false
    local pos = self.actor:pos()
    if pos.y < boundsRect:top() then
        self.actor.Velocity:add(0, 240 * dt)
        isOutOfBounds = true
    end

    if pos.y > boundsRect:bottom() then
        self.actor.Velocity:add(0, -240 * dt)
        isOutOfBounds = true
    end

    if pos.x < boundsRect:left() then
        self.actor.Velocity:add(240 * dt, 0)
        isOutOfBounds = true
    end

    if pos.x > boundsRect:right() then
        self.actor.Velocity:add(-240 * dt, 0)
        isOutOfBounds = true
    end

    self.isOutOfBounds = isOutOfBounds
end

return StayWithinBounds
