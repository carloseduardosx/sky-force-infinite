local composer = require ( "composer" )

local Application = {}

Application.options = {
    effect = "fade",
    time = 500
}

function Application.startGame()
    composer.gotoScene( "src.scene.game", Application.options )
end

return Application
