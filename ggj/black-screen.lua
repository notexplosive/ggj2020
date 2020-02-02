local BlackScreen = {}

registerComponent(BlackScreen, "BlackScreen")

function BlackScreen:awake()
    self.time = 0
    Assets.sounds["lose-power"]:play()
end

function BlackScreen:update(dt)
    self.time = self.time + dt
end

function BlackScreen:draw(x, y)
    local opac = self.time
    love.graphics.setColor(0, 0, 0, opac)
    if opac > 1 and not self.actor.BoundingBox then
        self.actor:addComponent(Components.BoundingBox, 500, 80)
        self.actor:addComponent(Components.PositionCenterX)
        self.actor:addComponent(Components.BootUp)
    end
    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
end

function BlackScreen:onMouseMove(dt)
    self.actor:scene():consumeHover()
end

function BlackScreen:onDestroy()
    Assets.sounds["power-on"]:play(0)
end

return BlackScreen
