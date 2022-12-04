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

        local iit = TEMPLATES.ItemImageText("body", "body_default1", ITEM_SCALE, FONT, FONT_SIZE, "", GREY, TEXT_WIDTH, TEXT_OFFSET)
        objdata = {
            ["obj"] = iit,
            ["posx"] = nil,
            ["posy"] = nil,
        }
        self.iit = self.iit or self:AddChild(SZ(self, objdata))
        self.iit:SetPosition(300, 300)
        self.iit:Show()
        return self.iit
    end

    function self:CloseSZ()
        if self.iit then
            self.iit:Close()
            self.iit = nil
        end
    end

    self.openbtn = self:AddChild(TEMPLATES.StandardButton(function() self:ShowSZ() end, "open", {100, 50}, nil))
    self.openbtn:SetPosition(100, 100)
end