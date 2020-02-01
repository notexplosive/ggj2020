local HandleCollide = {}

registerComponent(HandleCollide, "HandleCollide")

function HandleCollide:update(dt)
    for _, actor1 in self.actor:scene():eachActorWith(Components.CollideRadius) do
        for _, actor2 in self.actor:scene():eachActorWith(Components.CollideRadius) do
            if actor1 ~= actor2 then
                if (actor1:pos() - actor2:pos()):length() <= actor1.CollideRadius:get() + actor2.CollideRadius:get() then
                    actor1:callForAllComponents("onCollide", actor2)
                end
            end
        end
    end
end

return HandleCollide
