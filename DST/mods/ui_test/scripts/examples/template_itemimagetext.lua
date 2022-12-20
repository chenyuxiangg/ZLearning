local ZS = require("screen/zscreenunit")
local TEMPLATES = require("widgets/redux/templates")
require("fonts")

local itemimagetext = function()
    local TEXT_WIDTH = 300
    local TEXT_OFFSET = 100
    local FONT = BUTTONFONT
    local FONT_SIZE = 32
    local ITEM_SCALE = 1

    local iit = TEMPLATES.ItemImageText("body", "body_default1", ITEM_SCALE, FONT, FONT_SIZE, "test", GREY, TEXT_WIDTH, TEXT_OFFSET)
    local zs = ZS()
    zs.left_root:AddChild(iit)
    TheFrontEnd:PushScreen(zs)
    return zs
end

return itemimagetext