local GameOverExplosion = {}

registerComponent(GameOverExplosion, "GameOverExplosion")

function GameOverExplosion:awake()
    self.time = 0
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
