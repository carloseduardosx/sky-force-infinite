local composer = require( "composer" )
local physics = require( "physics" )
local sprite = require( "src.images.sprite" )
local image = require( "src.images.image" )
local enemies = require( "src.objects.enemies" )
local star = require( "src.objects.star" )
local laser = require( "src.objects.laser" )
local shipAction = require( "src.objects.ship" )
local event = require( "src.events.collision" )

local Application = {}

Application.died = false

Application.enemiesTable = {}
Application.lasersTable = {}
Application.starsTable = {}
Application.soundTable = {}

Application.ship = nil
Application.gameLoopTimer = nil
Application.livesText = nil
Application.scoreText = nil

Application.backGroup = display.newGroup();
Application.minorStars = display.newGroup();
Application.mediumStars = display.newGroup();
Application.largeStars = display.newGroup();
Application.mainGroup = display.newGroup();
Application.uiGroup = display.newGroup();

Application.fireDelay = 700
Application.easyEnemiesGeneratorDelay = 1000
Application.starsGeneratorDelay = 500
Application.minorStarLinearVelocity = 100
Application.mediumStarLinearVelocity = 150
Application.largeStarLinearVelocity = 200
Application.laserFastLinearVelocityY = -800
Application.laserSlowMotionLinearVelocityY = -100
Application.laserLinearVelocityY = laserFastLinearVelocityY
Application.easyEnemiesFastLinearVelocityY = 400
Application.easyEnemiesSlowLinearVelocityY = 100
Application.easyEnemiesLinearVelocityY = easyEnemiesFastLinearVelocityY

function Application.startFire()
    return timer.performWithDelay(
        Application.fireDelay,
        laser.generator( Application, physics ),
        0
    )
end

function Application.playBackgroundSoundLoop( event )
    audio.play( Application.soundTable.gameBackground, { channel=1, onComplete=Application.playBackgroundSoundLoop } )
end

function Application.startEasyEnemies()
    return timer.performWithDelay(
        Application.easyEnemiesGeneratorDelay,
        enemies.generator( Application, physics ),
        0
    )
end

function Application.initStars()
    star.startStarsMovement( Application )
    return timer.performWithDelay(
        Application.starsGeneratorDelay,
        star.generator( Application, physics ),
        0
    )
end

function Application.initGame()
    Application.playBackgroundSoundLoop()
    Application.laserLoopTimer = Application.startFire()
    Application.gameLoopTimer = Application.startEasyEnemies()
    Application.starLoopTimer = Application.initStars()
    Runtime:addEventListener( "collision", event.onCollision( Application ) )
    Application.ship:removeEventListener( "touch", Application.initGame )
    Application.pause:addEventListener( "tap", Application.pauseGame )
end

function Application.endGame()
    star.stopStarsMovement( Application )

    timer.cancel( Application.starLoopTimer )
    timer.cancel( Application.laserLoopTimer )
    timer.cancel( Application.gameLoopTimer )

    Application.ship:removeEventListener( "touch", Application.initGame )
    Application.ship:removeEventListener( "touch", shipAction.drag( Application ) )
    Runtime:removeEventListener( "collision", event.onCollision( Application ) )

    star.remove( Application )
    enemies.remove( Application )
    display.remove( Application.ship )
    display.remove( Application.pause )
    display.remove( Application.livesText )
    display.remove( Application.scoreText )
end

function Application.removeShadowBackground()
    transition.to( Application.background, { time=500, alpha=1 } )
end

function Application.applyShadowBackground()
    transition.to( Application.background, { time=1000, alpha=0.4 } )
end

function Application.speedUp()
    Application.fireDelay = 500
    Application.starsGeneratorDelay = 500
    Application.easyEnemiesGeneratorDelay = 1000
    timer.cancel( Application.starLoopTimer )
    timer.cancel( Application.laserLoopTimer )
    timer.cancel( Application.gameLoopTimer )
    Application.removeShadowBackground()
    enemies.speedUp( Application )
    laser.speedUp( Application )
    Application.starLoopTimer = Application.initStars()
    Application.laserLoopTimer = Application.startFire()
    Application.gameLoopTimer = Application.startEasyEnemies()
end

function Application.pauseGame()
    local options = {
        isModal = true,
        effect = "fade",
        time = 400,
    }
    composer.showOverlay( "src.scenes.pause", options )
    star.stopStarsMovement( Application )
    timer.cancel( Application.starLoopTimer )
    timer.cancel( Application.laserLoopTimer )
    timer.cancel( Application.gameLoopTimer )
    enemies.slowMotion( Application, true)
    laser.slowMotion( Application, true )
end

function Application.slowMotion()
    Application.fireDelay = 1500
    Application.starsGeneratorDelay = 2000
    Application.easyEnemiesGeneratorDelay = 3000
    timer.cancel( Application.starLoopTimer )
    timer.cancel( Application.laserLoopTimer )
    timer.cancel( Application.gameLoopTimer )
    Application.applyShadowBackground()
    enemies.slowMotion( Application )
    laser.slowMotion( Application )
    Application.starLoopTimer = Application.initStars()
    Application.laserLoopTimer = Application.startFire()
    Application.gameLoopTimer = Application.startEasyEnemies()
end

function Application.start()
    math.randomseed( os.time() )

    physics.start();
    physics.setGravity( 0, 0 )

    Application.lives = 3
    Application.score = 0

    Application.background.x = display.contentCenterX
    Application.background.y = display.contentCenterY

    Application.ship = image.ship( Application.mainGroup )
    Application.ship.x = display.contentCenterX
    Application.ship.y = display.contentHeight - 100

    Application.pause = image.pause( Application.uiGroup )
    Application.pause.x = display.contentWidth - 150
    Application.pause.y = 80

    physics.addBody( Application.ship, { radius=60, isSensor=true } )

    Application.ship.myName = "ship"

    Application.livesText = display.newText( Application.uiGroup, "Lives: " .. Application.lives, 200, 80, native.systemFont, 36)
    Application.scoreText = display.newText( Application.uiGroup, "Score: " .. Application.score, 400, 80, native.systemFont, 36)

    display.setStatusBar( display.HiddenStatusBar )

    star.createStarts( Application, physics, true, 200, false)

    Application.ship:addEventListener( "touch", Application.initGame )
    Application.ship:addEventListener( "touch", shipAction.drag( Application ) )
end

return Application
