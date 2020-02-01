local Inventory = {}

registerComponent(Inventory, "Inventory")

function Inventory:setup()
end

function Inventory:awake()
    self.scrap = 0
end

function Inventory:update(dt)
    for i, actor in self.actor:scene():eachActorWith(Components.Scrap) do
        local vec = self.actor:pos() - actor:pos()
        if vec:length() < 128 then
            actor:move(vec / 10 * dt * 60)
            if vec:length() < 32 then
                actor:destroy()
                self.scrap = self.scrap + 10
            end
        end
    end
end

function Inventory:getScrap()
    return self.scrap
end

return Inventory
