local SCREEN = require("widgets/screen")
local z_widget_index = 0

-- description: 通过组合原生代码提供的功能，创建自己的可UI组件
-- args: 
--      obj: 可以是任意由Widget派生的UI组件
local ZScreenUnit = Class(SCREEN, function(self, parent, objdata)
    SCREEN._ctor(self, "Zscreen_" .. tostring(z_widget_index))
    self.parent = parent

    self.panel = self:AddChild(objdata["obj"])

    function self.panel:OnBecomeActive()
        TheSim:SetUIRoot(self.inst.entity)
        if self.last_focus and self.last_focus.inst.entity:IsValid() then
            self.last_focus:SetFocus()
        else
            self.last_focus = nil
            if self.default_focus then
                self.default_focus:SetFocus()
            end
        end
    end

    function self.panel:OnBecomeInactive()
        self.last_focus = self:GetDeepestFocus()
    end

    function self.panel:OnUpdate(dt)
        return true
    end
        
    function self.panel:OnDestroy()
        self:Kill()
    end

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