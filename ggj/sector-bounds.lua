local SectorBounds = {}

registerComponent(SectorBounds, "SectorBounds")

function SectorBounds:setup(w, h)
    self.rect = Rect.new(-w / 2, -h / 2, w, h)
end

function SectorBounds:get()
    return self.rect:clone()
end

return SectorBounds
