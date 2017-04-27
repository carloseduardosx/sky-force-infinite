local composer = require( "composer" )
local physics = require( "physics" )
local application = require( "src.scenes.application" )
local sprite = require( "src.images.sprite" )
local image = require( "src.images.image" )
local asteroid = require( "src.objects.asteroid" )
local star = require( "src.objects.star" )
local laser = require( "src.objects.laser" )
local shipAction = require( "src.objects.ship" )
local event = require( "src.events.collision" )
local scene = composer.newScene()

function scene:create( event )

    local sceneGroup = self.view
    sceneGroup:insert(application.backGroup)
    sceneGroup:insert(application.minorStars)
    sceneGroup:insert(application.mediumStars)
    sceneGroup:insert(application.largeStars)
    sceneGroup:insert(application.mainGroup)
    sceneGroup:insert(application.uiGroup)
end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        application.background = image.background( application.backGroup )
        application.start()
    elseif ( phase == "did" ) then
        -- Nothing todo here yet
    end
end

function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
       Application.stopGame()
   elseif ( phase == "did" ) then
       -- Nothing todo here yet
   end
end

function scene:destroy( event )

   local sceneGroup = self.view
   -- Nothing todo here yet
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
