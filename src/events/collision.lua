local shipAction = require( "src.objects.ship" )
local composer = require( "composer" )
local record = require( "src.model.record" )
local particleDesigner = require( "src.util.particleDesigner" )
local Event = {}

function playExplosion( application, obj )
    local explosionEmitter = particleDesigner.newEmitter( "assets/emitters/explosion.pex", "assets/emitters/texture.png" )
    explosionEmitter.x = obj.x
    explosionEmitter.y = obj.y
    timer.performWithDelay( 500, function() explosionEmitter:stop() end )
    if ( not audio.isChannelPlaying( 3 ) ) then
        audio.play( application.soundTable.enemyExplosion, { channel=3 } )
    elseif ( not audio.isChannelPlaying( 4 ) ) then
        audio.play( application.soundTable.enemyExplosion, { channel=4 } )
    elseif ( not audio.isChannelPlaying( 5 ) ) then
        audio.play( application.soundTable.enemyExplosion, { channel=5 } )
    end
end

function Event.onCollision( application )
    return function( event )
        if ( event.phase == "began" ) then

            local obj1 = event.object1
            local obj2 = event.object2

            if ( ( obj1.myName == "laser" and obj2.myName == "easyEnemie" ) or
                    ( obj1.myName == "easyEnemie" and obj2.myName == "laser") )
            then
                if ( obj1.myName == "easyEnemie" ) then
                    playExplosion( application, obj1 )
                else
                    playExplosion( application, obj2 )
                end
                display.remove( obj1 )
                display.remove( obj2 )
                for i = #application.enemiesTable, 1, -1 do
                    if ( application.enemiesTable[i] == obj1 or application.enemiesTable[i] == obj2 ) then
                        table.remove( application.enemiesTable, i )
                        break
                    end
                end
                for i = #application.lasersTable, 1, -1 do
                    if ( application.lasersTable[i] == obj1 or application.lasersTable[i] == obj2 ) then
                        table.remove( application.lasersTable, i )
                        break
                    end
                end

                application.score = application.score + 100
                application.scoreText.text = "Score: " .. application.score
            elseif ( ( obj1.myName == "ship" and obj2.myName == "easyEnemie" ) or
                    ( obj1.myName == "easyEnemie" and obj2.myName == "ship" ) )
            then
                if ( application.died == false ) then
                    application.died = true

                    if ( obj1.myName == "ship" ) then
                        playExplosion( application, obj1 )
                    else
                        playExplosion( application, obj2 )
                    end

                    application.lives = application.lives - 1
                    application.livesText.text = "Lives: " .. application.lives

                    application.firstTurbineEmitter:stop()
                    application.secondTurbineEmitter:stop()
                    if ( application.lives <= 0 ) then
                        record.insert( application.score )
                        record.save()
                        composer.gotoScene( "src.scenes.welcome" )
                        application.died = false
                    else
                        for i = #application.enemiesTable, 1, -1 do
                            if ( application.enemiesTable[i] == obj1 or application.enemiesTable[i] == obj2 ) then
                                playExplosion( application, application.enemiesTable[i] )
                                display.remove( application.enemiesTable[i] )
                                table.remove( application.enemiesTable, i )
                                break
                            end
                        end
                        application.ship.alpha = 0
                        timer.pause( application.laserLoopTimer )
                        timer.performWithDelay( 1000, shipAction.restore( application ) )
                    end
                end
            end
        end
    end
end

return Event
