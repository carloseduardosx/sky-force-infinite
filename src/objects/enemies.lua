local easyEnemiesInfo = require( "src.images.easyEnemies" )
local sprite = require( "src.images.sprite" )

local Enemies = {}

function Enemies.create( application, physics )
    local easyEnemie = display.newImage( application.mainGroup, sprite.easyEnemiesSheet, easyEnemiesInfo:getFrameIndex( "Alien-Scout" ), 50, 50 )
    table.insert( application.enemiesTable, easyEnemie )
    physics.addBody( easyEnemie, { radius=50, bounce=0 })
    easyEnemie.myName = "easyEnemie"

    local whereFrom = math.random( 3 )

    if ( whereFrom == 1 ) then
        easyEnemie.x = 200
    elseif ( whereFrom == 2 ) then
        easyEnemie.x = display.contentCenterY - 150
    else
        easyEnemie.x = display.contentWidth - 200
    end
    easyEnemie.y = -100
    easyEnemie.whereFrom = whereFrom
    easyEnemie:setLinearVelocity( 0, application.easyEnemiesLinearVelocityY )
end

function Enemies.slowMotion( application, isPause )
    if ( isPause == true ) then
        application.easyEnemiesLinearVelocityY = 0
    else
        application.easyEnemiesLinearVelocityY = application.easyEnemiesSlowLinearVelocityY
    end
    for i = #application.enemiesTable, 1, -1 do
        application.enemiesTable[i]:setLinearVelocity( 0, application.easyEnemiesLinearVelocityY )
    end
end

function Enemies.speedUp( application )
    application.easyEnemiesLinearVelocityY = application.easyEnemiesFastLinearVelocityY
    for i = #application.enemiesTable, 1, -1 do
        application.enemiesTable[i]:setLinearVelocity( 0, application.easyEnemiesLinearVelocityY )
    end
end

function Enemies.remove( application )
    for i = #application.enemiesTable, 1, -1 do
        application.enemiesTable[i]:removeSelf()
        application.enemiesTable[i] = nil
    end
end

function Enemies.generator( application, physics )
    return function()
        Enemies.create( application, physics )
        for i = #application.enemiesTable, 1, -1 do
            local currentEnemie = application.enemiesTable[i]
            if ( currentEnemie.y > display.contentHeight + 100 ) then
                display.remove( currentEnemie )
                table.remove( application.enemiesTable, i )
            end
        end
    end
end

return Enemies
