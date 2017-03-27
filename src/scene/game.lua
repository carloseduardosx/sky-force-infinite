local physics = require( "physics" )
local sprite = require( "src.images.sprite" )
local image = require( "src.images.image" )
local asteroid = require( "src.objects.asteroid" )
local laser = require( "src.objects.laser" )
local shipAction = require( "src.objects.ship" )
local event = require( "src.events.collision" )
local composer = require ( "composer" )
local scene = composer.newScene()

scene.lives = 3
scene.score = 0
scene.died = false

scene.asteroidsTable = {}

scene.ship = nil
scene.gameLoopTimer = nil
scene.livesText = nil
scene.scoreText = nil

scene.fireDelay = 300
scene.fireTime = 500

scene.asteroidGeneratorDelay = 500
scene.asteroidLeftLinearVelocityX = math.random( 40, 120 )
scene.asteroidLeftLinearVelocityY = math.random( 20, 60 )
scene.asteroidTopLinearVelocityX = math.random( -40, 40 )
scene.asteroidTopLinearVelocityY = math.random( 40, 120 )
scene.asteroidRightLinearVelocityX = math.random( -120, -40 )
scene.asteroidRightLinearVelocityY = math.random( 20, 60 )

function scene.startFire()
    return timer.performWithDelay(
        scene.fireDelay,
        laser.fire( scene, physics ),
        0
    )
end

function scene.startAsteroids()
    return timer.performWithDelay(
        scene.asteroidGeneratorDelay,
        asteroid.generator( scene, physics ),
        0
    )
end

function scene.initGame()
    scene.laserLoopTimer = scene.startFire()
    scene.gameLoopTimer = scene.startAsteroids()
    Runtime:addEventListener(
        "collision",
        event.onCollision( scene )
    )
    scene.ship:removeEventListener( "touch", scene.initGame )
end

function scene.stopGame()
    timer.cancel( scene.laserLoopTimer )
    timer.cancel( scene.gameLoopTimer )
    display.remove( scene.ship )
    Runtime:removeEventListener(
        "collision",
        event.onCollision( scene )
    )
end

function scene.removeShadowBackground()
    transition.to( scene.background, { time=500, alpha=1 } )
end

function scene.applyShadowBackground()
    transition.to( scene.background, { time=1000, alpha=0.4 } )
end

function scene.speedUp()
    scene.fireTime = 500
    scene.fireDelay = 300
    scene.asteroidGeneratorDelay = 500
    scene.asteroidLeftLinearVelocityX = math.random( 40, 120 )
    scene.asteroidLeftLinearVelocityX = math.random( 40, 120 )
    scene.asteroidLeftLinearVelocityY = math.random( 20, 60 )
    scene.asteroidTopLinearVelocityX = math.random( -40, 40 )
    scene.asteroidTopLinearVelocityY = math.random( 40, 120 )
    scene.asteroidRightLinearVelocityX = math.random( -120, -40 )
    scene.asteroidRightLinearVelocityY = math.random( 20, 60 )
    timer.cancel( scene.laserLoopTimer )
    timer.cancel( scene.gameLoopTimer )
    scene.removeShadowBackground()
    scene.laserLoopTimer = scene.startFire()
    scene.gameLoopTimer = scene.startAsteroids()
end

function scene.slowMotion()
    scene.fireTime = 5000
    scene.fireDelay = 1500
    scene.asteroidGeneratorDelay = 2000
    scene.asteroidLeftLinearVelocityX = math.random( 10, 40 )
    scene.asteroidLeftLinearVelocityY = math.random( 10, 20 )
    scene.asteroidTopLinearVelocityX = math.random( -10, 10 )
    scene.asteroidTopLinearVelocityY = math.random( 10, 40 )
    scene.asteroidRightLinearVelocityX = math.random( -40, -10 )
    scene.asteroidRightLinearVelocityY = math.random( 10, 20 )
    timer.cancel( scene.laserLoopTimer )
    timer.cancel( scene.gameLoopTimer )
    scene.applyShadowBackground()
    scene.laserLoopTimer = scene.startFire()
    scene.gameLoopTimer = scene.startAsteroids()
end

function scene.start()
    math.randomseed( os.time() )

    physics.start();
    physics.setGravity( 0, 0 )

    scene.background.x = display.contentCenterX
    scene.background.y = display.contentCenterY

    scene.ship = display.newImageRect( scene.mainGroup, sprite.objectSheet, 4, 98, 79 )
    scene.ship.x = display.contentCenterX
    scene.ship.y = display.contentHeight - 100

    physics.addBody( scene.ship, { radius=30, isSensor=true } )

    scene.ship.myName = "ship"

    scene.livesText = display.newText( scene.uiGroup, "Lives: " .. scene.lives, 200, 80, native.systemFont, 36)
    scene.scoreText = display.newText( scene.uiGroup, "Score: " .. scene.score, 400, 80, native.systemFont, 36)

    display.setStatusBar( display.HiddenStatusBar )

    scene.ship:addEventListener( "touch", scene.initGame )
    scene.ship:addEventListener( "touch", shipAction.drag( scene ) )
end

function scene:create( event )

    local sceneGroup = self.view

    scene.backGroup = display.newGroup();
    scene.mainGroup = display.newGroup();
    scene.uiGroup = display.newGroup();

    sceneGroup:insert( scene.backGroup )
    sceneGroup:insert( scene.mainGroup )
    sceneGroup:insert( scene.uiGroup )

    scene.background = image.background( scene.backGroup )
end

function scene:show( event )
    local phase = event.phase

    if ( phase == "will" ) then
        scene.start()
    end
end

function scene:hide( event )
    local phase = event.phase

    if ( phase == "will" ) then
        scene.stopGame()
    end
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
