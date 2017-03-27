local sprite = require( "src.images.sprite" )

local Laser = {}

function Laser.fire( group, ship, physics )
    return function()
        local newLaser = display.newImageRect( group, sprite.objectSheet, 5, 14, 40 )
        physics.addBody( newLaser, "dynamic", { isSensor=true } )
        newLaser.isBullet = true
        newLaser.myName = "laser"
        newLaser.x = ship.x
        newLaser.y = ship.y
        newLaser:toBack()

        transition.to(
            newLaser,
            {
                y=-40,
                time=500,
                onComplete = function() display.remove( newLaser ) end
            } )
    end
end

return Laser
