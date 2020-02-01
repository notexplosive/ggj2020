local PlayerControl = {}

registerComponent(PlayerControl, "PlayerControl", {"Velocity"})

function PlayerControl:awake()
    self.inputState = {}

    self.inputState.thrustLeft = true
    self.inputState.thrustRight = false
end

function PlayerControl:update(dt)
    local velocity = self.actor.Velocity
    local vec = velocity:get()
    local angle = self.actor:angle()

    self.inputState.thrustLeft = love.keyboard.isDown("left")
    self.inputState.thrustRight = love.keyboard.isDown("right")

    local thrust = Vector.new(1, 0)
    local tilt = 5 * dt

    if self.inputState.thrustLeft then
        vec = vec + thrust:clone():setAngle(angle)
        angle = angle - tilt
    end

    if self.inputState.thrustRight then
        vec = vec + thrust:clone():setAngle(angle)
        angle = angle + tilt
    end

    self.actor:setAngle(angle)
    velocity:set(vec)

    --debugLog(unpack(getKeys(self.inputState)))
end

return PlayerControl
