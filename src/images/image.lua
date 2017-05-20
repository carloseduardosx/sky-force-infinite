local Image = {}

function Image.background( group )
    return display.newImageRect( group, "assets/background.png", 800, 1400 )
end

function Image.ship ( group )
    return display.newImageRect( group, "assets/main_ship.png", 124, 135 )
end

function Image.pause( group )
    return display.newImageRect( group, "assets/pause_icon.png", 64, 64 )
end

return Image
