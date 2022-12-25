local WIDGET = require("widgets/widget")

local vote = function(self)
    function self:OpenVote()
        if self.votewindow then
            self.votewindow.open = true
            self.votewindow:MoveTo(Vector3(0, 0, 0), Vector3(0, -50, 0), .33, nil)
            self.votewindow:Show()
        end
    end
    self.ztopmiddle_root = self:AddChild(WIDGET("ztopmiddle_root"))
    self.ztopmiddle_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.ztopmiddle_root:SetHAnchor(ANCHOR_MIDDLE)
    self.ztopmiddle_root:SetVAnchor(ANCHOR_TOP)
    self.ztopmiddle_root:SetMaxPropUpscale(MAX_HUD_SCALE)
    self.ztopmiddle_root = self.ztopmiddle_root:AddChild(WIDGET("real_ztopmiddle"))

    self.vote_pos_x = 0
    self.vote_pos_y = -50
    self.vote_scale_x = 2
    self.vote_scale_y = 1.5

    self.votewindow = self.ztopmiddle_root:AddChild(Image("images/ui.xml", "votewindow_controller_bottom.tex"))
    self.votewindow:SetPosition(self.vote_pos_x, self.vote_pos_y, 0)
    self.votewindow:SetScale(self.vote_scale_x, self.vote_scale_y, 1)

    self.votewindow.header_bg = self.votewindow:AddChild(Image("images/avatars.xml", "avatar_bg.tex"))
    self.votewindow.header_icon = self.votewindow:AddChild(Image("images/avatars.xml", "avatar_wilson.tex"))
    self.votewindow.header_frame = self.votewindow:AddChild(Image("images/avatars.xml", "avatar_frame_white.tex"))
    self.votewindow.header_bg:SetHAnchor(ANCHOR_LEFT)
    self.votewindow.header_bg:SetVAnchor(ANCHOR_MIDDLE)
    self.votewindow.header_bg:SetScale(0.5, 0.5, 0)
    self.votewindow.header_icon:SetHAnchor(ANCHOR_LEFT)
    self.votewindow.header_icon:SetVAnchor(ANCHOR_MIDDLE)
    self.votewindow.header_icon:SetScale(0.5, 0.5, 0)
    self.votewindow.header_frame:SetHAnchor(ANCHOR_LEFT)
    self.votewindow.header_frame:SetVAnchor(ANCHOR_MIDDLE)
    self.votewindow.header_frame:SetScale(0.5, 0.5, 0)

    self.votewindow.open = false
    self.votewindow:Hide()
    return self.votewindow
end

return vote