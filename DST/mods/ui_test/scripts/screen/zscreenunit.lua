local WIDGET = require("widgets/screen")
local ZDEBUG = require("debug/debug")
local TEMPLATES = require("widgets/redux/templates")
require("strings")

local z_widget_index = 0

-- description: 通过组合原生代码提供的功能，创建自己的可UI组件
-- args: 
--      obj: 可以是任意由Widget派生的UI组件
local ZScreenUnit = Class(WIDGET, function(self, parent, objdata)
    WIDGET._ctor(self, "Zscreen_" .. tostring(z_widget_index))
    self.parent = parent
    self.panelposx = objdata["posx"] or 0
    self.panelposy = objdata["posy"] or 0

    self.topright_root = self:AddChild(WIDGET("z_side"))
    self.topright_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.topright_root:SetHAnchor(ANCHOR_MIDDLE)
    self.topright_root:SetVAnchor(ANCHOR_TOP)
    self.topright_root:SetMaxPropUpscale(MAX_HUD_SCALE)
    self.topright_root = self.topright_root:AddChild(WIDGET("tr_z_side"))

    self.panel = self.topright_root:AddChild(objdata["obj"])

    self.default_focus = self.panel
    TheInputProxy:SetCursorVisible(true)
end)

function ZScreenUnit:Show()
    if self and self.panel then
        TheFrontEnd:PushScreen(self)
    end
end

function ZScreenUnit:Close()
    TheFrontEnd:PopScreen(self)
end

-- function ZScreenUnit:OnBecomeActive()
--     TheSim:SetUIRoot(self.inst.entity)
--     if self.last_focus and self.last_focus.inst.entity:IsValid() then
--         self.last_focus:SetFocus()
--     else
--         self.last_focus = nil
--         if self.default_focus then
--             self.default_focus:SetFocus()
--         end
--     end
-- end

-- function ZScreenUnit:OnBecomeInactive()
--     self.last_focus = self:GetDeepestFocus()
-- end

-- function ZScreenUnit:OnUpdate(dt)
--     return true
-- end
    
-- function ZScreenUnit:OnDestroy()
--     self:Kill()
-- end

return ZScreenUnit