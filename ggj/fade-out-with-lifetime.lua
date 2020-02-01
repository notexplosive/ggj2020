local FadeOutWithLifetime = {}

registerComponent(FadeOutWithLifetime, "FadeOutWithLifetime", {"Lifetime", "SpriteRenderer"})

function FadeOutWithLifetime:setup(startingAlpha)
    self.startingAlpha = startingAlpha
end

function FadeOutWithLifetime:draw(x, y)
    self.actor.SpriteRenderer.color[4] = self.startingAlpha - self.startingAlpha * self.actor.Lifetime:percent()
end

function FadeOutWithLifetime:update(dt)
end

return FadeOutWithLifetime
