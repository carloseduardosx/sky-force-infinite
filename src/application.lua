local physics = require( "physics" )
local sprite = require( "src.images.sprite" )
local image = require( "src.images.image" )
local asteroid = require( "src.objects.asteroid" )
local laser = require( "src.objects.laser" )
local shipAction = require( "src.objects.ship" )
local event = require( "src.events.collision" )

local Application = {}

Application.lives = 3
Application.score = 0
Application.died = false

Application.asteroidsTable = {}

Application.ship = nil
Application.gameLoopTimer = nil
Application.livesText = nil
Application.scoreText = nil

Application.backGroup = display.newGroup();
Application.mainGroup = display.newGroup();
Application.uiGroup = display.newGroup();

Application.background = image.background( Application.backGroup )

function Application.gameLoop()
    asteroid.create( Application.mainGroup, Application.asteroidsTable, physics )

    for i = #Application.asteroidsTable, 1, -1 do

        local currentAsteroid = Application.asteroidsTable[i]

        if ( currentAsteroid.x < -100 or
                currentAsteroid.x > display.contentWidth + 100 or
                currentAsteroid.y < - 100 or
                currentAsteroid.y > display.contentHeight + 100 )
        then
            display.remove( currentAsteroid )
            table.remove( Application.asteroidsTable, i )
        end
    end
end

function Application.start()
    math.randomseed( os.time() )

    physics.start();
    physics.setGravity( 0, 0 )

    Application.background.x = display.contentCenterX
    Application.background.y = display.contentCenterY

    Application.ship = display.newImageRect( Application.mainGroup, sprite.objectSheet, 4, 98, 79 )
    Application.ship.x = display.contentCenterX
    Application.ship.y = display.contentHeight - 100

    physics.addBody( Application.ship, { radius=30, isSensor=true } )

    Application.ship.myName = "ship"

    Application.livesText = display.newText( Application.uiGroup, "Lives: " .. Application.lives, 200, 80, native.systemFont, 36)
    Application.scoreText = display.newText( Application.uiGroup, "Score: " .. Application.score, 400, 80, native.systemFont, 36)

    display.setStatusBar( display.HiddenStatusBar )

    Application.ship:addEventListener( "touch", shipAction.drag )

    timer.performWithDelay( 300, laser.fire( Application.mainGroup, Application.ship, physics ), 0 )

    Application.gameLoopTimer = timer.performWithDelay(
        500,
        asteroid.generator(Application.mainGroup, Application.asteroidsTable, physics),
        0
    )

    Runtime:addEventListener(
        "collision",
        event.onCollision( Application )
    )
end

return Application
