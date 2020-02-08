local Missile = {}

registerComponent(Missile, "Missile")

function Missile:awake()
    self.actor:addComponent(Components.CollideRadius, 8)
    self.actor:addComponent(Components.SpriteRenderer, "missle", "all")

    self.actor.Velocity.terminalSpeed = 256
end

function Missile:update(dt)
    local velocity = self.actor.Velocity:get() + Vector.newPolar(120, self.actor:angle()) * dt
    velocity:setAngle(self.actor:angle())
    self.actor.Velocity:set(velocity)

    for i, actor in self.actor:scene():eachActorWith(Components.MissileTargetable) do
        local radius = 0
        if actor.CollideRadius then
            radius = actor.CollideRadius:get()
        end

        local displacement = actor:pos() - self.actor:pos()
        if (displacement):length() < 300 + radius then
            local myAngle = self.actor:angle()

            local leftFeeler = self.actor:pos() + Vector.newPolar(32, myAngle + 5)
            local rightFeeler = self.actor:pos() + Vector.newPolar(32, myAngle - 5)

            local distanceFromRight = (rightFeeler - actor:pos()):length()
            local distanceFromLeft = (leftFeeler - actor:pos()):length()

            local shouldTurnRight = distanceFromLeft < distanceFromRight

            if shouldTurnRight then
                myAngle = myAngle - dt * 5
            else
                myAngle = myAngle + dt * 5
            end

            self.actor:setAngle(myAngle)
            break
        end
    end
end

return Missile
