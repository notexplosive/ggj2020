local PlayerControl = {}

registerComponent(PlayerControl, "PlayerControl", {"Velocity"})

function PlayerControl:awake()
    self.inputState = {}

    self.inputState.thrustLeft = true
    self.inputState.thrustRight = false

    self.debrisTimer = 1
end

function PlayerControl:update(dt)
    local velocity = self.actor.Velocity
    local vec = velocity:get()
    local angle = self.actor:angle()

    self.inputState.thrustLeft = love.keyboard.isDown("left")
    self.inputState.thrustRight = love.keyboard.isDown("right")

    local thrust = Vector.new(1, 0)
    local tilt = 2.5 * dt

    self.debrisTimer = self.debrisTimer - vec:length() * dt

    if self.inputState.thrustLeft then
        vec = vec + thrust:clone():setAngle(angle - tilt * 2)
        angle = angle - tilt
        self:dropDebris()
    end

    if self.inputState.thrustRight then
        vec = vec + thrust:clone():setAngle(angle + tilt * 2)
        angle = angle + tilt
        self:dropDebris()
    end

    self.actor:setAngle(angle)
    velocity:set(vec)

    --debugLog(unpack(getKeys(self.inputState)))
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
        self.debrisTimer = 30
    end
end

return PlayerControl
