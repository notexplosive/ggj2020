local Player = {}

registerComponent(Player, "Player")

function Player:onCollide(other)
    statusLog("Hull damage!")
end

return Player
