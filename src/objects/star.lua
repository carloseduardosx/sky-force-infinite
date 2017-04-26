local sprite = require( "src.images.sprite" )

local Star = {}

function Star.create( application, physics, startType, yPosition )

    local collisionFilter = { maskBits = 2, categoryBits = 4 }
    -- TODO create start sprites and add to screen and tables
    -- and then create logic do create then and remove when necessary
    if ( startType == 1 ) then
        local minorStar = display.newImageRect( application.minorStars, sprite.minorStarSheet, 1, 5, 5 )
        table.insert( application.starsTable, minorStars)
        minorStar.name = "minorStart"
        minorStar.x = math.random( 10, display.contentWidth )
        minorStar.y = yPosition
        physics.addBody( minorStar, "dynamic", { density = 1, bounce = 0, filter = collisionFilter } )
        minorStar:setLinearVelocity(
            0,
            application.starLinearVelocity
        )
    elseif ( startType == 2 ) then
        local mediumStar = display.newSprite( application.mediumStars, sprite.mediumStarsSheet, sprite.startSequence )
        table.insert( application.starsTable, mediumStars)
        mediumStar.name = "mediumStart"
        mediumStar.x = math.random( 10, display.contentWidth )
        mediumStar.y = yPosition
        physics.addBody( mediumStar, "dynamic", { density = 1, bounce = 0, filter = collisionFilter } )
        mediumStar:setLinearVelocity(
            0,
            application.starLinearVelocity
        )
    elseif ( startType == 3 ) then
        local largeStar = display.newSprite( application.largeStars, sprite.largeStarsSheet, sprite.startSequence )
        table.insert( application.starsTable, largeStars)
        largeStar.name = "largeStart"
        largeStar.x = math.random( 10, display.contentWidth - 10 )
        largeStar.y = yPosition
        physics.addBody( largeStar, "dynamic", { density = 1, bounce = 0, filter = collisionFilter } )
        largeStar:setLinearVelocity(
            0,
            application.starLinearVelocity
        )
    end
end

function Star.generator ( application, physics )
    return function()
        for i = #application.starsTable, 1, -1 do

            local currentStarsTable = application.starsTable[i]

            if ( currentStarsTable.x < -100 or
                    currentStarsTable.x > display.contentWidth + 100 or
                    currentStarsTable.y < - 100 or
                    currentStarsTable.y > display.contentHeight + 100 )
            then
                display.remove( currentStarsTable )
                table.remove( application.starsTable, i )
            end
        end

        if ( #application.starsTable <= 50 ) then
            Star.createStarts( application, physics, false, 10)
        end
    end
end

function Star.createStarts( application, physics, onScreen, quantity)

    local starType = nil
    local startYPosition = nil
    if (onScreen) then
        for i=1, quantity, 1 do
            starType = math.random( 1, 3)
            startYPosition = math.random( 10, display.contentHeight - 10 )
            Star.create( application, physics, starType, startYPosition)
        end
    else
        for i=1, quantity, 1 do
            starType = math.random( 1, 3)
            startYPosition = math.random( - (display.contentHeight / 2), 0 )
            Star.create( application, physics, starType, startYPosition)
        end
    end
end

return Star
