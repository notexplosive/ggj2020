local IndicatorBackground = {}

registerComponent(IndicatorBackground, "IndicatorBackground")

function IndicatorBackground:start()
    self.actor:scene().sceneRenderer.backgroundColor = {0, 0.25, 0}
end

return IndicatorBackground
