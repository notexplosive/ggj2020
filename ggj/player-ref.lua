local PlayerRef = {}

registerComponent(PlayerRef, "PlayerRef")

function PlayerRef:get()
    return gameScene:getFirstActorWithBehavior(Components.Player)
end

return PlayerRef
