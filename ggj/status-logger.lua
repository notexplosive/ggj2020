local StatusLogger = {}

registerComponent(StatusLogger, "StatusLogger")

STATUS_LOGGER = StatusLogger

function StatusLogger:awake()
    STATUS_LOGGER = self
end

function StatusLogger:log(str)
    local actor = self.actor:scene():addActor()
    local textSize = 18
    actor:addComponent(Components.TextRenderer, str, textSize)
    actor:setPos(self.actor:pos())
    if self.actor.Children then
        for i, child in self.actor.Children:each() do
            child:move(0, -textSize)
        end
    end
    actor:addComponent(Components.Parent, self.actor)
end

function statusLog(str)
    STATUS_LOGGER:log(str)
end

return StatusLogger
