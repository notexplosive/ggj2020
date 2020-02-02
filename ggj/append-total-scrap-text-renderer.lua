local State = require("nx/state")
local AppendTotalScrapToTextRenderer = {}

registerComponent(AppendTotalScrapToTextRenderer, "AppendTotalScrapToTextRenderer")

function AppendTotalScrapToTextRenderer:setup()
end

function AppendTotalScrapToTextRenderer:start()
    self.actor.TextRenderer.text =
        self.actor.TextRenderer.text .. "\n" .. "Total scrap: " .. (State:get("scrap-count") or 0)
end

function AppendTotalScrapToTextRenderer:draw(x, y)
end

function AppendTotalScrapToTextRenderer:update(dt)
end

return AppendTotalScrapToTextRenderer
