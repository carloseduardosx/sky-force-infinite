local Ship = {}

function Ship.drag( application )
    return function( event )
        local ship = event.target
        local phase = event.phase

        if ( "began" == phase ) then
            application.speedUp()
            display.currentStage:setFocus( ship )
            ship.touchOffsetX = event.x - ship.x
            ship.touchOffsetY = event.y - ship.y
        elseif ( "moved" == phase ) then
            ship.x = event.x - ship.touchOffsetX
            ship.y = event.y - ship.touchOffsetY
        elseif ( "ended" == phase or "cancelled" == phase ) then
            application.slowMotion()
            display.currentStage:setFocus( nil )
        end

        return true -- Consume event completely
    end
end

function Ship.restore( application )
    return function()
        application.ship.isBodyActive = false
        application.ship.x = display.contentCenterX
        application.ship.y = display.contentHeight - 100

        timer.resume( application.laserLoopTimer )

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