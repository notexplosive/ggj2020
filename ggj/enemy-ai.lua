local EnemyAI = {}

registerComponent(EnemyAI, "EnemyAI")

function EnemyAI:update(dt)
    self.patrolTimer = (self.patrolTimer or 0) + dt
    if self.patrolTimer > 1 then
        self.patrolTimer = 0
        self:updatePatrolValues()
    end

    local player = self.actor.PlayerRef:get()

    if player then
        if not self:shouldChasePlayer() then
            local r, l, m = self:getPatrolValues()
            self.actor.ShipControl.inputState.thrustRight = r
            self.actor.ShipControl.inputState.thrustLeft = l
            self.actor.ShipControl.inputState.thrustMiddle = m
            return
        end

        local myAngle = self.actor:angle()

        local leftFeeler = self.actor:pos() + Vector.newPolar(32, myAngle + 5)
        local rightFeeler = self.actor:pos() + Vector.newPolar(32, myAngle - 5)

        local distanceFromRight = (rightFeeler - player:pos()):length()
        local distanceFromLeft = (leftFeeler - player:pos()):length()

        local shouldTurn = true
        if math.abs(distanceFromLeft - distanceFromRight) < math.pi / 4 then
            shouldTurn = false
        end

        if shouldTurn then
            local shouldTurnRight = distanceFromLeft > distanceFromRight

            if shouldTurnRight then
                self.actor.ShipControl.inputState.thrustRight = 2
                self.actor.ShipControl.inputState.thrustLeft = 0
            else
                self.actor.ShipControl.inputState.thrustRight = 0
                self.actor.ShipControl.inputState.thrustLeft = 2
            end
        else
            self.actor.ShipControl.inputState.thrustRight = 2
            self.actor.ShipControl.inputState.thrustLeft = 2
            self.actor.ShipControl.inputState.thrustMiddle = 2
        end
    end
end

function EnemyAI:shouldChasePlayer()
    local player = self.actor.PlayerRef:get()
    if player then
        local distance = (player:pos() - self.actor:pos()):length()
        if distance < 250 then
            return true
        elseif distance > 500 then
            return false
        else
            return true
        end
    end

    return false
end

function EnemyAI:updatePatrolValues()
    self.patrolValues = {love.math.random(0, 2), love.math.random(0, 2), love.math.random(0, 2)}
end
function EnemyAI:getPatrolValues()
    if self.patrolValues then
        return unpack(self.patrolValues)
    else
        return 1, 1, 1
    end
end

return EnemyAI
