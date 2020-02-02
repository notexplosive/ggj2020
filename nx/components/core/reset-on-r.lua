local ResetOnR = {}

registerComponent(ResetOnR, "ResetOnR")

function ResetOnR:onKeyPress(key)
    if key == "r" then
        loadLevel(self.actor:scene().path)
    end
end

return ResetOnR
