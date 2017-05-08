--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:6a776a8bcd145e5052739bde1318f5b8:780c827a93f56da8d61c81326cd98a19:bce0c3083efa1f7e4d66d85be74a687c$
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
            -- Alien-Bomber
            x=165,
            y=131,
            width=86,
            height=128,

            sourceX = 22,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
        {
            -- Alien-Cruiser
            x=1,
            y=1,
            width=162,
            height=254,

            sourceX = 47,
            sourceY = 1,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- Alien-Destroyer
            x=1,
            y=257,
            width=122,
            height=256,

            sourceX = 67,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- Alien-Frigate
            x=125,
            y=261,
            width=116,
            height=256,

            sourceX = 70,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- Alien-Scout
            x=165,
            y=1,
            width=88,
            height=128,

            sourceX = 21,
            sourceY = 0,
            sourceWidth = 128,
            sourceHeight = 128
        },
    },
    
    sheetContentWidth = 254,
    sheetContentHeight = 518
}

SheetInfo.frameIndex =
{

    ["Alien-Bomber"] = 1,
    ["Alien-Cruiser"] = 2,
    ["Alien-Destroyer"] = 3,
    ["Alien-Frigate"] = 4,
    ["Alien-Scout"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
