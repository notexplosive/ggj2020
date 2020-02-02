local BatteryIndicator = {}

registerComponent(BatteryIndicator, "BatteryIndicator", {"PlayerRef"})

function BatteryIndicator:setup()
end

function BatteryIndicator:awake()
    local sp = self.actor:addComponent(Components.SpriteRenderer, "battery", "all", 2)
    --sp:setLoop(false)
    local actor = self.actor:scene():addActor()
    actor:setPos(180, 48)
    actor:addComponent(Components.CircleRenderer, 20, {0.25, 0.5, 0.25})
    actor:addComponent(Components.SpriteRenderer, "charge-status", "all", 2)
    self.chargeActor = actor
end

function BatteryIndicator:draw(x, y)
end

function BatteryIndicator:update(dt)
    local player = self.actor.PlayerRef:get()
    if player then
        --local status = math.floor(player.Battery:getPercent() * 100) .. ", " .. player.Battery:calculateUsage()
        --self.actor.TextRenderer.text = status
        local batteryTarget = self:calculateBatteryFrame(player.Battery:calculateUsage())
        self.actor.PlayHead:set((self.actor.PlayHead.maxTime - 0.1) * player.Battery:getPercent())
        self.chargeActor.SpriteRenderer:setFrame(batteryTarget)
    end
end

function BatteryIndicator:calculateBatteryFrame(batteryUsage)
    local chargeDraw = batteryUsage * -1
    local frame = 0
    local scale = 2
    if chargeDraw > 4 * scale then
        frame = 6
    elseif chargeDraw > 2 * scale then
        frame = 5
    elseif chargeDraw > 0.25 * scale then
        frame = 4
    elseif chargeDraw > -0.25 * scale then
        frame = 3
    elseif chargeDraw > -2 * scale then
        frame = 2
    elseif chargeDraw > -4 * scale then
        frame = 1
    end
    return frame
end

return BatteryIndicator
