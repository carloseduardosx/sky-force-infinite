local physics = require( "physics" )
local sprite = require( "src.images.sprite" )
local image = require( "src.images.image" )
local asteroid = require( "src.objects.asteroid" )
local star = require( "src.objects.star" )
local laser = require( "src.objects.laser" )
local shipAction = require( "src.objects.ship" )
local event = require( "src.events.collision" )

local Application = {}

Application.lives = 3
Application.score = 0
Application.died = false

Application.asteroidsTable = {}
Application.starsTable = {}

Application.ship = nil
Application.gameLoopTimer = nil
Application.livesText = nil
Application.scoreText = nil

Application.backGroup = display.newGroup()
Application.minorStars = display.newGroup()
Application.mediumStars = display.newGroup()
Application.largeStars = display.newGroup()
Application.mainGroup = display.newGroup()
Application.uiGroup = display.newGroup()

Application.fireDelay = 300
Application.fireTime = 500

Application.asteroidGeneratorDelay = 500
Application.minorStarLinearVelocity = 50
Application.mediumStarLinearVelocity = 55
Application.largeStarLinearVelocity = 60
Application.asteroidLeftLinearVelocityX = math.random( 40, 120 )
Application.asteroidLeftLinearVelocityY = math.random( 20, 60 )
Application.asteroidTopLinearVelocityX = math.random( -40, 40 )
Application.asteroidTopLinearVelocityY = math.random( 40, 120 )
Application.asteroidRightLinearVelocityX = math.random( -120, -40 )
Application.asteroidRightLinearVelocityY = math.random( 20, 60 )
Application.minorStarLinearVelocity = math.random(10, 20)
Application.mediumStarLinearVelocity = math.random(30, 40)
Application.largeStarLinearVelocity = math.random(50, 60)

function Application.startFire()
    return timer.performWithDelay(
        Application.fireDelay,
        laser.fire( Application, physics ),
        0
    )
end

function Application.startAsteroids()
    return timer.performWithDelay(
        Application.asteroidGeneratorDelay,
        asteroid.generator( Application, physics ),
        0
    )
end

function Application.initStarts()
    star.startStarsMovement( Application )
    return timer.performWithDelay(
        Application.asteroidGeneratorDelay,
        star.generator( Application, physics ),
        0
    )
end

function Application.initGame()
    Application.laserLoopTimer = Application.startFire()
    Application.gameLoopTimer = Application.startAsteroids()
    Application.starLoopTimer = Application.initStarts()
    Runtime:addEventListener(
        "collision",
        event.onCollision( Application )
    )
    Application.ship:removeEventListener( "touch", Application.initGame )
end

function Application.stopGame()
    timer.cancel( Application.laserLoopTimer )
    timer.cancel( Application.gameLoopTimer )
    display.remove( Application.ship )
    Runtime:removeEventListener(
        "collision",
        event.onCollision( Application )
    )
end

function Application.removeShadowBackground()
    transition.to( Application.background, { time=500, alpha=1 } )
end

function Application.applyShadowBackground()
    transition.to( Application.background, { time=1000, alpha=0.4 } )
end

function Application.speedUp()
    Application.fireTime = 500
    Application.fireDelay = 300
    Application.asteroidGeneratorDelay = 500
    Application.asteroidLeftLinearVelocityX = math.random( 40, 120 )
    Application.asteroidLeftLinearVelocityX = math.random( 40, 120 )
    Application.asteroidLeftLinearVelocityY = math.random( 20, 60 )
    Application.asteroidTopLinearVelocityX = math.random( -40, 40 )
    Application.asteroidTopLinearVelocityY = math.random( 40, 120 )
    Application.asteroidRightLinearVelocityX = math.random( -120, -40 )
    Application.asteroidRightLinearVelocityY = math.random( 20, 60 )
    timer.cancel( Application.laserLoopTimer )
    timer.cancel( Application.gameLoopTimer )
    Application.removeShadowBackground()
    Application.laserLoopTimer = Application.startFire()
    Application.gameLoopTimer = Application.startAsteroids()
end

function Application.slowMotion()
    Application.fireTime = 5000
    Application.fireDelay = 1500
    Application.asteroidGeneratorDelay = 2000
    Application.asteroidLeftLinearVelocityX = math.random( 10, 40 )
    Application.asteroidLeftLinearVelocityY = math.random( 10, 20 )
    Application.asteroidTopLinearVelocityX = math.random( -10, 10 )
    Application.asteroidTopLinearVelocityY = math.random( 10, 40 )
    Application.asteroidRightLinearVelocityX = math.random( -40, -10 )
    Application.asteroidRightLinearVelocityY = math.random( 10, 20 )
    timer.cancel( Application.laserLoopTimer )
    timer.cancel( Application.gameLoopTimer )
    Application.applyShadowBackground()
    Application.laserLoopTimer = Application.startFire()
    Application.gameLoopTimer = Application.startAsteroids()
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

    star.createStarts( Application, physics, true, 200, false)

    Application.ship:addEventListener( "touch", Application.initGame )
    Application.ship:addEventListener( "touch", shipAction.drag( Application ) )

end

return Application
