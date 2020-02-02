local Widget = {}

registerComponent(Widget, "Widget")

local font = love.graphics.newFont(22)

function Widget:awake()
    self.actor:addComponent(Components.Hoverable)
    self.actor:addComponent(Components.Clickable)

    self.storeScene = nil
    self.isDisabled = false
    self.recoverTimer = 0
    self.maxRecoverTime = 5
    self.isRecovering = false
end

function Widget:update(dt)
    if self.isRecovering then
        self.recoverTimer = self.recoverTimer - dt
    end
end

function Widget:draw(x, y)
    if self.isDisabled or self.isRecovering then
        local recoverPercent = 1 - (self.recoverTimer / self.maxRecoverTime)

        if recoverPercent > 1 then
            self:recover()
        end

        self.actor.Canvas:canvasDraw(
            function()
                love.graphics.setColor(0, 0, 0.25)
                love.graphics.rectangle("fill", 0, 0, self.actor.BoundingBox:getRect():wh())
                love.graphics.setColor(0.25, 0.7, 0)

                status = "OFFLINE"

                if self.isRecovering then
                    local w, h = self.actor.BoundingBox:getRect():wh()
                    w = w * recoverPercent
                    love.graphics.rectangle("fill", 0, 0, w, h)
                    status = "REPAIRING " .. math.floor(recoverPercent * 100) .. "%"
                end

                love.graphics.setColor(0.5, 0.5, 0.7)
                love.graphics.rectangle("line", 0, 0, self.actor.BoundingBox:getRect():wh())

                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setFont(font)
                love.graphics.print("module" .. ":\n" .. status)
            end
        )
    end
end

function Widget:Clickable_onClickOn(button)
    if self.isDisabled and button == 1 then
        self.isDisabled = false
        self.isRecovering = true
        self.recoverTimer = self.maxRecoverTime
    end
end

function Widget:recover()
    if self.storeScene then
        self.actor.SceneRenderer.scene = self.storeScene
    end
    self.isRecovering = false
end

function Widget:disable()
    if not self.isDisabled then
        self.isDisabled = true
        self.actor.SceneRenderer.scene:onDisable()
        self.storeScene = self.actor.SceneRenderer.scene
        self.actor.SceneRenderer.scene = nil
    end
end

function Widget:onKeyPress(key, scancode, wasRelease)
    if key == "space" then
        if not self.isDisabled then
            self:disable()
        end
    end
end

function Widget:getBatteryUsage()
    if self.isDisabled then
        return 0
    end

    if self.isRecovering then
        return 10
    end

    return 1
end

return Widget
