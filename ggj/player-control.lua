local PlayerControl = {}

registerComponent(PlayerControl, "PlayerControl", {"Velocity"})

function PlayerControl:awake()
    self.inputState = {}

    self.inputState.thrustLeft = 0
    self.inputState.thrustRight = 0
    self.inputState.thrustMiddle = 0

    self.debrisTimer = 1
end

function PlayerControl:update(dt)
    local velocity = self.actor.Velocity
    local vec = velocity:get()
    local angle = self.actor:angle()

    local thrust = Vector.newPolar(1, self.actor:angle())
    local tilt = 2.5 * dt

    self.debrisTimer = self.debrisTimer - vec:length() * dt

    if self.inputState.thrustLeft > 0 then
        vec = vec + thrust * self.inputState.thrustLeft / 2
        angle = angle - tilt * self.inputState.thrustLeft / 2
        self:dropDebris()
    end

    if self.inputState.thrustRight > 0 then
        vec = vec + thrust * self.inputState.thrustRight / 2
        angle = angle + tilt * self.inputState.thrustRight / 2
        self:dropDebris()
    end

    if self.inputState.thrustMiddle > 0 then
        vec = vec + thrust * self.inputState.thrustMiddle / 6
        self:dropDebris()
    end

    self:dropDebris()

    self.actor:setAngle(angle)
    velocity:set(vec)
end

function PlayerControl:dropDebris()
    if self.debrisTimer < 0 then
        local actor = self.actor:scene():addActor()
        --actor:setPos(self.actor:pos() - self.actor.Velocity:get():normalized():setAngle(self.actor:angle()) * 32)
        actor:setPos(self.actor:pos())
        --actor:addComponent(Components.CircleRenderer, 5)
        actor:addComponent(Components.SpriteRenderer, self.actor.SpriteRenderer:reverseSetup())
        actor:setAngle(self.actor:angle())
        actor:addComponent(Components.Lifetime, 1)
        actor:addComponent(Components.FadeOutWithLifetime, 0.25)
        actor:scene():sendToBack(actor)
        self.debrisTimer = 15
    end
end

function PlayerControl:setInputVal(key, value)
    assert(indexOf(getKeys(self.inputState), key))
    self.inputState[key] = value
end

return PlayerControl
