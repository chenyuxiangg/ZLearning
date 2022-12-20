local WIDGET = require("widgets/widget")
local SCREEN = require("widgets/screen")
local ImageButton = require "widgets/imagebutton"

local ZScreenUnit = Class(SCREEN, function(self, parent)
    SCREEN._ctor(self, "Zscreen")
    self.parent = parent

    self.black = self:AddChild(ImageButton("images/global.xml", "square.tex"))
    self.black.image:SetVRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetHRegPoint(ANCHOR_MIDDLE)
    self.black.image:SetVAnchor(ANCHOR_MIDDLE)
    self.black.image:SetHAnchor(ANCHOR_MIDDLE)
    self.black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.black.image:SetTint(0,0,0,0) -- invisible, but clickable!
    self.black:SetOnClick(function() TheFrontEnd:PopScreen(self) end)

    self.topright_root = self:AddChild(WIDGET("z_side_top_right"))
    self.topright_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.topright_root:SetHAnchor(ANCHOR_RIGHT)
    self.topright_root:SetVAnchor(ANCHOR_TOP)
    self.topright_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.topleft_root = self:AddChild(WIDGET("z_side_top_left"))
    self.topleft_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.topleft_root:SetHAnchor(ANCHOR_LEFT)
    self.topleft_root:SetVAnchor(ANCHOR_TOP)
    self.topleft_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.topmiddle_root = self:AddChild(WIDGET("z_side_top_middle"))
    self.topmiddle_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.topmiddle_root:SetHAnchor(ANCHOR_MIDDLE)
    self.topmiddle_root:SetVAnchor(ANCHOR_TOP)
    self.topmiddle_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.left_root = self:AddChild(WIDGET("z_side_left"))
    self.left_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.left_root:SetHAnchor(ANCHOR_LEFT)
    self.left_root:SetVAnchor(ANCHOR_MIDDLE)
    self.left_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.right_root = self:AddChild(WIDGET("z_side_right"))
    self.right_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.right_root:SetHAnchor(ANCHOR_RIGHT)
    self.right_root:SetVAnchor(ANCHOR_MIDDLE)
    self.right_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.bottomright_root = self:AddChild(WIDGET("z_side_top_right"))
    self.bottomright_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.bottomright_root:SetHAnchor(ANCHOR_RIGHT)
    self.bottomright_root:SetVAnchor(ANCHOR_BOTTOM)
    self.bottomright_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.bottomleft_root = self:AddChild(WIDGET("z_side_top_left"))
    self.bottomleft_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.bottomleft_root:SetHAnchor(ANCHOR_LEFT)
    self.bottomleft_root:SetVAnchor(ANCHOR_BOTTOM)
    self.bottomleft_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.bottommiddle_root = self:AddChild(WIDGET("z_side_top_middle"))
    self.bottommiddle_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.bottommiddle_root:SetHAnchor(ANCHOR_MIDDLE)
    self.bottommiddle_root:SetVAnchor(ANCHOR_BOTTOM)
    self.bottommiddle_root:SetMaxPropUpscale(MAX_HUD_SCALE)

    self.topright_root = self.topright_root:AddChild(WIDGET("real_z_side_top_right"))
    self.topleft_root = self.topleft_root:AddChild(WIDGET("real_z_side_top_left"))
    self.topmiddle_root = self.topmiddle_root:AddChild(WIDGET("real_z_side_top_middle"))
    self.left_root = self.left_root:AddChild(WIDGET("real_z_side_left"))
    self.right_root = self.right_root:AddChild(WIDGET("real_z_side_right"))
    self.bottomleft_root = self.bottomleft_root:AddChild(WIDGET("real_z_side_bottom_left"))
    self.bottommiddle_root = self.bottommiddle_root:AddChild(WIDGET("real_z_side_bottom_middle"))
    self.bottomright_root = self.bottomright_root:AddChild(WIDGET("real_z_side_bottom_right"))
end)

return ZScreenUnit