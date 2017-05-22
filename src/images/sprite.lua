local easyEnemiesInfo = require( "src.images.easyEnemies" )

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

Sprite.minorStartOptions = {
    frames = {
        {
            x = 5,
            y = 5,
            width = 5,
            height = 5
        }
    }
}

Sprite.mediumStartOptions = {
    frames = {
        {
            x = 5,
            y = 5,
            width = 5,
            height = 5
        },
        {
            x = 4,
            y = 20,
            width = 7,
            height = 7
        }
    }
}

Sprite.largeStartOptions = {
    frames = {
        {
            x = 4,
            y = 4,
            width = 7,
            height = 7
        },
        {
            x = 3,
            y = 19,
            width = 9,
            height = 9
        }
    }
}

Sprite.startSequence = {
    {
        name = "normalBliking",
        start = 1,
        count = 2,
        time = 500,
        loopCount = 0
    }
}

Sprite.auraSequence = {
    {
        name = "shipFocus",
        start = 1,
        count = 6,
        time = 800,
        loopCount = 0,
        loopDirection = "forward"
    }
}

Sprite.auraOptions = {
    frames = {
        {
            x = 0,
            y = 0,
            width = 165,
            height = 165
        },
        {
            x = 165,
            y = 0,
            width = 165,
            height = 165
        },
        {
            x = 0,
            y = 165,
            width = 165,
            height = 165
        },
        {
            x = 165,
            y = 165,
            width = 165,
            height = 165
        },
        {
            x = 0,
            y = 330,
            width = 165,
            height = 165
        },
        {
            x = 165,
            y = 330,
            width = 165,
            height = 165
        }
    }
}

Sprite.objectSheet = graphics.newImageSheet( "assets/gameObjects.png", Sprite.sheetOptions )
Sprite.easyEnemiesSheet = graphics.newImageSheet( "assets/enemies/easy/easyEnemies.png", easyEnemiesInfo:getSheet() )
Sprite.minorStarSheet = graphics.newImageSheet( "assets/star_minor_size.png", Sprite.minorStartOptions )
Sprite.mediumStarsSheet = graphics.newImageSheet( "assets/star_medium_size.png", Sprite.mediumStartOptions )
Sprite.largeStarsSheet = graphics.newImageSheet( "assets/star_large_size.png", Sprite.largeStartOptions )
Sprite.auraSheet = graphics.newImageSheet( "assets/aura.png", Sprite.auraOptions )

return Sprite
