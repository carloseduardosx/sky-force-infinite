local composer = require( "composer" )
local star = require( "src.objects.star" )
local image = require( "src.images.image" )

local Welcome = {}
local scene = composer.newScene()
local startText = nil
local recordsText = nil

Welcome.minorStars = display.newGroup()
Welcome.mediumStars = display.newGroup()
Welcome.largeStars = display.newGroup()
Welcome.starsTable = {}

function goToApplication()
    composer.gotoScene( "src.scenes.game" )
end

function goToRecords()
    composer.gotoScene( "src.scenes.records" )
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
    startText = display.newText( sceneGroup, "Start Game", display.contentCenterX, display.contentCenterY - 50, native.systemFont, 36)
    recordsText = display.newText( sceneGroup, "Records", display.contentCenterX, display.contentCenterY + 50, native.systemFont, 36)
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "did" ) then
        startText:addEventListener( "tap", goToApplication )
        recordsText:addEventListener( "tap", goToRecords )
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "did" ) then
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
