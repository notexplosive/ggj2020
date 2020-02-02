local Player = {}

registerComponent(Player, "Player")

function Player:onCollide(other)
    statusLog("Hull damage!")

    local allWidgets = uiScene:getAllActorsWith(Components.Widget)

    local enabledWidgets = {}
    for i, widget in ipairs(allWidgets) do
        if not widget.Widget.isDisabled then
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

return Player
