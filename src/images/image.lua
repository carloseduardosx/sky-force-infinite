local Image = {}

function Image.background( group )
    return display.newImageRect( group, "assets/background.png", 800, 1400 )
end

return Image
