local sprite = require( "src.images.sprite" )

local Laser = {}

function Laser.fire( game, physics )
    return function()
        local newLaser = display.newImageRect( game.mainGroup, sprite.objectSheet, 5, 14, 40 )
        physics.addBody( newLaser, "dynamic", { isSensor=true } )
        newLaser.isBullet = true
        newLaser.myName = "laser"
        newLaser.x = game.ship.x
        newLaser.y = game.ship.y
        newLaser:toBack()

        transition.to(
            newLaser,
            {
                y=-40,
                time=game.fireTime,
                onComplete = function() display.remove( newLaser ) end
            } )
    end
end

return Laser
