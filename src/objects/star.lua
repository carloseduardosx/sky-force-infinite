local sprite = require( "src.images.sprite" )

local Star = {}

function Star.create( application, physics, startType, yPosition, hasMovement )

    local collisionFilter = { maskBits = 2, categoryBits = 4 }
    if ( startType == 1 ) then
        local minorStar = display.newImageRect( application.minorStars, sprite.minorStarSheet, 1, 5, 5 )
        table.insert( application.starsTable, minorStar)
        minorStar.name = "minorStart"
        minorStar.x = math.random( 10, display.contentWidth )
        minorStar.y = yPosition
        physics.addBody( minorStar, "dynamic", { density = 1, bounce = 0, filter = collisionFilter } )
        if ( hasMovement ) then
            minorStar:setLinearVelocity(
                0,
                application.minorStarLinearVelocity
            )
        end
    elseif ( startType == 2 ) then
        local mediumStar = display.newSprite( application.mediumStars, sprite.mediumStarsSheet, sprite.startSequence )
        table.insert( application.starsTable, mediumStar)
        mediumStar.name = "mediumStart"
        mediumStar.x = math.random( 10, display.contentWidth )
        mediumStar.y = yPosition
        physics.addBody( mediumStar, "dynamic", { density = 1, bounce = 0, filter = collisionFilter } )
        if ( hasMovement ) then
            mediumStar:setLinearVelocity(
                0,
                application.mediumStarLinearVelocity
            )
        end
    elseif ( startType == 3 ) then
        local largeStar = display.newSprite( application.largeStars, sprite.largeStarsSheet, sprite.startSequence )
        table.insert( application.starsTable, largeStar)
        largeStar.name = "largeStart"
        largeStar.x = math.random( 10, display.contentWidth - 10 )
        largeStar.y = yPosition
        physics.addBody( largeStar, "dynamic", { density = 1, bounce = 0, filter = collisionFilter } )
        if ( hasMovement ) then
            largeStar:setLinearVelocity(
                0,
                application.largeStarLinearVelocity
            )
        end
    end
end

function Star.remove( application )
    for i = #application.starsTable, 1, -1 do
        application.starsTable[i]:removeSelf()
        application.starsTable[i] = nil
    end
end

function Star.startStarsMovement( application )
    local name = nil
    for i = #application.starsTable, 1, -1 do
        name = application.starsTable[i].name
        if ( name == "minorStart" ) then
            application.starsTable[i]:setLinearVelocity(
                0,
                application.minorStarLinearVelocity
            )
        elseif ( name == "mediumStart" ) then
            application.starsTable[i]:setLinearVelocity(
                0,
                application.mediumStarLinearVelocity
            )
        else
            application.starsTable[i]:setLinearVelocity(
                0,
                application.largeStarLinearVelocity
            )
        end
    end
end

function Star.stopStarsMovement( application )
    local name = nil
    for i = #application.starsTable, 1, -1 do
        name = application.starsTable[i].name
        if ( name == "minorStart" ) then
            application.starsTable[i]:setLinearVelocity( 0, 0 )
        elseif ( name == "mediumStart" ) then
            application.starsTable[i]:setLinearVelocity( 0, 0 )
        else
            application.starsTable[i]:setLinearVelocity( 0, 0 )
        end
    end
end

function Star.generator ( application, physics )
    return function()
        for i = #application.starsTable, 1, -1 do

            local currentStarsTable = application.starsTable[i]

            if ( currentStarsTable.y > display.contentHeight + 10 )
            then
                display.remove( currentStarsTable )
                table.remove( application.starsTable, i )
            end
        end

        if ( #application.starsTable <= 190 ) then
            Star.createStarts( application, physics, false, 10, true)
        end
    end
end

function Star.createStarts( application, physics, onScreen, quantity, hasMovement)

    local starType = nil
    local startYPosition = nil
    if (onScreen) then
        for i=1, quantity, 1 do
            starType = math.random( 1, 3)
            startYPosition = math.random( 10, display.contentHeight - 10 )
            Star.create( application, physics, starType, startYPosition, hasMovement)
        end
    else
        for i=1, quantity, 1 do
            starType = math.random( 1, 3)
            startYPosition = math.random( - (display.contentHeight / 2), 0 )
            Star.create( application, physics, starType, startYPosition, hasMovement)
        end
    end
end

return Star
