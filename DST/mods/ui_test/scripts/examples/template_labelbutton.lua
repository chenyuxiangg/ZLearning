local ZS = require("screen/zscreenunit")
local TEMPLATES = require("widgets/redux/templates")

-- 类似于 include 功能
require("fonts")

local labelbutton = function(self)
    function self:ShowZS()
        local labelbtn = TEMPLATES.LabelButton(function() self:CloseSZ() end, "label", "btn", 100, 50, 50, 20, UIFONT, 25, nil)
        local objdata = {
            ["obj"] = labelbtn,
            ["posx"] = nil,
            ["posy"] = nil
        }
        self.labelbtn = self.labelbtn or self:AddChild(ZS(self, objdata))
        self.labelbtn:SetPosition(300, 300)
        self.labelbtn:Show()
        return self.labelbtn
    end

    function self:CloseSZ()
        if self.labelbtn then
            self.labelbtn:Close()
        end
        self.labelbtn = nil
    end

    self.openbtn = self:AddChild(TEMPLATES.StandardButton(function() self:ShowZS() end, "open", {100, 50}, nil))
    self.openbtn:SetPosition(100, 100)
end

return labelbutton