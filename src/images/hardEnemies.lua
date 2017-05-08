--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:7501158b5dcdeb76f722373c5373a50a:5206173d460ded43db1d92a03f86ef2b:d9d40a89268f9774248f82d42e24b665$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- Alien-Battleship
            x=1,
            y=515,
            width=188,
            height=256,

            sourceX = 34,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- Alien-Mothership
            x=1,
            y=1,
            width=348,
            height=512,

            sourceX = 82,
            sourceY = 0,
            sourceWidth = 512,
            sourceHeight = 512
        },
    },
    
    sheetContentWidth = 350,
    sheetContentHeight = 772
}

SheetInfo.frameIndex =
{

    ["Alien-Battleship"] = 1,
    ["Alien-Mothership"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
