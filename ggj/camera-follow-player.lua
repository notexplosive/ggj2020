local CameraFollowPlayer = {}

registerComponent(CameraFollowPlayer, "CameraFollowPlayer")

function CameraFollowPlayer:update(dt)
    local player = self.actor:scene():getFirstActorWithBehavior(Components.CameraFollowMe)
    if player then
        self.actor:setPos(
            (player:pos() - Vector.new(love.graphics.getDimensions()) / self.actor.Viewport.scale / 2):floor()
        )
    end
end

return CameraFollowPlayer
