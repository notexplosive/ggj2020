local Player = {}

registerComponent(Player, "Player")

function Player:awake()
    self.lastHit = love.timer.getTime()
end

function Player:onCollide(other)
    if other.LaserBullet and other.LaserBullet.owner == self.actor then
        return
    end

    if not other.Solid then
        return
    end

    if love.timer.getTime() < self.lastHit + 0.5 then
        return
    end

    self.lastHit = love.timer.getTime()

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
    local actor = self.actor:scene():addActor()
    actor:setPos(self.actor:pos())
    actor:addComponent(Components.Explosion)
    local gameOverTransitionActor = self.actor:scene():addActor()
    gameOverTransitionActor:setPos(self.actor:pos())
    gameOverTransitionActor:addComponent(Components.GameOverExplosion)
    uiScene:addActor():addComponent(Components.WhiteFade)
end

return Player
