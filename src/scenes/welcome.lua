local composer = require( "composer" )
local star = require( "src.objects.star" )
local image = require( "src.images.image" )
local sounds = require( "src.objects.sounds" )

local Welcome = {}
local scene = composer.newScene()
local startText = nil
local recordsText = nil
local titleText = nil

Welcome.minorStars = display.newGroup()
Welcome.mediumStars = display.newGroup()
Welcome.largeStars = display.newGroup()
Welcome.starsTable = {}
Welcome.backgroundSound = nil
Welcome.starsGeneratorDelay = 500
Welcome.minorStarLinearVelocity = 100
Welcome.mediumStarLinearVelocity = 150
Welcome.largeStarLinearVelocity = 200

function goToApplication()
    composer.gotoScene( "src.scenes.game" )
end

function goToRecords()
    composer.gotoScene( "src.scenes.records" )
end

function Welcome.initStars()
    star.startStarsMovement( Welcome )
    return timer.performWithDelay(
        Welcome.starsGeneratorDelay,
        star.generator( Welcome, physics ),
        0
    )
end

function scene:create( event )
    math.randomseed( os.time() )
    local sceneGroup = self.view
    local background = image.background( sceneGroup )
    physics.start();
    physics.setGravity( 0, 0 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert( Welcome.minorStars )
    sceneGroup:insert( Welcome.mediumStars )
    sceneGroup:insert( Welcome.largeStars )
    star.createStarts( Welcome, physics, true, 200, false)
    titleText = display.newText( sceneGroup, "SKY FORCE\n\n\t INFINITE", display.contentCenterX, 250, "starwars.ttf", 60 )
    startText = display.newText( sceneGroup, "Start Game", display.contentCenterX, display.contentCenterY, "Arvo-Regular.ttf", 45)
    recordsText = display.newText( sceneGroup, "Records", display.contentCenterX, display.contentCenterY + 100, "Arvo-Regular.ttf", 45)
    titleText:setFillColor( 1, 1, 1, 1.0 )
    transition.to( background, { time=0, alpha=0.4 } )
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        Welcome.starLoopTimer = Welcome.initStars()
        audio.reserveChannels( 1 )
        audio.setVolume( 1.0, { channel=1 } )
        Welcome.backgroundSound = sounds.startBackground()
        audio.play( Welcome.backgroundSound, { channel=1 } )
    elseif ( phase == "did" ) then
        startText:addEventListener( "tap", goToApplication )
        recordsText:addEventListener( "tap", goToRecords )
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        audio.stop()
        audio.dispose( Welcome.backgroundSound )
        Welcome.backgroundSound = nil
        audio.reserveChannels( 0 )
        star.stopStarsMovement( Welcome )
        timer.cancel( Welcome.starLoopTimer )
    elseif ( phase == "did" ) then
        startText:removeEventListener( "tap", goToApplication )
        recordsText:removeEventListener( "tap", goToRecords )
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
    star.remove( Welcome )
    sceneGroup:remove( Welcome.mediumStars )
    scenegroup:remove( Welcome.minorStars )
    scenegroup:remove( Welcome.largeStars )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
