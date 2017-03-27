local sprite = require( "src.images.sprite" )

local Asteroid = {}

function Asteroid.create( group, asteroidsTable, physics )
    local newAsteroid = display.newImageRect( group, sprite.objectSheet, 1, 102, 85 )
    table.insert( asteroidsTable, newAsteroid )
    physics.addBody( newAsteroid, "dynamic", { radius=40, bounce=0.8 } )
    newAsteroid.myName = "asteroid"

    local whereFrom = math.random( 3 )

    if ( whereFrom == 1 ) then
        -- From the left
        newAsteroid.x = -60
        newAsteroid.y = math.random( 500 )
        newAsteroid:setLinearVelocity( math.random( 40, 120 ), math.random( 20, 60 ) )
    elseif ( whereFrom == 2 ) then
        -- From the top
        newAsteroid.x = math.random( display.contentWidth )
        newAsteroid.y = -60
        newAsteroid:setLinearVelocity( math.random( -40, 40 ), math.random( 40, 120 ) )
    elseif (whereFrom == 3) then
        -- From the right
        newAsteroid.x = display.contentWidth + 60
        newAsteroid.y = math.random( 500 )
        newAsteroid:setLinearVelocity( math.random( -120, -40 ), math.random( 20, 60 ) )
    end

    newAsteroid:applyTorque( math.random( -6, 6 ) )
end

function Asteroid.generator( group, asteroidsTable, physics)
    return function()
        Asteroid.create( group, asteroidsTable, physics )

        for i = #asteroidsTable, 1, -1 do

            local currentAsteroid = asteroidsTable[i]

            if ( currentAsteroid.x < -100 or
                    currentAsteroid.x > display.contentWidth + 100 or
                    currentAsteroid.y < - 100 or
                    currentAsteroid.y > display.contentHeight + 100 )
            then
                display.remove( currentAsteroid )
                table.remove( asteroidsTable, i )
            end
        end
    end
end

return Asteroid
