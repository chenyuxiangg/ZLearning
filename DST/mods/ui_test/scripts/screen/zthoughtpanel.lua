local Widget = require("widgets/widget")
local Text = require("widgets/text")
local Zstring = require("util/zstring")

local Zthoughtpanel = Class(Widget, function(self, owner)
    Widget._ctor(self, "Zthoughtpanel")

    self.parent = owner
    self.open = false
    self.basePos = Vector3(0, -50, 0)
    self.avatarPosOffset = Vector3(-240, 65, 0)
    self.barLinePosOffset = Vector3(-210, 65, 0)
    self.textLabelPosOffset = Vector3(22, 75, 0)

    self.baseScale = Vector3(2, 1.5, 1)
    self.avatarScale = Vector3(0.5, 0.5, 1)
    self.barLineScale = Vector3(0.3, 0.3, 1)

    self.fontSize = 20
    self.textLableWidth = 440
    self.textLableHeight = 50
    self.characterCountInRow = 32
    -- self.characterByteCountInRow = self.characterCountInRow * 3

    self.bg = self:AddChild(Image("images/ui.xml", "votewindow_controller_bottom.tex"))
    self.avatarBg = self:AddChild(Image("images/avatars.xml", "avatar_bg.tex"))
    self.avatarIcon = self:AddChild(Image("images/avatars.xml", "avatar_wilson.tex"))
    self.avatarFrame = self:AddChild(Image("images/avatars.xml", "avatar_frame_white.tex"))
    self.barLine = self:AddChild(Image("images/crafting_menu.xml", "scrollbar_bar.tex"))
    self.textLable = self:AddChild(Text(NEWFONT, self.fontSize, nil, {0, 0, 0 ,1}))
    self.textLable:SetRegionSize(self.textLableWidth, self.textLableHeight)

    self:adapterPosition()
    self:adapterScale()
    self:Hide()
end)

function Zthoughtpanel:adapterPosition()
    self.avatarBg:SetPosition((self.basePos+self.avatarPosOffset).x, (self.basePos+self.avatarPosOffset).y, (self.basePos+self.avatarPosOffset).z)
    self.avatarIcon:SetPosition((self.basePos+self.avatarPosOffset).x, (self.basePos+self.avatarPosOffset).y, (self.basePos+self.avatarPosOffset).z)
    self.avatarFrame:SetPosition((self.basePos+self.avatarPosOffset).x, (self.basePos+self.avatarPosOffset).y, (self.basePos+self.avatarPosOffset).z)
    self.barLine:SetPosition((self.basePos+self.barLinePosOffset).x, (self.basePos+self.barLinePosOffset).y, (self.basePos+self.barLinePosOffset).z)
    self.textLable:SetPosition((self.basePos+self.textLabelPosOffset).x, (self.basePos+self.textLabelPosOffset).y, (self.basePos+self.textLabelPosOffset).z)
end

function Zthoughtpanel:adapterScale()
    self.bg:SetScale(self.baseScale.x, self.baseScale.y, self.baseScale.z)
    self.avatarBg:SetScale(self.avatarScale.x, self.avatarScale.y, self.avatarScale.z)
    self.avatarIcon:SetScale(self.avatarScale.x, self.avatarScale.y, self.avatarScale.z)
    self.avatarFrame:SetScale(self.avatarScale.x, self.avatarScale.y, self.avatarScale.z)
    self.barLine:SetScale(self.barLineScale.x, self.barLineScale.y, self.barLineScale.z)
end

function Zthoughtpanel:slideOut()
    if not self.open then
        self.open = true
        self:MoveTo(Vector3(0, 0, 0), self.basePos, .33, nil)
        self:Show()
    end
end

function Zthoughtpanel:slideIn()
    if self.open then
        self.open = false
        self:MoveTo(self.basePos, Vector3(0, 25, 0), .33, nil)
        self:Show()
    end
end

function Zthoughtpanel:setText(str)
    local text = Zstring(str)
    text:alignByByteCount(self.characterCountInRow*3)
    local textLen = text:getCharacterLength()
    local showText = ""
    for i=1, textLen/self.characterCountInRow do
        showText = showText .. text:substrByCharacterCount(nil, self.characterCountInRow) .. "\n"
    end
    self.textLable:SetSize(self.fontSize)
    self.textLable:SetString(showText)
end

function Zthoughtpanel:getInfo()
    print("bg: ", self.bg:GetPosition())
    print("avatarBg: ", self.avatarBg:GetPosition())
    print("barLine: ", self.barLine:GetPosition())
    print("textlable: ", self.textLable:GetPosition())
    print("font size: ", self.textLable:GetSize())
end

function Zthoughtpanel:updatePos(dir)
    if dir == "r" then
        self.avatarPosOffset = self.avatarPosOffset + Vector3(1, 0, 0)
        self.barLinePosOffset = self.barLinePosOffset + Vector3(1, 0, 0)
        self.textLabelPosOffset = self.textLabelPosOffset + Vector3(1, 0, 0)
    elseif dir == "l" then
        self.avatarPosOffset = self.avatarPosOffset + Vector3(-1, 0, 0)
        self.barLinePosOffset = self.barLinePosOffset + Vector3(-1, 0, 0)
        self.textLabelPosOffset = self.textLabelPosOffset + Vector3(-1, 0, 0)
    end
    self:adapterPosition()
end

function Zthoughtpanel:updateFontSize(dir)
    if dir == "+" then
        self.fontSize = self.fontSize + 1
    elseif dir == "-" then
        self.fontSize = self.fontSize - 1
    end
    self.textLable:SetSize(self.fontSize)
end

return Zthoughtpanel