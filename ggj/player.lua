local Player = {}

registerComponent(Player, "Player")

function Player:awake()
    self.invulnerable = 0
    self.humSound = Assets.sounds["space-hum"]:get()
    self.humSound:play()
    self.humSound:setPitch(0.5)
    self.humSound:setLooping(true)
end

function Player:update(dt)
    if self.invulnerable > 0 then
        self.invulnerable = self.invulnerable - dt
    end

    local engineVolume =
        self.actor.PlayerControl.inputState.thrustLeft + self.actor.PlayerControl.inputState.thrustRight +
        self.actor.PlayerControl.inputState.thrustMiddle

    if self.actor.Nitro.enabled then
        engineVolume = engineVolume * 2
    end

    self.humSound:setVolume(engineVolume / 20)
    self.humSound:setPitch(engineVolume / 10 + 0.1)

    if not self.actor.visible then
        self.humSound:stop()
    end
end

function Player:onKeyPress(key, scanCode, wasRelease)
    if wasRelease and key == "j" then
        local jumpGate = gameScene:getFirstActorWithBehavior(Components.JumpGate)
        if jumpGate then
            self:activateJumpGate(jumpGate)
        end
    end
end

function Player:onCollide(other)
    if other.LaserBullet and other.LaserBullet.owner == self.actor then
        return
    end

    if other.JumpGate then
        EXEC_TUTORIAL(
            "jump-gate",
            "This is a Jump Gate! These help you slingshot into the next system. In order to activate it you will need to employ the use of a Nano Interplanetary Travel Retrograde Operator (NITRO).\n\nA Jump Gate will only activate if you reach it at top speed using the NITRO.",
            "Please subscribe me to your mailing list"
        )

        if self.actor.Nitro:isFastEnoughForJump() then
            self:activateJumpGate(other)
        else
            if self.actor.Nitro:get() then
                statusLog("Not fast enough for jump")
            end
        end
    end

    if not other.Solid then
        return
    end

    sound = Assets.sounds.thump:get()
    sound:setPitch(1.5)
    sound:play()

    if self.invulnerable > 0 then
        return
    end

    self.invulnerable = 0.5

    local hitExplosion = self.actor:scene():addActor()
    hitExplosion:setPos(self.actor:pos())
    hitExplosion:addComponent(Components.MediumExplosion)

    EXEC_TUTORIAL(
        "first-collide",
        "Looks like you've hit an object! Ouch!\n\nI'm just kidding of course, I'm just an instruction manual, I cannot feel pain. The AI behind your ship modules however, do feel pain every time experience hull damage*. Speaking of, it looks like on of your modules has been damaged, use your MPID (Mouse Pointer Input Device) to repair it.\nRepairs require scrap and battery power.\n\n" ..
            "*Interface with AI Module Controller not included in 0.8 model",
        "Very cool and also informative!"
    )

    statusLog("Hull damage!")

    local allWidgets = uiScene:getAllActorsWith(Components.Widget)

    local enabledWidgets = {}
    for i, widget in ipairs(allWidgets) do
        if not widget.Widget:isInactive() then
            append(enabledWidgets, widget)
        end
    end

    table.sort(
        enabledWidgets,
        function(act1, act2)
            return act1.Widget.priority < act2.Widget.priority
        end
    )

    if #enabledWidgets == 0 then
        self.actor:destroy()
        return
    end

    local lowestPriority = enabledWidgets[1].Widget.priority

    local widgetsToDamage = {}
    for i, widget in ipairs(enabledWidgets) do
        if widget.Widget.priority == lowestPriority then
            append(widgetsToDamage, widget)
        end
    end

    if #widgetsToDamage > 0 then
        local actor = getRandom(widgetsToDamage)
        actor.Widget:disable()
    end
end

function Player:onDestroy()
    sound = Assets.sounds.spring:get()
    sound:setPitch(0.05)
    sound:play()

    local actor = self.actor:scene():addActor()
    actor:setPos(self.actor:pos())
    actor:addComponent(Components.Explosion)
    local gameOverTransitionActor = self.actor:scene():addActor()
    gameOverTransitionActor:setPos(self.actor:pos())
    gameOverTransitionActor:addComponent(Components.GameOverExplosion)
    uiScene:addActor():addComponent(Components.WhiteFade)
end

function Player:activateJumpGate(other)
    other.SpriteRenderer:setAnimation("active")
    if self.actor.CameraFollowMe then
        local sound = Assets.sounds["button-yes"]:get()
        sound:setPitch(0.25)
        sound:setVolume(1.5)
        sound:play()

        local spring = Assets.sounds["spring"]:get()
        spring:setPitch(1.5)
        spring:play()

        self.actor.CameraFollowMe:destroy()
        self.actor.StayWithinBounds:destroy()
        uiScene:addActor():addComponent(Components.WhiteFade, other.JumpGate.targetLevel, 0.5, 0, 0.5)
        self.actor.visible = false
        other:addComponent(Components.CameraFollowMe)
        self.hasjumped = true
        return
    end
end

return Player
