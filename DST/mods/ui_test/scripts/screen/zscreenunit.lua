local WIDGET = require("widgets/widget")
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

    self.panel = self:AddChild(objdata["obj"])

    self.topright_root = self:AddChild(WIDGET("z_side"))
    self.topright_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.topright_root:SetHAnchor(ANCHOR_RIGHT)
    self.topright_root:SetVAnchor(ANCHOR_TOP)
    self.topright_root:SetMaxPropUpscale(MAX_HUD_SCALE)
    self.topright_root = self.opright_root:AddChild(WIDGET("tr_z_side"))

    self.topright_root:AddChild(TEMPLATES.LoaderBackground("loading_pigking"))
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