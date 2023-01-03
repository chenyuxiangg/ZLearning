local Widget = require "widgets/widget"
local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"

require("kaachievement_utils/utils")

local function TrophyMessageBadge()
    local Widget = require "widgets/widget"
    local trophymessage = Widget("chat_trophy_message_badge")

    trophymessage.bg = trophymessage:AddChild(Image("images/servericons.xml", "bg_brown.tex"))
    trophymessage.bg:SetScale(0.22)
    trophymessage.bg:SetPosition(0,31)

    trophymessage.trophymessage_img = trophymessage:AddChild(Image("images/servericons.xml", "dedicated.tex"))
    trophymessage.trophymessage_img:SetScale(0.19)
    trophymessage.trophymessage_img:SetPosition(0, 31)

    trophymessage:Hide()
    trophymessage:SetClickable(false)

    trophymessage.SetAlpha = function(self, a)
        if a > 0.01 then
            self:Show()
            self.bg:SetTint(1,1,1, a)
            self.trophymessage_img:SetTint(1,1,1, a)
        else
            self:Hide()
        end
    end

    trophymessage:SetScale(0.5)

    trophymessage.GetSize = function(self)
        return self.trophymessage_img:GetScaledSize()
    end

    return trophymessage
end

local function UpdateTrophyAnnouncementPosition(self)
    local w1, h1 = self.trophy_btn.text:GetRegionSize()
    self.trophy_btn:SetPosition(w1 * 0.5 - 290, 0)

    local w2, h2 = self.trophy_txt:GetRegionSize()
    self.trophy_txt:SetPosition(((w1 + w2) * 0.5), 0)

    self.trophy_btn.image:SetPosition(w2 * 0.5, 0, 0)
    self.trophy_btn:ForceImageSize(w1 + w2, math.max(h1, h2))
end

local function UpdateTrophyAnnouncementSize(self, size)
    self.trophy_btn:SetTextSize(size)
    self.trophy_txt:SetSize(size)
    self:UpdateTrophyAnnouncementPosition()
end

local function chatline_classpostconstruct(self, chat_font, user_width, user_max_chars, message_width, message_max_chars)
    -- print("chatline_classpostconstruct")

    local chat_size = 30
    local focus_chat_size = chat_size * 1.167

    --TROPHIES--
    self.trophy_btn = self.root:AddChild(ImageButton())
    self.trophy_btn.text:SetHAlign(ANCHOR_LEFT)
    self.trophy_btn:SetFont(chat_font)
    self.trophy_btn:SetTextSize(chat_size)
    self.trophy_btn:SetImageNormalColour(0, 0, 0, 0)
    self.trophy_btn:SetTextColour(1, 1, 1, 1)
    self.trophy_btn:SetTextFocusColour(1, 1, 1, 1)
    self.trophy_btn:SetOnClick(function()
        if self.trophy_data == nil then
            print("### NO trophy data received")
            return
        end

        print("PushAchievementScreen()", "self.trophy_data")
        dumptable(self.trophy_data)

        PushAchievementScreen(self.trophy_data.userid)

        if TheFrontEnd.screenroot.achievementScreen ~= nil then
            TheFrontEnd.screenroot.achievementScreen:ScrollToTrophy(self.trophy_data.category_name, self.trophy_data.trophy_name)
        end
    end)
    self.trophy_btn:SetControl(CONTROL_PRIMARY) --mouse left click only!

    self.trophy_txt = self.trophy_btn:AddChild(Text(chat_font, chat_size))
    self.trophy_txt:SetPosition(0, 2)
    self.trophy_txt:SetColour(1, 0, 0, 1)

    --ICONS--
    self.trophymessage = self.root:AddChild(TrophyMessageBadge())
    self.trophymessage:SetPosition(-315, -12.5)

    --------------------------------------------------------------------------------
    self.UpdateTrophyAnnouncementSize = UpdateTrophyAnnouncementSize
    self.UpdateTrophyAnnouncementPosition = UpdateTrophyAnnouncementPosition

    local _OnGainFocus = self.OnGainFocus
    self.OnGainFocus = function(self)
        _OnGainFocus(self)
        self:UpdateTrophyAnnouncementSize(focus_chat_size)
    end

    local _OnLoseFocus = self.OnLoseFocus
    self.OnLoseFocus = function(self)
        _OnLoseFocus(self)
        self:UpdateTrophyAnnouncementSize(chat_size)
    end

    local _UpdateAlpha = self.UpdateAlpha
    self.UpdateAlpha = function(self, alpha)
        _UpdateAlpha(self, alpha)
        if alpha > 0 then
            if self.type == ChatTypes.TrophyAnnouncement then
                self.message:UpdateAlpha(0)
                self.user:UpdateAlpha(0)
                self.user:UpdateAlpha(alpha)

                self.skin_btn.text:UpdateAlpha(0)
                self.skin_txt:UpdateAlpha(0)

                self.trophy_btn.text:UpdateAlpha(alpha)
                self.trophy_txt:UpdateAlpha(alpha)
                self.announcement:SetAlpha(alpha)
            else
                self.trophy_btn.text:UpdateAlpha(0)
                self.trophy_txt:UpdateAlpha(0)
            end
        end
    end

    local _SetChatData = self.SetChatData
    self.SetChatData = function(self, type, alpha, message, m_colour, sender, s_colour, icondata)
        _SetChatData(self, type, alpha, message, m_colour, sender, s_colour, icondata)

        if self.type == ChatTypes.TrophyAnnouncement then
            self.message:Hide()

            -- Use the way how skin announcement works.
            local SHOW_USER_NAME_ON_LEFT = false
            if not SHOW_USER_NAME_ON_LEFT then
                self.user:Hide()
            else
                if sender then
                    self.user:Show()
                    self.user:SetTruncatedString(sender, self.user_width, self.user_max_chars, true)
                    self.user:SetPosition(self.user:GetRegionSize() * -0.5 - 330, 0)

                    local r,g,b = unpack(s_colour)
                    self.user:SetColour(r, g, b, alpha)
                else
                    self.user:Hide()
                end
            end

            self.trophy_btn:Show()
            self.trophy_txt:Show()

            self.trophy_data = json.decode(message)

            local trophy_title = self.trophy_data.category_name and
                                 self.trophy_data.trophy_name and
                                 GetTrophyTitle(self.trophy_data.category_name, self.trophy_data.trophy_name) or
                                 ""
            local user_colour = s_colour
            local user_name = sender

            self.trophy_btn:SetText(subfmt(STRINGS.ACCOMPLISHMENTS.UI.ANNOUNCE_TROPHY_FMT, {who=sender}))
            self.trophy_btn.text:UpdateAlpha(alpha)

            local r, g, b = unpack(UICOLOURS.GOLD_FOCUS)
            self.trophy_txt:SetColour(r, g, b, alpha)
            self.trophy_txt:SetString(trophy_title)

            self:UpdateTrophyAnnouncementPosition()
        else
            self.trophy_btn:Hide()
            self.trophy_txt:Hide()
        end

        if self.type == ChatTypes.TrophyAnnouncement then
            self.announcement:SetAnnouncement("trophy")
            self.announcement:SetAlpha(alpha)
            -- Add some offset to fit in the circle bg.
            self.announcement.announcement_img:SetScale(0.7)
            self.announcement.announcement_img:SetPosition(-0.5, 32)
        else
            -- Restore to the default values.
            self.announcement.announcement_img:SetScale(1.35)
            self.announcement.announcement_img:SetPosition(0, 31)
        end
    end
end

return chatline_classpostconstruct