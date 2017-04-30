local shipAction = require( "src.objects.ship" )
local composer = require( "composer" )
local record = require( "src.model.record" )
local Event = {}

function Event.onCollision( application )
    return function( event )
        if ( event.phase == "began" ) then

            local obj1 = event.object1
            local obj2 = event.object2

            if ( ( obj1.myName == "laser" and obj2.myName == "asteroid" ) or
                    ( obj1.myName == "asteroid" and obj2.myName == "laser") )
            then
                display.remove( obj1 )
                display.remove( obj2 )

                for i = #application.asteroidsTable, 1, -1 do
                    if ( application.asteroidsTable[i] == obj1 or application.asteroidsTable[i] == obj2 ) then
                        table.remove( application.asteroidsTable, i )
                        break
                    end
                end

                application.score = application.score + 100
                application.scoreText.text = "Score: " .. application.score
            elseif ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or
                    ( obj1.myName == "asteroid" and obj2.myName == "ship" ) )
            then
                if ( application.died == false ) then
                    application.died = true

                    application.lives = application.lives - 1
                    application.livesText.text = "Lives: " .. application.lives

                    if ( application.lives == 0 ) then
                        record.insert( application.score )
                        record.save()
                        composer.gotoScene( "src.scenes.welcome" )
                    else
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
