require("kaachievement_utils/utils")

local KaAchievementsPanelSetting = require("widgets/kaachievementspanelsetting")
local KaAchievementsCandidatesWidget = require("widgets/kaachievementscandidateswidget")

local Image       = require("widgets/image")
local Widget      = require("widgets/widget")
local Text        = require("widgets/text")
local TEMPLATES   = require("widgets/redux/templates")
local ImageButton = require("widgets/imagebutton")

local modName     = "KaAchievement"
local screenname  = modName

local row_w = 720;
local row_h = 60;
local scale = row_h / 60;  -- Every number was tested when row_h is 60, scale accordingly.
local icon_size = row_h - 10;
local record_width = 100 * scale;
local when_width = 120 * scale;
local icon_spacing = 5 * scale;
local row_spacing = 5 * scale;
local num_visible_rows = math.min(10, math.floor(580 / (row_h + row_spacing)));
local show_debug_frame = false

local button_bar_h = 50
local title_bar_h = 60
local dialog_border_h = 8

local dialog_w = row_w
local dialog_h = (row_h+row_spacing)*num_visible_rows + 2*dialog_border_h

-- Class KaAchievementsPanel.
local KaAchievementsPanel = Class(Widget, function(self, session_identifier, userid)
    Widget._ctor(self, "KaAchievementsPanel")

    self.session_identifier = session_identifier
    self.userid = userid

    self.achievements_root = self:AddChild(Widget("achievements_root"))
    self.achievements_root:SetPosition(0, -(button_bar_h+title_bar_h)/2 + 5)

    self.dialog = self.achievements_root:AddChild(TEMPLATES.RectangleWindow(dialog_w, dialog_h))
    local r,g,b,a = unpack(UICOLOURS.BROWN_DARK)
    self.dialog:SetBackgroundTint(r,g,b,a)
    self.dialog:SetPosition(0,0)
    self.dialog.top:Hide() -- top crown would be behind our title.

    local dialog_middle_left_w = self.dialog.elements[4]:GetSize()
    local dialog_middle_right_w = self.dialog.elements[5]:GetSize()
    local dialog_real_w = dialog_w + 0.7*(dialog_middle_left_w + dialog_middle_right_w)

    self.parent_default_focus = self

    -- if title_bar_h > 0 then
    --     -- STRINGS.ACCOMPLISHMENTS.UI.SERVER_LIST.SERVERNAME_MISSING
    --     self.title = self.achievements_root:AddChild(Text(HEADERFONT, 35, "", UICOLOURS.HIGHLIGHT_GOLD))
    --     self.title:SetPosition(0, dialog_h / 2 + button_bar_h + title_bar_h / 2 + dialog_border_h)

    --     self.title_bg = self.achievements_root:AddChild(Image("images/global.xml", "square.tex"))
    --     self.title_bg:SetPosition(self.title:GetPosition())
    --     self.title_bg:SetTint(0,1,0,0.2)
    --     self.title_bg:ScaleToSize(dialog_real_w, title_bar_h)
    --     self.title:MoveToFront()
    -- end

    if button_bar_h > 0 then
        self.button_bar = self.achievements_root:AddChild(Widget("button_bar"))
        self.button_bar:SetPosition(0, dialog_h / 2 + button_bar_h / 2 + dialog_border_h)
        self.button_bar:SetScale(0.3)

        -- self.button_bar_bg = self.achievements_root:AddChild(Image("images/global.xml", "square.tex"))
        -- self.button_bar_bg:SetPosition(self.button_bar:GetPosition())
        -- self.button_bar_bg:SetTint(1,0,0,0.2)
        -- self.button_bar_bg:ScaleToSize(dialog_real_w, button_bar_h)
        -- self.button_bar:MoveToFront()
    end

    -- Needs to be created before the filter buttons
    self.settingWidget = self:CreateSettingWidget()
    self.candidatesWidget = self:CreateCandidatesWidget()

    self.filter = self.settingWidget:GetFilter()
    self.sort   = self.settingWidget:GetSort()

    if self.button_bar then
        self.buttons = {}
        self:BakeButtonBar()
    end

    self:LoadAndBakePage()
end)

function KaAchievementsPanel:OnSettingButtonShow(button, visible)
    if visible then
        button:SetTextures("images/global_redux.xml",           -- atlas
                           "button_carny_square_down.tex",      -- normal
                           "button_carny_square_hover.tex",     -- focus
                           "button_carny_square_disabled.tex",  -- disabled
                           "button_carny_square_down.tex",      -- down
                           "button_carny_square_down.tex")      -- selected
    else
        button:SetTextures("images/global_redux.xml",           -- atlas
                           "button_carny_square_normal.tex",    -- normal
                           "button_carny_square_hover.tex",     -- focus
                           "button_carny_square_disabled.tex",  -- disabled
                           "button_carny_square_down.tex",      -- down
                           "button_carny_square_down.tex")      -- selected
    end
end

function KaAchievementsPanel:BakeButtonBar()
    local button_list = {}

    -- The "Show All" button
    table.insert(button_list,
        {
            text    = STRINGS.ACCOMPLISHMENTS.UI.FILTER_BUTTON_ALL,
            filter  = false,
            default = true,
        })

    -- Filter for each category
    for i,v in ipairs(KAACHIEVEMENT.CATEGORIES) do
        table.insert(button_list,
            {
                text     = STRINGS.ACCOMPLISHMENTS.UI.CATEGORY[string.upper(v)],
                category = v,
                filter   = v,
            })
    end

    -- Sort button
    table.insert(button_list,
        {
            text      = STRINGS.ACCOMPLISHMENTS.UI.SORT[string.upper(KAACHIEVEMENT.SORT[self.sort + 1])],
            sort      = true,
            nodisable = true,
        })

    -- Settings button
    table.insert(button_list,
        {
            text      = STRINGS.ACCOMPLISHMENTS.UI.SETTINGS_BUTTON,
            settings  = true,
            nodisable = true,
        })

    local sort_tex =
    {
        "achievements_buttons_numeric.tex",         -- Default
        "achievements_buttons_alphabetic.tex",      -- Alphabetically
        "achievements_buttons_unlockedonly.tex",    -- Unlocked Only
        "achievements_buttons_lockedonly.tex",      -- Locked Only
        "achievements_buttons_unlocked.tex",        -- Unlocked/Locked
        "achievements_buttons_locked.tex",          -- Locked/Unlocked
    }

    for i,v in ipairs(button_list) do
        local button = self.button_bar:AddChild(
            ImageButton("images/global_redux.xml",           -- atlas
                        "button_carny_square_normal.tex",    -- normal
                        "button_carny_square_hover.tex",     -- focus
                        "button_carny_square_disabled.tex",  -- disabled
                        "button_carny_square_down.tex",      -- down
                        "button_carny_square_down.tex"))     -- selected

        local overlay_image_scale = 1.5

        if v.category then
            button.filter = v.filter
            button.category = v.category

            -- The category filter buttons.
            button.overlay_image = button:AddChild(
                Image("images/achievementsimages/achievements_buttons.xml",
                      string.format("achievements_buttons_%s.tex", string.lower(v.category))))

            button.overlay_image:SetScale(overlay_image_scale)
        elseif v.filter == false then
            -- The "Show All" button.
            button.overlay_image = button:AddChild(
                Image("images/achievementsimages/achievements_buttons.xml",
                      "achievements_buttons_showall.tex"))

            button.overlay_image:SetScale(overlay_image_scale)
        elseif v.sort == true then
            -- The Sort button.
            button.overlay_image = button:AddChild(
                Image("images/achievementsimages/achievements_buttons.xml",
                      sort_tex[self.sort + 1]))

            button.overlay_image:SetScale(overlay_image_scale)
        elseif v.settings == true then
            -- The Settings button.
            button.overlay_image = button:AddChild(
                Image("images/achievementsimages/achievements_buttons.xml",
                      "achievements_buttons_settings4.tex"))

            button.overlay_image:SetScale(overlay_image_scale)
        end

        local hoverParam = { offset_x = 0, offset_y = -70 }

        button:SetNormalScale(1.2,1.2)
        button:SetFocusScale(1.3,1.3)
        button:SetOnClick(function()
            if v.filter ~= nil then
                self.filter = v.filter
                self.settingWidget:SetFilter(self.filter)
                self.candidatesWidget:Hide()
            end

            if v.sort == true then
                self.sort = math.mod(self.sort + 1, #KAACHIEVEMENT.SORT)
                self.settingWidget:SetSort(self.sort)

                -- LUA uses 1-based array.
                button:SetHoverText(STRINGS.ACCOMPLISHMENTS.UI.SORT[string.upper(KAACHIEVEMENT.SORT[self.sort + 1])], hoverParam)
                button.overlay_image:SetTexture("images/achievementsimages/achievements_buttons.xml",
                                                sort_tex[self.sort + 1])
            end

            if v.nodisable ~= true then
                if self.select_button ~= nil then
                    self.select_button:Unselect()
                end

                self.select_button = button
                self.select_button:Select()
            end

            if v.settings ~= nil then
                if self.settingWidget:IsVisible() then
                    self.settingWidget:Hide()
                else
                    self.settingWidget:Show()
                end

                self:OnSettingButtonShow(button, self.settingWidget:IsVisible())
            else
                self:Bake()
            end
        end)

        local w,h = button:GetSize()
        button:SetHoverText(v.text, hoverParam)

        if v.filter == self.settingWidget:GetFilter() then
            self.select_button = button
            self.select_button:Select()
        end

        if v.settings ~= nil then
            self:OnSettingButtonShow(button, self.settingWidget:IsVisible())
        end

        table.insert(self.buttons, button)
    end

    -- Calculate the positions
    for i,v in ipairs(button_list) do
        local button = self.buttons[i]

        local w,h = button:GetSize()
        local spacing = 10

        local extra_offset = 0

        if v.filter == nil then
            extra_offset = w
        end

        button:SetPosition((i-1)*(w+spacing) -(#KAACHIEVEMENT.CATEGORIES+3)/2*(w+spacing) +extra_offset, 0)
    end
end

local function InsertEntry(data, scrollitems, category_name, entry)
    assert(entry.name or (entry.title and entry.desc))

    -- print(modName, category_name, entry.name, GetTrophyTitle(category_name,entry.name))
    -- print(modName, category_name, entry.name, GetTrophyDesc(category_name,entry.name))

    local when = data[GetCompletedVarName(category_name, entry.name)]
    local when_irl = nil
    local when_cycle = nil
    if type(when) == "table" then
        -- The cycle is 0-based, but cycle 0 should be displayed as day 1.
        when_cycle = string.format(STRINGS.ACCOMPLISHMENTS.UI.FINISHED_TIME, when.cycles + 1)

        when_irl = when.irl
    end

    table.insert(scrollitems, {
        is_category = false,
        name        = entry.name,
        category    = category_name,
        title       = entry.title or GetTrophyTitle(category_name, entry.name) or STRINGS.ACCOMPLISHMENTS.UI.TITLE_MISSING,
        desc        = entry.desc or GetTrophyDesc(category_name, entry.name) or STRINGS.ACCOMPLISHMENTS.UI.DESC_MISSING,
        record      = entry.Record and entry.Record(data) or 0,
        recordLabel = entry.RecordLabel and (type(entry.RecordLabel) == "function" and entry.RecordLabel(data) or entry.RecordLabel) or GetTrophyLabel(category_name, entry.name),
        completed   = entry.Check and entry.Check(data) or false,
        candidates  = entry.Candidates and entry.Candidates(data) or nil,
        when_cycle  = when_cycle,
        when_irl    = when_irl,
        hideTime    = entry.hideTime,
        isHidden    = entry.isHidden,
    })
end

-- BuildAchievementsExplorer(...)
local function BuildAchievementsExplorer(panel)
    local cliendData = panel.data
    local filter     = panel.settingWidget:GetFilter()
    local sort       = panel.settingWidget:GetSort()

    local function ScrollWidgetsCtor(context, index)
        local w = Widget("achievement-cell-".. index)

        w.frame = w:AddChild(Image("images/frontend_redux.xml", "achievement_backing.tex"))
        w.frame:ScaleToSize(row_w,row_h)
        w.frame:SetPosition(0,0)

        w.title = w:AddChild(Text(HEADERFONT, 22 * scale))
        w.title:SetColour(UICOLOURS.HIGHLIGHT_GOLD)
        w.title:SetRegionSize(row_w, 24*scale)
        w.title:SetHAlign(ANCHOR_LEFT)
        w.title:SetPosition(0,-row_h/2 + 20*scale)
        w.count = w:AddChild(Text(HEADERFONT, 22*scale))
        w.count:SetColour(UICOLOURS.HIGHLIGHT_GOLD)
        w.count:SetRegionSize(row_w, 24*scale)
        w.count:SetHAlign(ANCHOR_RIGHT)
        w.count:SetPosition(0,-row_h/2 + 20*scale)
        w.divider = w:AddChild(Image("images/global_redux.xml", "item_divider.tex"))
        w.divider:ScaleToSize(row_w,5)
        w.divider:SetPosition(0,-row_h/2 + 5*scale)

        local recordNum_x = row_w/2-record_width/2-5
        w.recordNum = w:AddChild(Text(HEADERFONT, 22*scale))
        w.recordNum:SetColour(UICOLOURS.GOLD_SELECTED)
        w.recordNum:SetRegionSize(record_width, 22*scale)
        w.recordNum:SetPosition(recordNum_x, 8*scale)
        w.recordLabel = w:AddChild(Text(HEADERFONT, 16*scale))
        w.recordLabel:SetColour(UICOLOURS.HIGHLIGHT_GOLD)
        w.recordLabel:SetRegionSize(record_width, 16*scale)
        w.recordLabel:SetPosition(recordNum_x, -13*scale)

        local when_x = recordNum_x - record_width/2 - when_width/2 - 10
        w.when_cycle = w:AddChild(Text(HEADERFONT, 15*scale))
        w.when_cycle:SetColour(UICOLOURS.GOLD_SELECTED)
        w.when_cycle:SetRegionSize(when_width, 15*scale)
        w.when_cycle:SetPosition(when_x, 10*scale)

        w.when_irl = w:AddChild(Text(HEADERFONT, 15*scale))
        w.when_irl:SetColour(UICOLOURS.GOLD_SELECTED)
        w.when_irl:SetRegionSize(when_width, 15*scale)
        w.when_irl:SetPosition(when_x, -10*scale)

        local icon_padding = row_h - icon_size
        local icon_x = -row_w/2+icon_size/2+icon_padding
        w.icon = w:AddChild(Image("images/achievementsimages/achievements_images.xml", "achievements_locked2.tex"))
        w.icon:ScaleToSize(icon_size,icon_size)
        w.icon:SetPosition(icon_x,0)

        local desc_width = (row_w - icon_size - record_width - icon_padding - 2*icon_spacing)
        local desc_x = -row_w/2 + desc_width/2 + (icon_size + icon_padding) + icon_spacing
        w.name = w:AddChild(Text(HEADERFONT, 18*scale))
        w.name:SetColour(UICOLOURS.GOLD_SELECTED)
        w.name:SetRegionSize(desc_width, 18*scale)
        w.name:SetHAlign(ANCHOR_LEFT)
        w.name:SetPosition(desc_x, 12*scale)

        w.desc = w:AddChild(Text(CHATFONT, 18*scale))
        w.desc:SetColour(UICOLOURS.GREY)
        w.desc:SetRegionSize(desc_width, 18*scale)
        w.desc:SetHAlign(ANCHOR_LEFT)
        w.desc:EnableWordWrap(true)
        w.desc:SetPosition(desc_x, (-10)*scale)

        if show_debug_frame then
            w.frame_shadow = w:AddChild(Image("images/global.xml", "square.tex"))
            w.frame_shadow:ScaleToSize(row_w, row_h)
            w.frame_shadow:SetTint(1,1,0,0.1)
            w.frame_shadow:SetPosition(w.frame:GetPosition())

            w.name_shadow = w:AddChild(Image("images/global.xml", "square.tex"))
            w.name_shadow:ScaleToSize(w.name:GetRegionSize())
            w.name_shadow:SetTint(1,0,0,0.2)
            w.name_shadow:SetPosition(w.name:GetPosition())

            w.desc_shadow = w:AddChild(Image("images/global.xml", "square.tex"))
            w.desc_shadow:ScaleToSize(w.desc:GetRegionSize())
            w.desc_shadow:SetTint(0,1,0,0.2)
            w.desc_shadow:SetPosition(w.desc:GetPosition())
        end

        local ic_hidden_offset = {icon_size*0.43, -icon_size*0.43}
        local ic_hidden_size   = icon_size*0.4
        -- w.ic_hidden = w:AddChild(Image("images/frontend_redux.xml", "accountitem_frame_arrow.tex")) -- This is the "check" icon
        w.ic_hidden = w:AddChild(Image("images/quagmire_recipebook.xml", "coin1.tex"))
        w.ic_hidden:ScaleToSize(ic_hidden_size,ic_hidden_size)
        w.ic_hidden:SetPosition(icon_x +ic_hidden_offset[1], ic_hidden_offset[2])

        local candidateBtn_offset = {-icon_size*0.43, -icon_size*0.43}
        local candidateBtn_size   = icon_size*0.6
        local candidateBtnClickFn = function() if w.data then context.candidatesWidget:Bake(w.data.candidates) end end

        w.candidateBtn = w:AddChild(TEMPLATES.StandardButton(candidateBtnClickFn, nil, {icon_size*0.4, icon_size*0.4}))
        w.candidateBtn:SetPosition(icon_x +candidateBtn_offset[1], candidateBtn_offset[2])
        w.candidateBtn.clickoffset = Vector3(0, -2, 0)
        w.candidateBtn:SetPosition(row_w / 2 - record_width, 0)

        w.candidateBtn.overlayImg = w.candidateBtn:AddChild(Image("images/button_icons.xml", "info.tex"))
        w.candidateBtn.overlayImg:ScaleToSize(candidateBtn_size * 0.4,candidateBtn_size * 0.4)

        local ic_new_offset = {icon_size*0.43, icon_size*0.43}
        local ic_new_size   = icon_size*0.45
        w.ic_new = w:AddChild(Image("images/quagmire_recipebook.xml", "cookbook_new.tex"))
        w.ic_new:ScaleToSize(ic_new_size,ic_new_size)
        w.ic_new:SetPosition(icon_x +ic_new_offset[1], ic_new_offset[2])

        -- @Todo: Support click-to-hide on the "new" icon.
        -- w.ic_new:SetClickable(true)
        -- local _OnControl = w.ic_new.OnControl
        -- w.ic_new.OnControl = function(self, control, down)
        --     _OnControl(self, control, down)
        --     if down and control == CONTROL_ACCEPT then
        --         w.ic_new.clicked = true
        --         w.ic_new:Hide()
        --     end
        -- end

        return w
    end

    local function ScrollWidgetApply(context, widget, data, index)
        if data then
            widget.candidateBtn:Hide()
            widget.data = data

            if data.is_category == true then
                widget.title:SetString(data.title)
                widget.count:SetString(data.count)
                widget.title:Show()
                widget.count:Show()
                widget.divider:Show()
                widget.frame:Hide()
                widget.when_cycle:Hide()
                widget.when_irl:Hide()
                widget.recordNum:Hide()
                widget.recordLabel:Hide()
                widget.name:Hide()
                widget.desc:Hide()
                widget.icon:Hide()
                widget.ic_hidden:Hide()
                widget.ic_new:Hide()
            else
                --[[
                widget:SetHoverText("Hover Text",
                    {
                        font     = NEWFONT_OUTLINE,
                        offset_x = 0,
                        offset_y = 0,
                        colour   = {1,1,1,1},
                        bg       = true,
                    })
                --]]
                widget.title:Hide()
                widget.count:Hide()
                widget.divider:Hide()
                widget.name:SetString(data.title)
                widget.desc:SetString(data.desc)

                -- Counter
                if data.recordLabel and data.recordLabel ~= "" and not context.settingWidget:ShouldHideCounter() then
                    widget.recordNum:SetString(data.record)
                    widget.recordLabel:SetString(data.recordLabel)
                    widget.recordNum:Show()
                    widget.recordLabel:Show()
                else
                    widget.recordNum:Hide()
                    widget.recordLabel:Hide()
                end

                widget.name:Show()
                widget.desc:Show()
                widget.icon:Show()
                widget.frame:Show()

                if data.when_irl ~= nil and (os.time() - data.when_irl) <= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_HUGE then -- TUNING.TOTAL_DAY_TIME
                    widget.ic_new:Show()
                else
                    widget.ic_new:Hide()
                end

                if data.isHidden == true then
                    widget.ic_hidden:Show()
                else
                    widget.ic_hidden:Hide()
                end

                if data.candidates and not context.settingWidget:ShouldHideCounter() then
                    if data.completed or data.isHidden ~= true then
                        widget.candidateBtn:Show()
                    end
                end

                if data.completed then
                    -- widget.ic_completed:Show()
                    -- widget.ic_completed:SetTexture("images/frontend_redux.xml", "accountitem_frame_arrow.tex")
                    widget.name:SetColour(UICOLOURS.GOLD_FOCUS)
                    widget.desc:SetColour(UICOLOURS.HIGHLIGHT_GOLD)

                    -- Time stamp
                    if not data.hideTime and not context.settingWidget:ShouldHideTime() then
                        widget.when_cycle:Show()
                        widget.when_cycle:SetString(data.when_cycle or STRINGS.ACCOMPLISHMENTS.UI.FINISHED_TIME_UNKNOWN)

                        widget.when_irl:Show()
                        if data.when_irl then
                            widget.when_irl:SetString(os.date(STRINGS.ACCOMPLISHMENTS.UI.FINISHED_IRL_TIME_FMT, data.when_irl))
                        else
                            widget.when_irl:SetString(STRINGS.ACCOMPLISHMENTS.UI.FINISHED_IRL_TIME_UNKNOWN)
                        end
                    else
                        widget.when_cycle:Hide()
                        widget.when_irl:Hide()
                    end

                    widget.recordNum:SetColour(UICOLOURS.GOLD_FOCUS)
                    widget.recordLabel:SetColour(UICOLOURS.HIGHLIGHT_GOLD)
                    widget.icon:SetTexture("images/achievementsimages/achievements_images.xml",
                                           string.format("achievements_%s_%s.tex", string.lower(data.category), string.lower(data.name)),
                                           "achievements_empty.tex")
                else
                    if data.isHidden == true then
                        -- Show the title of hidden trophies.
                        -- widget.name:SetString(STRINGS.ACCOMPLISHMENTS.UI.TITLE_HIDDEN)
                        widget.desc:SetString(STRINGS.ACCOMPLISHMENTS.UI.DESC_HIDDEN)
                        widget.recordNum:Hide()
                        widget.recordLabel:Hide()
                        widget.candidateBtn:Hide()
                    end

                    widget.name:SetColour(UICOLOURS.GREY)
                    widget.desc:SetColour(UICOLOURS.GOLD_SELECTED)
                    widget.when_cycle:Hide()
                    widget.when_irl:Hide()
                    widget.recordNum:SetColour(UICOLOURS.GREY)
                    widget.recordLabel:SetColour(UICOLOURS.GREY)
                    widget.icon:SetTexture("images/achievementsimages/achievements_images.xml", "achievements_locked2.tex")
                end
            end
            widget:Show()
        else
            widget:Hide()
        end
    end

    local scrollitems = {}

    -- Real data.
    for worldId, worldData in pairs(cliendData or {}) do
        if worldData then
            local data = worldData.data

            if data then
                -- Add a new world name.
                -- table.insert(scrollitems, {
                --     category=true, title=worldData.servername, count=subfmt(STRINGS.UI.XPUTILS.XPPROGRESS, {num=completed, max=count})
                -- })
                for _,category_name in ipairs(KAACHIEVEMENT.CATEGORIES) do
                    local category_entries = GetKaAchievementLoader().entries[category_name]

                    if category_entries == nil then
                        print(modName, string.format("[Warning] Category \"%s\" is nil", category_name))
                    end

                    if category_entries ~= nil and (filter == false or filter == category_name) then
                        local count = 0
                        local count_completed = 0
                        for _,entry in pairs(category_entries) do
                            -- Count total number of achievements.
                            count = count + 1

                            -- Count how many have been completed.
                            if entry.Check and entry.Check(data) then
                                count_completed = count_completed + 1
                            end
                        end

                        -- Add a new category.
                        table.insert(scrollitems,
                            {
                                is_category = true,
                                title       = STRINGS.ACCOMPLISHMENTS.UI.CATEGORY[string.upper(category_name)] or category_name,
                                count       = subfmt(STRINGS.UI.XPUTILS.XPPROGRESS, { num=count_completed, max=count })
                            })

                        -- Sort achievements.
                        assert(KAACHIEVEMENT.SORT[1] == "Default")
                        assert(KAACHIEVEMENT.SORT[2] == "Alphabetically")
                        assert(KAACHIEVEMENT.SORT[3] == "Unlocked_Locked")
                        assert(KAACHIEVEMENT.SORT[4] == "Locked_Unlocked")

                        local entries = category_entries
                        if sort == 1 then
                            -- Perform deepcopy so the sorting doesn't affect the original order.
                            entries = deepcopy(entries)

                            -- Sort the title strings alphabetically
                            table.sort(entries,
                                function (k1, k2)
                                    return GetTrophyTitle(category_name, k1.name) < GetTrophyTitle(category_name, k2.name)
                                end)
                        end

                        -- Insert the incompleted achievements at first
                        if sort == 3 then
                            for i,entry in ipairs(entries) do
                                local completed = entry.Check and entry.Check(data)
                                if not completed then
                                    InsertEntry(data, scrollitems, category_name, entry)
                                end
                            end
                        end

                        -- Insert each achievement.
                        for i,entry in ipairs(entries) do
                            -- Insert only the completed achievements if sorted by unlocked/locked.
                            local completed = entry.Check and entry.Check(data)
                            if completed or (sort ~= 2 and sort ~= 3) then
                                InsertEntry(data, scrollitems, category_name, entry)
                            end
                        end

                        -- Insert the incompleted achievements at the end
                        if sort == 2 then
                            for i,entry in ipairs(entries) do
                                local completed = entry.Check and entry.Check(data)
                                if not completed then
                                    InsertEntry(data, scrollitems, category_name, entry)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    local grid = TEMPLATES.ScrollingGrid(
        scrollitems,
        {
            scroll_context          =
            {
                settingWidget    = panel.settingWidget,
                candidatesWidget = panel.candidatesWidget,
            },
            widget_width            = row_w,
            widget_height           = row_h+row_spacing,
            -- peek_height             = 0,
            force_peek              = true,
            num_visible_rows        = num_visible_rows,
            num_columns             = 1,
            item_ctor_fn            = ScrollWidgetsCtor,
            apply_fn                = ScrollWidgetApply,
            scrollbar_offset        = 25,
            scrollbar_height_offset = -60,
            scroll_per_click        = 0.5,
        })

    return grid
end

-- KaAchievementsPanel:DrawPlayerHead()
function KaAchievementsPanel:DrawPlayerHead()
    if title_bar_h == 0 then return end

    for worldId, worldData in pairs(self.data or {}) do
        if worldData then
            local client = worldData.client
            if client then
                self.player_head_root = self.achievements_root:AddChild(Widget("player_head_root"))

                local player_head = self.player_head_root:AddChild(Widget("player_head"))
                local player_head_width = 0

                local badge_w = 65
                local PlayerBadge = require("widgets/playerbadge")
                player_head.badge = player_head:AddChild(PlayerBadge("", DEFAULT_PLAYER_COLOUR, false, 0))
                player_head.badge:SetScale(1)
                player_head.badge:SetPosition(badge_w/2,3)
                player_head.badge:Set(client.prefab or "", client.colour or DEFAULT_PLAYER_COLOUR, false, client.userflags or 0, client.base_skin)
                player_head.badge:Show()
                player_head_width = player_head_width + badge_w

                player_head.name = player_head:AddChild(Text(UIFONT, 45, ""))
                player_head.name:SetString(subfmt(STRINGS.ACCOMPLISHMENTS.UI.PLAYER_VIEW_TITLE, {name=client.name}))
                local name_w, name_h = player_head.name:GetRegionSize()
                local name_padding = 14
                player_head.name:SetScale(1)
                player_head.name:SetPosition(badge_w + name_padding + name_w/2,0)
                player_head.name:SetColour(unpack(client.colour or DEFAULT_PLAYER_COLOUR))
                player_head.name:SetHAlign(ANCHOR_LEFT)
                player_head_width = player_head_width + name_padding + name_w

                player_head:SetPosition(-player_head_width / 2, 0)

                self.player_head_root:SetScale(0.8)
                self.player_head_root:SetPosition(0, dialog_h / 2 + button_bar_h + title_bar_h / 2 + dialog_border_h)
                self.player_head = player_head
                break
            end
        end
    end
end

-- KaAchievementsPanel:Bake()
function KaAchievementsPanel:Bake()
    -- Recycle the previous grid if any.
    if self.grid then
        self.grid:Kill()
        self.grid = nil
    end

    -- Bake page.
    local grid = nil

    grid = self.dialog:InsertWidget( BuildAchievementsExplorer(self) )
    grid:SetPosition(-10,0)

    self.grid = grid
    self.focus_forward = grid
    self.default_focus = grid

    -- Should only have one
    if self.title then
        for k,v in pairs(self.data) do
            self.title:SetString(v.servername)
        end
    end

    if self.scrollToData then
        local category = self.scrollToData.category
        local trophy = self.scrollToData.trophy
        local index = self:FindEntryIndex(category, trophy)
        print(modName, "KaAchievementsPanel", "scrollToData", category, trophy, index)
        self.grid:ScrollToScrollPos(index)
        self.scrollToData = nil
    end
end

-- KaAchievementsPanel:LoadAndBakePage()
function KaAchievementsPanel:LoadAndBakePage()
    local loadedFromServer = false
    self.data, loadedFromServer = GetKaAchievementLoader():GetData(self.session_identifier, self.userid)

    -- If data is loaded from server via RPC, we need to poll until we got response from server.
    if loadedFromServer then
        if self.load_task then
            self.load_task:Cancel()
            self.load_task = nil
            self.load_task_counter = nil
        end

        local giveup_time, retry_period = 3, 0.1
        self.load_task = self.inst:DoPeriodicTask(0.1, function()
            -- Poll data from loader
            self.load_task_counter = (self.load_task_counter or 0) + 1
            if GetKaAchievementLoader().data ~= nil or self.load_task_counter > (giveup_time / retry_period) then
                self.data = GetKaAchievementLoader().data or {}
                self:DrawPlayerHead()
                self:Bake()
                self.load_task:Cancel()
                self.load_task = nil
            end
        end)
    else
        -- If data is too large to load, we should use a GenericWaitingPopup.
        -- Need to delay 1 frame for the data to load.
        self.inst:DoTaskInTime(0, function()
            self:DrawPlayerHead()
            self:Bake()
        end)
    end
end

-- KaAchievementsPanel:CreateSettingWidget()
function KaAchievementsPanel:CreateSettingWidget()
    local settingWidget = self.achievements_root:AddChild(KaAchievementsPanelSetting(self))

    settingWidget:SetPosition(520, 0)

    if not settingWidget:ShouldShowSetting() then
        settingWidget:Hide()
    end

    return settingWidget
end

-- KaAchievementsPanel:CreateCandidatesWidget()
function KaAchievementsPanel:CreateCandidatesWidget()
    local candidatesWidget = self.achievements_root:AddChild(KaAchievementsCandidatesWidget())

    candidatesWidget:SetPosition(-520, 0)
    -- candidatesWidget:Hide()

    return candidatesWidget
end

function KaAchievementsPanel:FindEntryIndex(category, trophy)
    local index = 0
    local grid = self.grid
    if grid then
        for i = 1, #grid.items do
            if grid.items[i].category == category and grid.items[i].name == trophy then
                index = i
                break
            end
        end
    end
    return index
end

function KaAchievementsPanel:ScrollToTrophy(category, trophy)
    for i,v in ipairs(self.buttons) do
        if v.category == category then
            v.onclick()
            break
        end
    end

    self.scrollToData = {category=category, trophy=trophy}
end

return KaAchievementsPanel
