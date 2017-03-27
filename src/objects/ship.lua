local Ship = {}

function Ship.drag( game )
    return function( event )
        local ship = event.target
        local phase = event.phase

        if ( "began" == phase ) then
            game.speedUp()
            display.currentStage:setFocus( ship )
            ship.touchOffsetX = event.x - ship.x
            ship.touchOffsetY = event.y - ship.y
        elseif ( "moved" == phase ) then
            ship.x = event.x - ship.touchOffsetX
            ship.y = event.y - ship.touchOffsetY
        elseif ( "ended" == phase or "cancelled" == phase ) then
            game.slowMotion()
            display.currentStage:setFocus( nil )
        end

        return true -- Consume event completely
    end
end

function Ship.restore( game )
    return function()
        game.ship.isBodyActive = false
        game.ship.x = display.contentCenterX
        game.ship.y = display.contentHeight - 100

        transition.to(
            game.ship,
            {
                alpha=1,
                time=4000,
                onComplete = function() game.ship.isBodyActive = true game.died = false end
            }
        )
    end
end

return Ship