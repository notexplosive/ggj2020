local SectorBounds = {}

registerComponent(SectorBounds, "SectorBounds")

function SectorBounds:setup(w, h)
    self.rect = Rect.new(0, 0, w, h)
end

function SectorBounds:get()
    return self.rect:clone()
end

return SectorBounds
