--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:14f1e62f55d7f5242c38cbb240cc1172:0d7e9d0e9a9eaacc1ebd88e871ce9d63:202d7ad1136b4beb2111947776ecb911$
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
            -- Alien-Battlecruiser
            x=171,
            y=1,
            width=162,
            height=256,

            sourceX = 47,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
        {
            -- Alien-HeavyCruiser
            x=1,
            y=1,
            width=168,
            height=256,

            sourceX = 44,
            sourceY = 0,
            sourceWidth = 256,
            sourceHeight = 256
        },
    },
    
    sheetContentWidth = 334,
    sheetContentHeight = 258
}

SheetInfo.frameIndex =
{

    ["Alien-Battlecruiser"] = 1,
    ["Alien-HeavyCruiser"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
