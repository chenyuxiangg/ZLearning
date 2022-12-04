local SCREEN = require("widgets/screen")
local z_widget_index = 0

-- description: 通过组合原生代码提供的功能，创建自己的可UI组件
-- args: 
--      obj: 可以是任意由Widget派生的UI组件
local ZScreenUnit = Class(SCREEN, function(self, parent, objdata)
    SCREEN._ctor(self, "Zscreen_" .. tostring(z_widget_index))
    self.parent = parent

    self.panel = self:AddChild(objdata["obj"])
    self.panel:SetPosition(objdata["posx"] or 100, objdata["posy"] or 100)
end)

function ZScreenUnit:Show()
    if self and self.panel then
        TheFrontEnd:PushScreen(self.panel)
    end
end

function ZScreenUnit:Close()
    TheFrontEnd:PopScreen(self.panel)
    if self.panel then
        self.panel = nil
        self = nil
    end
end

return ZScreenUnit