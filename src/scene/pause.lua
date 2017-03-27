local compose = require ( "composer" )

local scene = compose.newScene();
local pauseText

function scene:create( event )
    local sceneGroup = self.view
    pauseText = display.newText(
        sceneGroup,
        "Resume",
        display.contentCenterX,
        display.contentCenterY,
        native.systemFont,
        50
    )
end

function scene:show( event )
    local phase = event.phase
    local parent = event.parent -- Application

    if ( phase == "will" ) then
        -- TODO Pause game
    end
    scene.textClickListener = pauseText:addEventListener( "click", scene.resumeGame )
end

function scene:hide( event )
    local phase = event.phase
    local parent = event.parent

    if ( phase == "will" ) then
        -- TODO Resume game -- Application
    end
    pauseText:removeEventListener( "click", scene.textClickListener )
end

function scene:destroy( event )
    display.remove( pauseText )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
