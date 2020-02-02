local Inventory = {}

registerComponent(Inventory, "Inventory")

function Inventory:setup()
end

function Inventory:awake()
    self.scrap = 0
    self.collectTimer = 0
end

function Inventory:update(dt)
    if self.collectTimer > 0 then
        self.collectTimer = self.collectTimer - dt
        if self.collectTimer < 0 then
            statusLog("Collected scrap")
        end
    end

    for i, actor in self.actor:scene():eachActorWith(Components.Scrap) do
        local vec = self.actor:pos() - actor:pos()
        if vec:length() < 128 then
            actor:move(vec / 10 * dt * 60)
            if vec:length() < 32 then
                actor:destroy()
                self.scrap = self.scrap + 10
                self.collectTimer = 1
            end
        end
    end
end

function Inventory:getScrap()
    return self.scrap
end

function Inventory:spendScrap(n)
    if self.scrap >= n then
        self.scrap = self.scrap - n
        return true
    end
    return false
end

return Inventory
