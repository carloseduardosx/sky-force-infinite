local Sprite = {}

Sprite.sheetOptions = {
    frames = {
        {
            x = 0,
            y = 0,
            width = 102,
            height = 85
        },
        {
            x = 0,
            y = 85,
            width = 90,
            height = 83
        },
        {
            x = 0,
            y = 168,
            width = 100,
            height = 97
        },
        {
            x = 0,
            y = 265,
            width = 98,
            height = 79
        },
        {
            x = 98,
            y = 265,
            width = 14,
            height = 40
        },
    },
}
Sprite.objectSheet = graphics.newImageSheet( "assets/gameObjects.png", Sprite.sheetOptions )

return Sprite