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

            EXEC_TUTORIAL(
                "collect-scrap",
                "You've collected some SCRAP!\n\nYou can use Scrap to repair damaged modules when the wear out.\n\nPlease note doing your own repairs will void your warranty.",
                "Wow! So useful! Thanks Operator's Manual!"
            )
        end
    end

    for i, actor in self.actor:scene():eachActorWith(Components.Scrap) do
        local vec = self.actor:pos() - actor:pos()
        if vec:length() < 128 then
            actor:move(vec / 10 * dt * 60)
            if vec:length() < 32 then
                actor:destroy()
                local okSound = Assets.sounds["button-yes"]:get()
                okSound:setPitch(2)
                okSound:play()

                self.scrap = self.scrap + 10
                self.collectTimer = 0.25
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
