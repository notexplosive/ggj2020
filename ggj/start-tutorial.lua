local StartTutorial = {}

registerComponent(StartTutorial, "StartTutorial")

function StartTutorial:awake()
    self.startTimer = 0.2
end

function StartTutorial:update(dt)
    self.startTimer = self.startTimer - dt
    if self.startTimer < 0 then
        EXEC_TUTORIAL(
            "start-game",
            "OPERATOR'S MANUAL\n\nThank you for choosing the StinkBug Model 0.8, optimized for comfort*, quality*, and affordability.\n\nTo operate your spacecraft use our Mouse Pointer Interface Device (MPID) to interact with the modules on the left or right edges of the screen.",
            "OK, please tell me more useful things in the future"
        )
    end
end

return StartTutorial
