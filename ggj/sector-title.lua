local SectorTitle = {}

registerComponent(SectorTitle, "SectorTitle")

function SectorTitle:setup(string)
    local titleDisplay = uiScene:addActor()
    titleDisplay:addComponent(Components.TextRenderer, "Discovered Sector:\n" .. string, 88, 110000, "center")
    titleDisplay:addComponent(Components.PositionCenterX)
    titleDisplay:setPos(0, 500)
end

function SectorTitle:draw(x, y)
end

function SectorTitle:update(dt)
end

return SectorTitle
