local sprite = require( "src.images.sprite" )

local Laser = {}

function Laser.fire( application, physics )
    return function()
        local newLaser = display.newImageRect( application.mainGroup, sprite.objectSheet, 5, 14, 40 )
        physics.addBody( newLaser, "dynamic", { isSensor=true } )
        newLaser.isBullet = true
        newLaser.myName = "laser"
        newLaser.x = application.ship.x
        newLaser.y = application.ship.y
        newLaser:toBack()

        transition.to(
            newLaser,
            {
                y=-40,
                time=application.fireTime,
                onComplete = function() display.remove( newLaser ) end
            } )
    end
end

return Laser
