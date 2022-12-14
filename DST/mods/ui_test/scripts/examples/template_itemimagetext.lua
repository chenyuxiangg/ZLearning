local SZ = require("screen/zscreenunit")
local TEMPLATES = require("widgets/redux/templates")
require("fonts")

local itemimagetext = function(self)
    function self:ShowSZ()
        local TEXT_WIDTH = 300
        local TEXT_OFFSET = 40
        local FONT = BUTTONFONT
        local FONT_SIZE = 32
        local ITEM_SCALE = 0.6

        local iit = TEMPLATES.ItemImageText("body", "body_default1", ITEM_SCALE, FONT, FONT_SIZE, "test", GREY, TEXT_WIDTH, TEXT_OFFSET)
        local objdata = {
            ["obj"] = iit,
            ["posx"] = nil,
            ["posy"] = nil,
        }
        local zs = SZ(self, objdata)
        zs:Show()
        return zs
    end

    self.openbtn = self:AddChild(TEMPLATES.StandardButton(function() self:ShowSZ() end, "open", {100, 50}, nil))
    self.openbtn:SetPosition(100, 100)
end

return itemimagetext