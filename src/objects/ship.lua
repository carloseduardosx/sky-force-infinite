local particleDesigner = require( "src.util.particleDesigner" )
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
            ship.y = event.y - ship.touchOffsetY - 100
            application.firstTurbineEmitter.x = ship.x - 55
            application.firstTurbineEmitter.y = ship.y + 50
            application.secondTurbineEmitter.x = ship.x + 55
            application.secondTurbineEmitter.y = ship.y + 50
        elseif ( "ended" == phase or "cancelled" == phase ) then
            application.slowMotion()
            display.currentStage:setFocus( nil )
        end

        return true -- Consume event completely
    end
end

function Ship.turnOnTurbines( application )
    application.firstTurbineEmitter = particleDesigner.newEmitter( "assets/emitters/turbine.pex", "assets/emitters/texture.png" )
    application.secondTurbineEmitter = particleDesigner.newEmitter( "assets/emitters/turbine.pex", "assets/emitters/texture.png" )
    application.firstTurbineEmitter.x = application.ship.x - 55
    application.firstTurbineEmitter.y = application.ship.y + 50
    application.secondTurbineEmitter.x = application.ship.x + 55
    application.secondTurbineEmitter.y = application.ship.y + 50
end

function Ship.restore( application )
    return function()
        application.ship.isBodyActive = false
        application.ship.x = display.contentCenterX
        application.ship.y = display.contentHeight - 100
        application.firstTurbineEmitter.x = application.ship.x - 55
        application.firstTurbineEmitter.y = application.ship.y + 50
        application.secondTurbineEmitter.x = application.ship.x + 55
        application.secondTurbineEmitter.y = application.ship.y + 50
        application.firstTurbineEmitter:start()
        application.secondTurbineEmitter:start()

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
