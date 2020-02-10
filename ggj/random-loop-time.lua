local RandomLoopTime = {}

registerComponent(RandomLoopTime, "RandomLoopTime", {"PlayHead"})

function RandomLoopTime:setup(minTime, maxTime)
    self.minTime = minTime
    self.maxTime = maxTime - minTime
    self:randomizeNextLoopTime()
end

function RandomLoopTime:update(dt)
    self.nextPlay = self.nextPlay - dt
    if self.nextPlay < 0 then
        self.actor.PlayHead:setLoop(false)
        self.actor.PlayHead:play()
        self:randomizeNextLoopTime()
    end
end

function RandomLoopTime:randomizeNextLoopTime()
    self.nextPlay = self.minTime + love.math.random() * self.maxTime
end

return RandomLoopTime
