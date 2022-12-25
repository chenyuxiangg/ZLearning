local WIDGET = require("widgets/widget")

local vote = function(self)
    function self:OpenVote()
        if self.votewindow then
            self.votewindow.open = true
            self.votewindow:MoveTo(Vector3(0, 0, 0), Vector3(0, -50, 0), .33, nil)
            self.votewindow:Show()
        end
    end

    function self:UpdateHeaderInfo(infotype, dir)
        if infotype == "x" then
            if dir == "add" then
                self.votewindow.scrollbarline_x = self.votewindow.scrollbarline_x+1
            elseif dir == "sub" then
                self.votewindow.scrollbarline_x = self.votewindow.scrollbarline_x-1
            end
        elseif infotype == "y" then
            if dir == "add" then
                self.votewindow.scrollbarline_y = self.votewindow.scrollbarline_y+1
            elseif dir == "sub" then
                self.votewindow.scrollbarline_y = self.votewindow.scrollbarline_y-1
            end
        elseif infotype == "sx" then
            if dir == "add" then
                self.votewindow.scrollbarline_sx = self.votewindow.scrollbarline_sx+0.1
            elseif dir == "sub" then
                self.votewindow.scrollbarline_sx = self.votewindow.scrollbarline_sx-0.1
            end
        elseif infotype == "sy" then
            if dir == "add" then
                self.votewindow.scrollbarline_sy = self.votewindow.scrollbarline_sy+0.1
            elseif dir == "sub" then
                self.votewindow.scrollbarline_sy = self.votewindow.scrollbarline_sy-0.1
            end
        end
        self.votewindow.scrollbarline:SetPosition(self.votewindow.scrollbarline_x, self.votewindow.scrollbarline_y, 0)
        self.votewindow.scrollbarline:SetScale(self.votewindow.scrollbarline_sx, self.votewindow.scrollbarline_sy, 0)
    end

    function self:GetHeaderInfo()
        print("x: ", self.votewindow.scrollbarline_x, ", y: ", self.votewindow.scrollbarline_y, ", sx: ", self.votewindow.scrollbarline_sx, ", sy: ", self.votewindow.scrollbarline_sy)
    end

    self.ztopmiddle_root = self:AddChild(WIDGET("ztopmiddle_root"))
    self.ztopmiddle_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.ztopmiddle_root:SetHAnchor(ANCHOR_MIDDLE)
    self.ztopmiddle_root:SetVAnchor(ANCHOR_TOP)
    self.ztopmiddle_root:SetMaxPropUpscale(MAX_HUD_SCALE)
    self.ztopmiddle_root = self.ztopmiddle_root:AddChild(WIDGET("real_ztopmiddle"))

    self.vote_scale_x = 2
    self.vote_scale_y = 1.5

    self.votewindow = self.ztopmiddle_root:AddChild(Image("images/ui.xml", "votewindow_controller_bottom.tex"))
    self.votewindow:SetScale(self.vote_scale_x, self.vote_scale_y, 1)

    self.votewindow.header_x = -113
    self.votewindow.header_y = 10.5
    self.votewindow.header_sx = 0.4
    self.votewindow.header_sy = 0.5

    self.votewindow.scrollbarline_x = -110
    self.votewindow.scrollbarline_y = 10.5
    self.votewindow.scrollbarline_sx = 0.4
    self.votewindow.scrollbarline_sy = 0.5

    self.votewindow.header_bg = self.votewindow:AddChild(Image("images/avatars.xml", "avatar_bg.tex"))
    self.votewindow.header_icon = self.votewindow:AddChild(Image("images/avatars.xml", "avatar_wilson.tex"))
    self.votewindow.header_frame = self.votewindow:AddChild(Image("images/avatars.xml", "avatar_frame_white.tex"))
    self.votewindow.header_bg:SetPosition(self.votewindow.header_x, self.votewindow.header_y, 0)
    self.votewindow.header_bg:SetScale(self.votewindow.header_sx, self.votewindow.header_sy, 0)
    self.votewindow.header_icon:SetPosition(self.votewindow.header_x, self.votewindow.header_y, 0)
    self.votewindow.header_icon:SetScale(self.votewindow.header_sx, self.votewindow.header_sy, 0)
    self.votewindow.header_frame:SetPosition(self.votewindow.header_x, self.votewindow.header_y, 0)
    self.votewindow.header_frame:SetScale(self.votewindow.header_sx, self.votewindow.header_sy, 0)

    self.votewindow.scrollbarline = self.votewindow:AddChild(Image("images/ui.xml", "scrollbarline.tex"))
    self.votewindow.scrollbarline:SetPosition(self.votewindow.scrollbarline_x, self.votewindow.scrollbarline_y, 0)
    self.votewindow.scrollbarline:SetScale(self.votewindow.scrollbarline_sx, self.votewindow.scrollbarline_sy, 0)

    self.votewindow.open = false
    self.votewindow:Hide()
    return self.votewindow
end

return vote