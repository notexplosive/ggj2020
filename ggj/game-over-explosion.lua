local GameOverExplosion = {}

registerComponent(GameOverExplosion, "GameOverExplosion")

function GameOverExplosion:awake()
    self.time = 0
    local sound = Assets.sounds.boom:get()
    local sound2 = Assets.sounds.boom:get()
    sound:setVolume(1.2)
    sound:setPitch(1.2)
    sound:play()

    sound2:setPitch(0.8)
    sound:play()
end

function GameOverExplosion:draw(x, y)
    love.graphics.setColor(1, 1, 1, 0.75)
    love.graphics.ellipse(
        "fill",
        x,
        y,
        self.time * 800 + math.sin(self.time * 30) * 100,
        self.time * 500 + math.cos(self.time * 30) * 100
    )
end

function GameOverExplosion:update(dt)
    self.time = self.time + dt
end

return GameOverExplosion
