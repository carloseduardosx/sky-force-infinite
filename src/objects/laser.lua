local sprite = require( "src.images.sprite" )

local Laser = {}

function Laser.fire( application, physics )
    local newLaser = display.newImageRect( application.mainGroup, sprite.objectSheet, 5, 14, 40 )
    table.insert( application.lasersTable, newLaser )
    physics.addBody( newLaser, "dynamic", { isSensor=true } )
    newLaser.isBullet = true
    newLaser.myName = "laser"
    newLaser.x = application.ship.x
    newLaser.y = application.ship.y
    newLaser:toBack()

    newLaser:setLinearVelocity( 0, application.laserLinearVelocityY )
end

function Laser.slowMotion( application )
    application.laserLinearVelocityY = application.laserSlowMotionLinearVelocityY
    for i = #application.lasersTable, 1, -1 do
        application.lasersTable[i]:setLinearVelocity( 0, application.laserLinearVelocityY )
    end
end

function Laser.speedUp( application )
    application.laserLinearVelocityY = application.laserFastLinearVelocityY
    for i = #application.lasersTable, 1, -1 do
        application.lasersTable[i]:setLinearVelocity( 0, application.laserLinearVelocityY )
    end
end

function Laser.generator( application, physics )
    return function()
        Laser.fire( application, physics )
        for i = #application.lasersTable, 1, -1 do
            local currentLaser = application.lasersTable[i]
            if ( currentLaser.y < -40 ) then
                display.remove( currentLaser )
                table.remove( application.lasersTable, i )
            end
        end
    end
end

return Laser
