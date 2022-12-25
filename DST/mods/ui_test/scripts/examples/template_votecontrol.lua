local WIDGET = require("widgets/widget")

local vote = function(self)
    function self:OpenVote()
        if self.votewindow then
            self.votewindow.open = true
            self.votewindow:MoveTo(Vector3(0, -100, 0), Vector3(0, -50, 0), .33, nil)
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
    self.votewindow.open = false
    self.votewindow:Hide()
    return self.votewindow
end

return vote