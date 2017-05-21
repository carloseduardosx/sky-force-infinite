local composer = require( "composer" )
local physics = require( "physics" )
local application = require( "src.scenes.application" )
local sprite = require( "src.images.sprite" )
local image = require( "src.images.image" )
local star = require( "src.objects.star" )
local laser = require( "src.objects.laser" )
local shipAction = require( "src.objects.ship" )
local event = require( "src.events.collision" )
local sounds = require( "src.objects.sounds" )
local scene = composer.newScene()


function scene:create( event )
    local sceneGroup = self.view
    sceneGroup:insert(application.backGroup)
    sceneGroup:insert(application.minorStars)
    sceneGroup:insert(application.mediumStars)
    sceneGroup:insert(application.largeStars)
    sceneGroup:insert(application.mainGroup)
    sceneGroup:insert(application.uiGroup)
    application.background = image.background( application.backGroup )
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        application.start()
        audio.reserveChannels( 5 )
        audio.setVolume( 1.0, { channel=1 })
        audio.setVolume( 0.1, { channel=2 })
        audio.setVolume( 0.1, { channel=3 })
        audio.setVolume( 0.1, { channel=4 })
        audio.setVolume( 0.1, { channel=5 })
        application.soundTable.gameBackground = sounds.gameBackground()
        application.soundTable.shotSound = sounds.shot()
        application.soundTable.enemyExplosion = sounds.enemyExplosion()
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        application.endGame()
        for k,v in pairs( application.soundTable ) do
            audio.stop()
            audio.dispose( v )
            application.soundTable[k] = nil
        end
        audio.reserveChannels( 0 )
    end
end

function scene:resumeGame()
    application.slowMotion()
end

function scene:destroy( event )

    local sceneGroup = self.view
    sceneGroup:remove(application.backGroup)
    sceneGroup:remove(application.minorStars)
    sceneGroup:remove(application.mediumStars)
    sceneGroup:remove(application.largeStars)
    sceneGroup:remove(application.mainGroup)
    sceneGroup:remove(application.uiGroup)
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
