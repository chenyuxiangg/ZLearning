local WIDGET = require("widgets/widget")
local ZDEBUG = require("debug/debug")
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

    self.panel = self:AddChild(objdata["obj"])
end)

function ZScreenUnit:Show()
    if self and self.panel then
        TheFrontEnd:PushScreen(self)
    end
end

function ZScreenUnit:Close()
    TheFrontEnd:PopScreen(self)
end

function ZScreenUnit:OnBecomeActive()
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

function ZScreenUnit:OnBecomeInactive()
    self.last_focus = self:GetDeepestFocus()
end

function ZScreenUnit:OnUpdate(dt)
    return true
end
    
function ZScreenUnit:OnDestroy()
    self:Kill()
end

function ZScreenUnit:OnRawKey(key, down)
    if ZScreenUnit._base.OnRawKey(self, key, down) then
        return true
    else
        if key == KEY_K then
            local curscrenn = TheFrontEnd:GetActiveScreen()
            if self.inst == curscrenn.inst then
                -- ZDEBUG:zprint(self.parent)
                self:Close()
            end
        end
        return true
    end
end

return ZScreenUnit