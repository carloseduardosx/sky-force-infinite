local Ship = {}

function Ship.drag( event )
    local ship = event.target
    local phase = event.phase

    if ( "began" == phase ) then
        display.currentStage:setFocus( ship )
        ship.touchOffsetX = event.x - ship.x
        ship.touchOffsetY = event.y - ship.y
    elseif ( "moved" == phase ) then
        ship.x = event.x - ship.touchOffsetX
        ship.y = event.y - ship.touchOffsetY
    elseif ( "ended" == phase or "cancelled" == phase ) then
        display.currentStage:setFocus( nil )
    end

    return true -- Consume event completely
end

function Ship.restore( application )
    return function()
        application.ship.isBodyActive = false
        application.ship.x = display.contentCenterX
        application.ship.y = display.contentHeight - 100

        transition.to(
            application.ship,
            {
                alpha=1,
                time=4000,
                onComplete = function() application.ship.isBodyActive = true application.died = false end
            }
        )
    end
end

return Ship