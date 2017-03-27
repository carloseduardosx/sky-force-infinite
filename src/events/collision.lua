local shipAction = require( "src.objects.ship" )
local Event = {}

function Event.onCollision( game )
    return function( event )
        if ( event.phase == "began" ) then

            local obj1 = event.object1
            local obj2 = event.object2

            if ( ( obj1.myName == "laser" and obj2.myName == "asteroid" ) or
                    ( obj1.myName == "asteroid" and obj2.myName == "laser") )
            then
                display.remove( obj1 )
                display.remove( obj2 )

                for i = #game.asteroidsTable, 1, -1 do
                    if ( game.asteroidsTable[i] == obj1 or game.asteroidsTable[i] == obj2 ) then
                        table.remove( game.asteroidsTable, i )
                        break
                    end
                end

                game.score = game.score + 100
                game.scoreText.text = "Score: " .. game.score
            elseif ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or
                    ( obj1.myName == "asteroid" and obj2.myName == "ship" ) )
            then
                if ( game.died == false ) then
                    game.died = true

                    game.lives = game.lives - 1
                    game.livesText.text = "Lives: " .. game.lives

                    if ( game.lives == 0 ) then
                        game.stopGame()
                    else
                        game.ship.alpha = 0
                        timer.pause( game.laserLoopTimer )
                        timer.performWithDelay( 1000, shipAction.restore( game ) )
                    end
                end
            end
        end
    end
end

return Event
