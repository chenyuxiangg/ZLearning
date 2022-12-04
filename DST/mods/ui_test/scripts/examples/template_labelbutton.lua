local ZS = require("screen/zscreenunit")
local TEMPLATES = require("widgets/redux/templates")

-- 类似于 include 功能
require("fonts")

local labelbutton = function(self)
    local labelbtn = TEMPLATES.LabelButton(function()end, "label", "btn", 10, 5, 5, 2, UIFONT, 10, nil)
    self.labelbtn = self:AddChild(ZS(self, labelbtn))
    self.labelbtn:SetPosition(300, 300)

    self.openbtn = self:AddChild(TEMPLATES.StandardButton(function() self.labelbtn:Show() end, "open", {100, 50}, nil))
    self.openbtn:SetPosition(100, 100)
end

return labelbutton