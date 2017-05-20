local image = require( "src.images.image" )

local Pause = {}

function Pause.create( application )
    application.pause = image.pause( application.uiGroup )
    application.pause.x = display.contentWidth - 150
    application.pause.y = 80
    -- applicaiton.pause:addEventListener( "click", ) Show overlay scene
end

function Pause.remove ( application )
    display.remove( application.pause )
end

return Pause
