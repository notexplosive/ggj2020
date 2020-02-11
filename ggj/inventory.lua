local State = require("nx/state")
local Inventory = {}

registerComponent(Inventory, "Inventory")

local valueOfOneScrap = 10

function Inventory:setup()
end

function Inventory:awake()
    self.scrap = State:get("scrap-count") or 0
    self.collectTimer = 0
    self.step = 0
end

function Inventory:update(dt)
    if self.collectTimer > 0 then
        self.collectTimer = self.collectTimer - dt
        if self.collectTimer < 0 then
            statusLog("Collected " .. self.step * valueOfOneScrap .. " scrap")
            self.step = 0

            EXEC_TUTORIAL(
                "collect-scrap",
                "You've collected some scrap!\n\nYou can use Scrap to repair damaged modules when they are damaged",
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
                okSound:setPitch(0.75 + 0.25 * clamp(self.step, 0, 5))
                okSound:setVolume(0.5)
                self.step = self.step + 1
                okSound:play()

                self.scrap = self.scrap + valueOfOneScrap
                self.collectTimer = 0.5
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

function Inventory:writeState()
    State:set("scrap-count", self.scrap)
end

return Inventory
