local WIDGET = require("widgets/screen")
local ZDEBUG = require("debug/debug")
local TEMPLATES = require("widgets/redux/templates")
local ImageButton = require "widgets/imagebutton"
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

    self.black = self:AddChild(ImageButton("images/global.xml", "square.tex"))
    self.black.image:SetVRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetHRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetVAnchor(ANCHOR_MIDDLE)
    self.black.image:SetHAnchor(ANCHOR_MIDDLE)
    self.black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black.image:SetTint(1,1,1,1) -- invisible, but clickable!
    self.black:SetOnClick(function() self:Close() end)
end)

function ZScreenUnit:Show()
    if self and self.panel then
        TheFrontEnd:PushScreen(self)
    end
end

function ZScreenUnit:Close()
    TheFrontEnd:PopScreen(self)
end

return ZScreenUnit