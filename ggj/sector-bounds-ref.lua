local SectorBoundsRef = {}

registerComponent(SectorBoundsRef, "SectorBoundsRef")

function SectorBoundsRef:get()
    return gameScene:getFirstBehavior(Components.SectorBounds):get()
end

return SectorBoundsRef
