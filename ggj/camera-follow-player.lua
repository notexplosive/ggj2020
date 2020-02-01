local CameraFollowPlayer = {}

registerComponent(CameraFollowPlayer, "CameraFollowPlayer")

function CameraFollowPlayer:update(dt)
    local player = self.actor:scene():getFirstActorWithBehavior(Components.Player)
    if player then
        self.actor:setPos(player:pos() - Vector.new(love.graphics.getDimensions()) / 4)
    end
end

return CameraFollowPlayer
