local composer = require( "composer" )
local record = require( "src.model.record" )
local logger = require( "src.util.logger" )
local star = require( "src.objects.star" )
local image = require( "src.images.image" )
local sounds = require( "src.objects.sounds" )

local Records = {}
local scene = composer.newScene()
local backText = nil
local noRecordsText = nil
local titleText = nil

Records.minorStars = display.newGroup()
Records.mediumStars = display.newGroup()
Records.largeStars = display.newGroup()
Records.starsTable = {}
Records.records = {}
Records.backgroundSound = nil
Records.starsGeneratorDelay = 500
Records.minorStarLinearVelocity = 100
Records.mediumStarLinearVelocity = 150
Records.largeStarLinearVelocity = 200

function Records.playBackgroundSoundLoop( event )
    audio.play( Records.backgroundSound, { channel=1, onComplete=Records.playBackgroundSoundLoop } )
end

function Records.initStars()
    star.startStarsMovement( Records )
    return timer.performWithDelay(
        Records.starsGeneratorDelay,
        star.generator( Records, physics ),
        0
    )
end

function Records.loadRecords( sceneGroup )
    local records = record.load()
    local count = 1
    if ( records ) then
        for i = #records, 1, -1 do
            table.insert (
                Records.records,
                display.newText( sceneGroup, "" .. count .. "˚- " .. records[i], display.contentCenterX, 120 + (70 * count), "Arvo-Regular.ttf", 36 )
            )
            count = count + 1
        end
        backText = display.newText( sceneGroup, "<< Back", display.contentCenterX, 120 + (70 * count), "Arvo-Regular.ttf", 45 )
    else
        noRecordsText = display.newText( sceneGroup, "No records found!", display.contentCenterX, display.contentCenterY - 50, "Arvo-Regular.ttf", 45 )
        backText = display.newText( sceneGroup, "<< Back", display.contentCenterX, display.contentCenterY + 50, "Arvo-Regular.ttf", 45 )
    end
    titleText = display.newText( sceneGroup, "RECORDS", display.contentCenterX, 100, "starwars.ttf", 60 )
    titleText:setFillColor( 1, 1, 1, 1.0 )
end

function Records.removeTexts()
    for i = #Records.records, 1, -1 do
        display.remove( Records.records[i] )
        Records.records[i] = nil
    end
    display.remove( backText )
    if ( noRecordsText ) then
        display.remove( noRecordsText )
    end
end

function backToApplication()
    composer.gotoScene( "src.scenes.welcome" )
end

function scene:create( event )
    math.randomseed( os.time() )
    local sceneGroup = self.view
    local background = image.background( sceneGroup )
    physics.start();
    physics.setGravity( 0, 0 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert( Records.minorStars )
    sceneGroup:insert( Records.mediumStars )
    sceneGroup:insert( Records.largeStars )
    star.createStarts( Records, physics, true, 200, false)
    transition.to( background, { time=0, alpha=0.4 } )
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        Records.loadRecords( sceneGroup )
        audio.reserveChannels( 1 )
        audio.setVolume( 1.0, { channel=1 } )
        Records.backgroundSound = sounds.startBackground()
        Records.playBackgroundSoundLoop()
        Records.starLoopTimer = Records.initStars()
    elseif ( phase == "did" ) then
        backText:addEventListener( "tap", backToApplication )
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        audio.stop()
        audio.dispose( Records.backgroundSound )
        Records.backgroundSound = nil
        audio.reserveChannels( 0 )
        star.stopStarsMovement( Records )
        timer.cancel( Records.starLoopTimer )
    elseif ( phase == "did" ) then
        Records.removeTexts()
        backText:removeEventListener( "tap", backToApplication )
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
    star.remove( Records )
    sceneGroup:remove( Records.mediumStars )
    scenegroup:remove( Records.minorStars )
    scenegroup:remove( Records.largeStars )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
