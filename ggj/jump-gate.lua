local JumpGate = {}

registerComponent(JumpGate, "JumpGate")

function JumpGate:setup(targetLevel)
    self.targetLevel = targetLevel
end

function JumpGate:awake()
    self.actor:addComponent(Components.SpriteRenderer, "stargate", "inactive")
end

return JumpGate
