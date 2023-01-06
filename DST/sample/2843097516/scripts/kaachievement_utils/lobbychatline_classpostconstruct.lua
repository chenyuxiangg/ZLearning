local Text = require "widgets/text"
local ImageButton = require "widgets/imagebutton"
local TEMPLATES = require "widgets/redux/templates"

require("kaachievement_utils/utils")

local CAN_CLICK = false -- Adai: Apparently we don't want users to click the button.

local chat_size = 20
local focus_chat_size = CAN_CLICK and chat_size * 1.167 or chat_size

local icon_yoffset = -8.166
local username_maxwidth = 120
local username_maxchars = 30
local username_padding = 3
local icon_padding = 6.67
local line_maxwidth = 235
local line_maxchars = 50
local multiline_indent = 10

local btn_offset = Vector3(5,0,0)

local function CalculateClosestSpacesAndTabs(desired_width, space_width, first_tab_width, tab_width)
    local first_tab_diff = first_tab_width - tab_width
    local max_tabs = math.ceil((desired_width - first_tab_diff) / tab_width)

    local best_diff = math.diff(max_tabs * tab_width + first_tab_diff, desired_width)
    local best_space_count, best_tab_count = 0, max_tabs
    local best_use_first_tab = true

    local current_tab_count = max_tabs
    while current_tab_count > 0 and best_diff ~= 0 do
        current_tab_count = current_tab_count - 1

        if current_tab_count > 0 then
            local remaining_width = desired_width - (current_tab_count * tab_width)
            local min_spaces = math.floor(remaining_width / space_width) * space_width
            local max_spaces = min_spaces + space_width

            local remaining_width_first_tab = desired_width - (current_tab_count * tab_width + first_tab_diff)
            local min_spaces_first_tab = math.floor(remaining_width_first_tab / space_width) * space_width
            local max_spaces_first_tab = min_spaces_first_tab + space_width

            local min_diff = math.diff(min_spaces, remaining_width)
            local max_diff = math.diff(max_spaces, remaining_width)

            local min_diff_first_tab = math.diff(min_spaces_first_tab, remaining_width_first_tab)
            local max_diff_first_tab = math.diff(max_spaces_first_tab, remaining_width_first_tab)

            local best = math.min(min_diff, max_diff, min_diff_first_tab, max_diff_first_tab, best_diff)

            if best == min_diff then
                best_diff = min_diff
                best_space_count, best_tab_count = min_spaces / space_width, current_tab_count
                best_use_first_tab = false
            elseif best == max_diff then
                best_diff = max_diff
                best_space_count, best_tab_count = max_spaces / space_width, current_tab_count
                best_use_first_tab = false
            elseif best == min_diff_first_tab then
                best_diff = min_diff_first_tab
                best_space_count, best_tab_count = min_spaces_first_tab / space_width, current_tab_count
                best_use_first_tab = true
            elseif best == max_diff_first_tab then
                best_diff = max_diff_first_tab
                best_space_count, best_tab_count = max_spaces_first_tab / space_width, current_tab_count
                best_use_first_tab = true
            end
        else
            local min_spaces = math.floor(desired_width / space_width) * space_width
            local max_spaces = min_spaces + space_width

            local min_diff = math.diff(min_spaces, desired_width)
            local max_diff = math.diff(max_spaces, desired_width)

            local best = math.min(min_diff, max_diff, best_diff)

            if best == min_diff then
                best_diff = min_diff
                best_space_count, best_tab_count = min_spaces / space_width, 0
                best_use_first_tab = false
            elseif best == max_diff then
                best_diff = max_diff
                best_space_count, best_tab_count = max_spaces / space_width, 0
                best_use_first_tab = false
            end
        end
    end

    assert(not best_use_first_tab or best_tab_count > 0)

    local str = ""

    for i = 1, best_space_count do
        str = str.." "
    end

    for i = 1, best_tab_count do
        if best_use_first_tab then
            str = "\t"..str
        else
            str = str.."\t"
        end
    end

    return str
end

local function GetLastLineLength(textwidget)
    local lines = textwidget:GetString():split("\n")
    local textbox = require("widgets/text")(textwidget.font, textwidget.size)
    textbox:SetString(lines[#lines])
    local line_length = textbox:GetRegionSize()
    textbox:Kill()
    return line_length
end

local function AddLinePrefixes(textwidget, prefix, multiline_indent_str)
    local lines = textwidget:GetString():split("\n")
    for i, line in ipairs(lines) do
        lines[i] = (i == 1 and prefix or multiline_indent_str)..line
    end
    textwidget:SetString(table.concat(lines, "\n"))
end

local function UpdateTextWidget(self, textwidget, minimum_offset, extra_y_offset)
    if not self.inital_update then
        local first_line_offset = math.max(minimum_offset, multiline_indent)

        textwidget:SetMultilineTruncatedString(textwidget:GetString(), 100, {line_maxwidth - first_line_offset, line_maxwidth - multiline_indent}, line_maxchars, false)

        AddLinePrefixes(textwidget, CalculateClosestSpacesAndTabs(first_line_offset, self.space_width, self.first_tab_width, self.tab_width), self.multiline_indent_str)
    end

    local message_width, message_height = textwidget:GetRegionSize()
    local extra_line_message_offset = message_height - chat_size

    local y = not self.inital_update and ((extra_y_offset or 0) + extra_line_message_offset * -0.5) or textwidget:GetPosition().y
    textwidget:SetPosition(message_width * 0.5, y)
    return extra_line_message_offset
end

local function UpdatePositions(self)
    local next_offset = 0

    if self.type == ChatTypes.TrophyAnnouncement then
        if self.icon then
            -- Adai: Should not have self.user
            if self.user then
                local username_width = self.user:GetRegionSize()
                self.user:SetPosition(next_offset + username_width * 0.5, 0)
                next_offset = next_offset + username_width + username_padding
            end

            if not self.inital_update then
                self.icon:SetScale(self.icon:GetScale() * 0.667)
                self.icon:Show()
            end
            local bg_width = self.icon:GetSize()
            self.icon:SetPosition(next_offset + bg_width * 0.5 + 1.5, icon_yoffset)
            next_offset = next_offset + bg_width + icon_padding
        end

        local extra_line_height = UpdateTextWidget(self, self.trophy_btn.text, next_offset)

        local extra_trophy_line_height = UpdateTextWidget(self, self.trophy_txt, GetLastLineLength(self.trophy_btn.text), extra_line_height * -0.5)

        self.extra_line_count = (#self.trophy_btn.text:GetString():split("\n") - 1) + (#self.trophy_txt:GetString():split("\n") - 1)

        self.trophy_btn:SetPosition(self.trophy_btn.text:GetPosition() + btn_offset)
        self.trophy_btn.text:SetPosition(0, 0, 0)

        local prev_pos = self.trophy_txt:GetPosition()
        self.trophy_txt:SetPosition(-self.trophy_btn:GetPosition().x + prev_pos.x + btn_offset.x, prev_pos.y, prev_pos.z)

        local image_btn_width, image_btn_height = self.trophy_btn.text:GetRegionSize()
        local image_width = math.max(self.trophy_txt:GetRegionSize(), image_btn_width)

        self.trophy_btn:ForceImageSize(image_width, image_btn_height + extra_trophy_line_height)
    end

    self.inital_update = true
end

local function UpdateTrophyAnnouncementSize(self, size)
    if self.trophy_btn then
        self.trophy_btn:SetTextSize(size)
        self.trophy_txt:SetSize(size)
        self:UpdatePositions()
    end
end

local function lobbychatline_classpostconstruct(self, chat_font, type, message, m_colour, sender, s_colour, icondata)
    -- print("lobbychatline_classpostconstruct")

    local _UpdatePositions = self.UpdatePositions
    self.UpdatePositions = function(self)
        if self.type == ChatTypes.TrophyAnnouncement then
            UpdatePositions(self)
        else
            _UpdatePositions(self)
        end
    end

    if self.type == ChatTypes.TrophyAnnouncement then
        if self.icon then
            self.icon:Kill()
            self.icon = nil
        end
        self.icon = self.root:AddChild(TEMPLATES.AnnouncementBadge())
        self.icon:SetAnnouncement("trophy")
        -- -- Add some offset to fit in the circle bg.
        self.icon.announcement_img:SetScale(0.7)
        self.icon.announcement_img:SetPosition(-0.5, 32)

        self.trophy_data = json.decode(message)
        local user_colour = s_colour
        local user_name = sender

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

            -- Adai: Apparently in lobby screen you cannot send ModRPC to server.
            --       Will get "Invalid RPC sender: expected player, got userid" in function HandleModRPC().
            if CAN_CLICK then
                print("PushAchievementScreen()", "self.trophy_data")
                dumptable(self.trophy_data)

                PushAchievementScreen(self.trophy_data.userid)

                if TheFrontEnd.screenroot.achievementScreen ~= nil then
                    TheFrontEnd.screenroot.achievementScreen:ScrollToTrophy(self.trophy_data.category_name, self.trophy_data.trophy_name)
                end
            end
        end)

        self.trophy_btn:SetText(subfmt(STRINGS.ACCOMPLISHMENTS.UI.ANNOUNCE_TROPHY_FMT, {who=sender}))

        if not CAN_CLICK then
            self.trophy_btn.clickoffset = Vector3(0, 0, 0)
        end

        self.UpdateTrophyAnnouncementSize = UpdateTrophyAnnouncementSize

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

        self.trophy_txt = self.trophy_btn:AddChild(Text(chat_font, chat_size))
        self.trophy_txt:SetHAlign(ANCHOR_LEFT)
        self.trophy_txt:SetPosition(0, 2)

        local trophy_title = self.trophy_data.category_name and
                                self.trophy_data.trophy_name and
                                GetTrophyTitle(self.trophy_data.category_name, self.trophy_data.trophy_name) or
                                ""
        self.trophy_txt:SetColour(UICOLOURS.GOLD_FOCUS)
        self.trophy_txt:SetString(trophy_title)

        -------------------------------
        self.message:Kill()
        self.message = nil

        self.user:Kill()
        self.user = nil

        -- if sender and self.user == nil then
        --     self.user = self.root:AddChild(Text(chat_font, chat_size))
        --     self.user:SetHAlign(ANCHOR_RIGHT)

        --     self.user:SetTruncatedString(sender, username_maxwidth, username_maxchars, true)
        --     self.user:SetColour(s_colour)
        -- end
        -------------------------------

        self.inital_update = nil
        self:UpdatePositions()
    end
end

return lobbychatline_classpostconstruct