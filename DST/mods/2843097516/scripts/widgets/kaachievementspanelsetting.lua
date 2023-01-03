require("kaachievement_utils/utils")

local Widget      = require("widgets/widget")
local TEMPLATES   = require("widgets/redux/templates")
local Image       = require("widgets/image")
local ImageButton = require("widgets/imagebutton")
local Text        = require("widgets/text")

local modName     = "KaAchievement"

local dialog_w           = 130
local dialog_h           = 0
local text_width         = 130
local height             = 36
local row_spacing        = 10
local divider_h          = 5
local checkbox_size      = 50
local real_checkbox_size = checkbox_size * 0.5
local spacing            = 0
local font_size          = 20
local padding_x          = 10
local padding_y          = 5
local total_width        = text_width + real_checkbox_size + 3*padding_x
local total_offset       = -total_width/2
local bg_w               = total_width
local bg_h               = height + padding_y

local function AddBackground(wdg)
    wdg.bg = wdg:AddChild(TEMPLATES.ListItemBackground(bg_w, bg_h))
    wdg.bg:SetPosition(bg_w/2+total_offset, 0)
    wdg.bg:MoveToBack()
end

local function CreateTextSpinner(spinnerdata, selectedIndex, hovertext)
    local wdg = TEMPLATES.StandardSpinner(spinnerdata, total_width, height*0.8, CHATFONT, font_size, nil, UICOLOURS.GOLD_UNIMPORTANT)

    wdg:SetSelectedIndex(selectedIndex)

    AddBackground(wdg)

    wdg:SetHoverText(hovertext,
        {
            font = NEWFONT_OUTLINE,
            offset_y = 60,
        })

    wdg.OnControl = function(self, control, down)
        if self._base.OnControl(self, control, down) then return true end

        if down then
            if control == self.control_prev or control == CONTROL_SCROLLBACK then
                self:Prev()
                return true
            elseif control == self.control_next or control == CONTROL_SCROLLFWD  then
                self:Next()
                return true
            end
        end
    end

    return wdg
end

local function CreateCheckBox(labeltext, hovertext, onclicked, checked)
    local wdg = Widget("labelbutton")

    wdg.label = wdg:AddChild(Text(CHATFONT, font_size, labeltext))
    wdg.label:SetPosition(padding_x+real_checkbox_size+padding_x+text_width/2+total_offset, 0)
    wdg.label:SetRegionSize(text_width, height)
    wdg.label:SetHAlign(ANCHOR_LEFT)
    wdg.label:SetColour(UICOLOURS.GOLD_UNIMPORTANT)

    wdg.button = wdg:AddChild(TEMPLATES.StandardCheckbox(onclicked, checkbox_size, checked))
    wdg.button:SetPosition(padding_x+real_checkbox_size/2+total_offset, 0)

    AddBackground(wdg)

    wdg.focus_forward = wdg.button
    wdg.checked = checked

    wdg:SetHoverText(hovertext,
        {
            font = NEWFONT_OUTLINE,
            offset_y = 60,
        })
    return wdg
end

local function CreateDeleteButton(panel)
    local button =
        ImageButton("images/global_redux.xml",           -- atlas
                    "button_carny_square_normal.tex",    -- normal
                    "button_carny_square_hover.tex",     -- focus
                    "button_carny_square_disabled.tex",  -- disabled
                    "button_carny_square_down.tex",      -- down
                    "button_carny_square_down.tex")      -- selected

    button.overlay_image = button:AddChild(
        Image("images/achievementsimages/achievements_buttons.xml", "achievements_buttons_delete.tex"))
    button.overlay_image:SetScale(1.2)

    button:SetPosition(0, -60)
    button:SetScale(0.25)

    local function DeleteAccomplishment()
        local PopupDialogScreen = require("screens/redux/popupdialog")

        TheFrontEnd:PushScreen(
            PopupDialogScreen(STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.DELETE_TITLE,
                              STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.DELETE_DESC,
        {
            {
                text = STRINGS.UI.CONTROLSSCREEN.YES,
                cb = function()
                    SendModRPCToServer(GetModRPC(modName, "ResetServerData"), ThePlayer.userid)
                    TheFrontEnd:PopScreen()
                    panel:LoadAndBakePage()
                end
            },
            {
                text = STRINGS.UI.CONTROLSSCREEN.NO,
                cb = function()
                    TheFrontEnd:PopScreen()
                end
            }
        }))
    end

    if TheWorld then
        button:SetOnClick(DeleteAccomplishment)
    end

    return button
end

local function CreateDeleteWidget(labeltext, hovertext, panel)
    local wdg = Widget("labelbutton")

    wdg.label = wdg:AddChild(Text(CHATFONT, font_size, labeltext))
    wdg.label:SetPosition(padding_x+real_checkbox_size+padding_x+text_width/2+total_offset, 0)
    wdg.label:SetRegionSize(text_width, height)
    wdg.label:SetHAlign(ANCHOR_LEFT)
    wdg.label:SetColour(UICOLOURS.GOLD_UNIMPORTANT)

    wdg.button = wdg:AddChild(CreateDeleteButton(panel))
    wdg.button:SetPosition(padding_x+real_checkbox_size/2+total_offset, 0)

    wdg.bg = wdg:AddChild(TEMPLATES.ListItemBackground(bg_w, bg_h))
    wdg.bg:SetPosition(bg_w/2+total_offset, 0)
    wdg.bg:MoveToBack()

    wdg.focus_forward = wdg.button

    wdg:SetHoverText(hovertext,
        {
            font = NEWFONT_OUTLINE,
            offset_y = 60,
        })
    return wdg
end

-- Class KaAchievementsPanelSetting
local KaAchievementsPanelSetting = Class(Widget, function(self, panel)
    Widget._ctor(self, "KaAchievementsPanelSetting")

    self:InitSettings()

    self.root = self:AddChild(Widget("root"))
    self.panel = panel

    self.dialog = self.root:AddChild(TEMPLATES.RectangleWindow(dialog_w, dialog_h))
    local r,g,b,a = unpack(UICOLOURS.BROWN_DARK)
    self.dialog:SetBackgroundTint(r,g,b,a)
    self.dialog:SetPosition(0,0)
    -- self.dialog.top:Hide() -- top crown

    self.group = self.root:AddChild(Widget("group"))
    local offset_h = 0

    -- Checkbox for timestamp
    self.cboxShowTimeStamp = self.group:AddChild(
        CreateCheckBox(
            STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.SHOW_TIME,
            STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.SHOW_TIME_HOVER,
            function() return self.cboxShowTimeStamp:OnClick() end,
            not self:ShouldHideTime()))  -- Default checked status

    self.cboxShowTimeStamp.OnClick = function(cbox)
        cbox.checked = not cbox.checked
        self:SetHideTime(not cbox.checked) -- Check means to show
        self.panel.grid:RefreshView()
        return cbox.checked
    end

    self.cboxShowTimeStamp:SetPosition(0, offset_h-0.5*height)
    offset_h = offset_h - height - row_spacing

    -- Checkbox for counter
    self.cboxShowCounter = self.group:AddChild(
        CreateCheckBox(
            STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.SHOW_COUNTER,
            STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.SHOW_COUNTER_HOVER,
            function() return self.cboxShowCounter:OnClick() end,
            not self:ShouldHideCounter()))  -- Default checked status

    self.cboxShowCounter.OnClick = function(cbox)
        cbox.checked = not cbox.checked
        self:SetHideCounter(not cbox.checked) -- Check means to show
        self.panel.grid:RefreshView()
        if self.panel.candidatesWidget and not cbox.checked then
            self.panel.candidatesWidget:Hide()
        end
        return cbox.checked
    end

    self.cboxShowCounter:SetPosition(0, offset_h-0.5*height)
    offset_h = offset_h - height - row_spacing

    -- Checkbox for announce trophy
    self.cboxAnnounceTrophy = self.group:AddChild(
        CreateCheckBox(
            STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.ANNOUNEC_TROPHY,
            STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.ANNOUNEC_TROPHY_HOVER,
            function() return self.cboxAnnounceTrophy:OnClick() end,
            self:ShouldAnnounceTrophy()))  -- Default checked status

    self.cboxAnnounceTrophy.OnClick = function(cbox)
        cbox.checked = not cbox.checked
        self:SetAnnounceTrophy(cbox.checked) -- Check means to show
        self.panel.grid:RefreshView()
        return cbox.checked
    end

    self.cboxAnnounceTrophy:SetPosition(0, offset_h-0.5*height)
    offset_h = offset_h - height - row_spacing

    -- Spinner for language
    local selectedIndex = 1
    for i,v in ipairs(KAACHIEVEMENT.LANGS) do
        if self:GetLang() == v.data then
            selectedIndex = i
            break
        end
    end
    self.spinnerLang = self.group:AddChild(CreateTextSpinner(KAACHIEVEMENT.LANGS, selectedIndex, STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.LANG))

    self.spinnerLang:SetOnChangedFn(function(lang)
        if lang and lang ~= "" then
            self:SetLang(lang)
        end
        -- self.panel.grid:RefreshView()
        self.panel:Bake()
    end)

    self.spinnerLang:SetPosition(0, offset_h-0.5*height)
    offset_h = offset_h - height - row_spacing

    -- Spinner for Hotkey
    local keys = {}
    local selectedIndex = 1
    for i,v in ipairs(KAACHIEVEMENT.KEYS) do
        table.insert(keys, {text=(v==0 and STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.HOTKEY_NONE or STRINGS.UI.CONTROLSSCREEN.INPUTS[1][v]), data=v})
        -- STRINGS.UI.CONTROLSSCREEN.INPUTS[1]
        if v == self:GetHotkey() then
            selectedIndex = i
        end
    end
    self.spinnerHotkey = self.group:AddChild(CreateTextSpinner(keys, selectedIndex, STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.HOTKEY))
    -- self.spinnerHotkey.text:SetHorizontalSqueeze(0.8)
    self.spinnerHotkey.auto_shrink_text = true
    self.spinnerHotkey:SetHoverText(STRINGS.ACCOMPLISHMENTS.UI.HOTKEY, {offset_y=36})

    self.spinnerHotkey:SetOnChangedFn(function(hotkey)
        if self.spinnerHotkey.savetask then
            self.spinnerHotkey.savetask:Cancel()
            self.spinnerHotkey.savetask = nil
        end

        self.spinnerHotkey.savetask = self.spinnerHotkey.inst:DoTaskInTime(1, function()
            self:SetHotkey(self.spinnerHotkey:GetSelected().data)
            self.spinnerHotkey.savetask = nil
        end)
    end)

    self.spinnerHotkey.inst:ListenForEvent("onremove", function()
        if self.spinnerHotkey.savetask then
            self.spinnerHotkey.savetask:Cancel()
            self.spinnerHotkey.savetask = nil
            self:SetHotkey(self.spinnerHotkey:GetSelected().data)
        end
    end)

    self.spinnerHotkey:SetPosition(0, offset_h-0.5*height)
    offset_h = offset_h - height - row_spacing

    if TheWorld and ThePlayer and ThePlayer.userid == self.panel.userid then
        -- Divider
        self.divider = self.group:AddChild(Image("images/global_redux.xml", "item_divider.tex"))
        self.divider:ScaleToSize(dialog_w * 1.5, divider_h)
        self.divider:SetPosition(0, offset_h - 0.5*divider_h)
        offset_h = offset_h - divider_h - row_spacing

        -- Button for delete
        self.deleteButton = self.group:AddChild(
            CreateDeleteWidget(
                STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.DELETE,
                STRINGS.ACCOMPLISHMENTS.UI.PANEL_SETTING.DELETE_HOVER,
                self.panel))

        self.deleteButton:SetPosition(0, offset_h - 0.5*height)
        offset_h = offset_h - height - row_spacing
    end

    local group_h = -offset_h - row_spacing -- Remove one row_spacing
    self.group:SetPosition(0, 0.5*group_h)

    -- Finalize dialog size
    dialog_h = group_h + 2*row_spacing
    self.dialog:SetSize(dialog_w, dialog_h)
end)

function KaAchievementsPanelSetting:InitSettings()
    self.settings = GetKaAchievementSettings()
end

function KaAchievementsPanelSetting:ShouldHideTime()
    return self.settings.hideTime and true or false
end

function KaAchievementsPanelSetting:SetHideTime(hide)
    self.settings.hideTime = hide and true or false
    self:SaveSettings()
end

function KaAchievementsPanelSetting:ShouldHideCounter()
    return self.settings.hideCounter and true or false
end

function KaAchievementsPanelSetting:SetHideCounter(hide)
    self.settings.hideCounter = hide and true or false
    self:SaveSettings()
end

function KaAchievementsPanelSetting:ShouldShowSetting()
    return self.settings.showSetting and true or false
end

function KaAchievementsPanelSetting:SetShowSetting(show)
    self.settings.showSetting = show and true or false
    self:SaveSettings()
end

function KaAchievementsPanelSetting:GetFilter()
    return self.settings.filter or false
end

function KaAchievementsPanelSetting:SetFilter(filter)
    self.settings.filter = filter or false
    self:SaveSettings()
end

function KaAchievementsPanelSetting:GetSort()
    return self.settings.sort or 0
end

function KaAchievementsPanelSetting:SetSort(sort)
    self.settings.sort = sort or 0
    self:SaveSettings()
end

function KaAchievementsPanelSetting:GetLang()
    return self.settings.lang or "en"
end

function KaAchievementsPanelSetting:SetLang(lang)
    self.settings.lang = lang or "en"
    if lang == nil or lang == "en" then
        LanguageTranslator.defaultlang = nil
        STRINGS.ACCOMPLISHMENTS = loadfile("kaachievement_utils/strings_en")().ACCOMPLISHMENTS
    else
        LanguageTranslator.defaultlang = lang
        KaTranslateStringTable(STRINGS)
    end
    self:SaveSettings()
end

function KaAchievementsPanelSetting:GetHotkey()
    return self.settings.hotkey or KEY_F4
end

function KaAchievementsPanelSetting:SetHotkey(hotkey)
    self.settings.hotkey = hotkey or KEY_F4
    self:SaveSettings()
end

function KaAchievementsPanelSetting:ShouldAnnounceTrophy()
    return self.settings.announceTrophy and true or false
end

function KaAchievementsPanelSetting:SetAnnounceTrophy(shouldAnnounce)
    self.settings.announceTrophy = shouldAnnounce and true or false
    self:SaveSettings()
end

function KaAchievementsPanelSetting:SaveSettings()
    if TheFrontEnd then TheFrontEnd.KaAchievementSettings = self.settings end
    SaveKaAchievementSettings(self.settings)
end

function KaAchievementsPanelSetting:OnShow(was_hidden)
    self:SetShowSetting(true)
end

function KaAchievementsPanelSetting:OnHide(was_visible)
    self:SetShowSetting(false)
end

return KaAchievementsPanelSetting
