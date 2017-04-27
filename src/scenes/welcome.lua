local composer = require( "composer" )
local star = require( "src.objects.star" )
local image = require( "src.images.image" )

local Welcome = {}
local scene = composer.newScene()
local startText = nil

Welcome.minorStars = display.newGroup()
Welcome.mediumStars = display.newGroup()
Welcome.largeStars = display.newGroup()
Welcome.starsTable = {}

function goToApplication()
    composer.gotoScene( "src.scenes.game" )
end

function scene:create( event )
    local sceneGroup = self.view
end

function scene:show( event )
    math.randomseed( os.time() )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        physics.start();
        physics.setGravity( 0, 0 )
        local background = image.background( sceneGroup )
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        sceneGroup:insert( Welcome.minorStars )
        sceneGroup:insert( Welcome.mediumStars )
        sceneGroup:insert( Welcome.largeStars )
        star.createStarts( Welcome, physics, true, 200, false)
        startText = display.newText( sceneGroup, "Start Game", display.contentCenterX, display.contentCenterY, native.systemFont, 36)
    elseif ( phase == "did" ) then
        startText:addEventListener( "tap", goToApplication )
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
        startText:removeEventListener( "tap", goToApplication )
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
    sceneGroup:remove( Welcome.mediumStars )
    scenegroup:remove( welcome.minorstars )
    scenegroup:remove( welcome.largestars )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
