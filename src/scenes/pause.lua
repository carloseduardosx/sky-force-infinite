local composer = require( "composer" )

local scene = composer.newScene()
local resumeText = nil

function resumeGame()
    composer.hideOverlay( "fade", 400 )
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        resumeText = display.newText( sceneGroup, "Resume Game", display.contentCenterX, display.contentCenterY, native.systemFont, 36)
    elseif ( phase == "did" ) then
        resumeText:addEventListener( "tap", resumeGame )
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent

    if ( phase == "did" ) then
        display.remove( resumeText )
        resumeText:removeEventListener( "tap", resumeGame )
        parent:resumeGame()
    end
end



scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene
