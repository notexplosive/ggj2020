local StayWithinBounds = {}

registerComponent(StayWithinBounds, "StayWithinBounds", {"Velocity"})
function StayWithinBounds:awake()
    self.actor:addComponentSafe(Components.SectorBoundsRef)
end

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

    if isOutOfBounds and self.actor.Player then
        EXEC_TUTORIAL(
            "out-of-bounds",
            "You're at the edge of the Sector (see your map on the left, if it's not broken). When you try to leave the boundaries of the sector you will be automatically pulled back in.",
            "That doesn't make any sense"
        )
    end

    self.isOutOfBounds = isOutOfBounds
end

return StayWithinBounds
