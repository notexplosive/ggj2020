local SectorTitle = {}

registerComponent(SectorTitle, "SectorTitle")

function SectorTitle:setup(title)
    self.content = "Discovered Sector:\n" .. title
    self.time = -1
end

function SectorTitle:start()
    local titleDisplay = uiScene:addActor()
    local textRenderer = titleDisplay:addComponent(Components.TextRenderer, "", 70, 110000, "center")

    textRenderer.shadow = true
    titleDisplay:addComponent(Components.PositionCenterX)
    titleDisplay:setPos(0, 100)

    self.textRenderer = textRenderer
end

function SectorTitle:update(dt)
    self.time = self.time + dt
    if self.time > 0 then
        local textPos = math.floor(self.time * 15)

        if textPos <= #self.content + 10 then
            self.textRenderer.text = string.sub(self.content, 1, textPos)
        else
            self.textRenderer.color[4] = (self.textRenderer.color[4] or 1) - dt
            if self.textRenderer.color[4] < 0 then
                self.actor:destroy()
                self.textRenderer.actor:destroy()
            end
        end
    end
end

return SectorTitle
