require("kaachievement_utils/utils")

local Widget = require "widgets/widget"
local Text = require "widgets/text"
local Image = require "widgets/image"

local TEMPLATES = require "widgets/redux/templates"
local PopupDialogScreen = require "screens/redux/popupdialog"

local units_per_row = 2
local num_rows = math.ceil(19 / units_per_row)

local dialog_size_x = 830
local dialog_width = dialog_size_x + (60*2) -- nineslice sides are 60px each
local row_height = 30 * units_per_row
local row_width = dialog_width*0.9
local dialog_size_y = row_height*(num_rows + 0.25)

local modName = "KaAchievement"

-- Class KaAchievementsClusterPanel
local KaAchievementsClusterPanel = Class(Widget, function(self)
    Widget._ctor(self, "KaAchievementsClusterPanel")

    -- @note: We can learn from this PlayerHistory class
    -- self.player_history = PlayerHistory:GetRows()

    -- Load user data
    self:LoadUserData(modName)

    -- dumptable(self.data or {})

    self.root = self:AddChild(Widget("ROOT"))
    self.root:SetPosition(0,0)

    self.dialog = self.root:AddChild(TEMPLATES.RectangleWindow(dialog_size_x, dialog_size_y))
    self.dialog:SetPosition(0, 0)

    self:DoInit()

    self.focus_forward = self.trophy_scroll_list
end)

-- KaAchievementsClusterPanel:LoadUserData(...)
function KaAchievementsClusterPanel:LoadUserData(filename)
    -- Read client persistent data and store in the class.
    TheSim:GetPersistentString(filename, function(load_success, data)
        if load_success and data then
            local status, data = pcall(function() return json.decode(data) end)

            -- Create an empty data if the client data does not exist or is not valid
            if not data or type(data) ~= "table" then
                data = {}
            end

            self.data = data
        else
            print(modName, 'Failed to load persistent data', filename)
            self.data = {}
        end
    end)
end

-- KaAchievementsClusterPanel:SaveUserData(...)
function KaAchievementsClusterPanel:SaveUserData(filename)
    local compress = true
    TheSim:SetPersistentString(modName, json.encode(self.data), compress)
end

-- get_character_icon(...)
local function get_character_icon(character)
    local atlas = "images/saveslot_portraits"
    if not table.contains(DST_CHARACTERLIST, character) then
        if table.contains(MODCHARACTERLIST, character) then
            atlas = atlas.."/"..character
        else
            character = #character > 0 and "mod" or "unknown"
        end
    end
    return atlas..".xml", character..".tex"
end

-- BuildCharacterPortrait(...)
local function BuildCharacterPortrait(name)
    local portrait_scale = 0.25 * units_per_row
    local base = Widget(name)
    base:SetScale(portrait_scale, portrait_scale, 1)

    base.portraitbg = base:AddChild(Image("images/saveslot_portraits.xml", "background.tex"))
    base.portraitbg:SetClickable(false)
    base.portrait = base:AddChild(Image())
    base.portrait:SetClickable(false)

    base.SetCharacter = function(self, character)
        if character ~= nil then
            self.portrait:SetTexture(get_character_icon(character))
            self:Show()
        else
            self:Hide()
        end
    end

    return base
end

-- trophy_widget_constructor(...)
local function trophy_widget_constructor(context, i)
    local top_y = -12

    local w = Widget("control-trophy")
    w.root = w:AddChild(Widget("trophy-hideable_root"))

    local onclickdown = function() end
    local onclickup   = function()
        PushAchievementScreen(TheNet:GetUserID(), context.clusterPanel.trophy_scroll_list.items[i].session_identifier)
    end

    w.bg = w.root:AddChild(TEMPLATES.ListItemBackground(row_width, row_height, onclickup))
    w.bg:SetOnGainFocus(function() context.clusterPanel.trophy_scroll_list:OnWidgetFocus(w) end)
    w.bg:SetOnDown(onclickdown)
    -- w.bg.AllowOnControlWhenSelected = true -- Adai: Don't know what this does

    w.widgets = w.root:AddChild(Widget("trophy-data_root"))
    w.widgets:SetPosition(-row_width/2, 0)

    local spacing = 15
    local x = spacing

    w.widgets.character = w.widgets:AddChild(BuildCharacterPortrait("character"))
    x = x + row_height/2
    w.widgets.character:SetPosition(x , 0)
    x = x + row_height/2 + spacing

    w.widgets.servername = w.widgets:AddChild(Text(HEADERFONT, 26))
    w.widgets.servername:SetColour(UICOLOURS.GOLD)
    w.widgets.servername._position = { x = x, y = 10, w = 400 }

    w.widgets.desc = w.widgets:AddChild(Text(CHATFONT, 22))
    w.widgets.desc:SetColour(UICOLOURS.GOLD_UNIMPORTANT)
    w.widgets.desc._position = { x = x, y = -13, w = 570 }

    local button_x = row_width - spacing - 20

    w.widgets.delete_btn = w.widgets:AddChild(
        TEMPLATES.IconButton(
            "images/button_icons.xml",                         -- iconAtlas
            "delete.tex",                                      -- iconTexture
            STRINGS.ACCOMPLISHMENTS.UI.CLUSTER_PANEL.DELETE,   -- labelText
            false,                                             -- sideLabel
            false,                                             -- alwaysShowLabel
            nil,                                               -- onclick
            {                                                  -- textinfo
                font         = nil,
                size         = nil,
                colour       = nil,
                focus_colour = nil,
                bg           = nil,
                offset_x     = 0,
                offset_y     = 20,
            }))
    w.widgets.delete_btn:SetPosition(button_x, 0)
    w.widgets.delete_btn:SetScale(0.8)
    w.widgets.delete_btn:SetFocusChangeDir(MOVE_LEFT, w.bg)

    local function DeleteAccomplishment()
        TheFrontEnd:PushScreen(
            PopupDialogScreen(STRINGS.ACCOMPLISHMENTS.UI.CLUSTER_PANEL.DELETE_TITLE,
                              STRINGS.ACCOMPLISHMENTS.UI.CLUSTER_PANEL.DELETE_DESC,
        {
            {
                text = STRINGS.UI.CONTROLSSCREEN.YES,
                cb = function()
                    local item = context.clusterPanel.trophy_scroll_list.items[i]
                    item.mark_deleted = true
                    context.clusterPanel.data[item.session_identifier].mark_deleted = true
                    context.clusterPanel:SaveUserData(modName)

                    TheFrontEnd:PopScreen()

                    context.clusterPanel:DoInit()
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

    w.widgets.delete_btn:SetOnClick(DeleteAccomplishment)

    button_x = button_x - spacing - 20

    local function SequenceFocusHorizontal(left, right)
        left:SetFocusChangeDir(MOVE_RIGHT, right)
        right:SetFocusChangeDir(MOVE_LEFT, left)
    end

    w.focus_forward = w.bg

    return w
end

-- SetTruncatedLeftJustifiedString(...)
local function SetTruncatedLeftJustifiedString(txt, str)
    txt:SetTruncatedString(str or "", txt._position.w, nil, true)
    local width, height = txt:GetRegionSize()
    txt:SetPosition(txt._position.x + width/2, txt._position.y)
end

-- SetTruncatedRightJustifiedString(...)
local function SetTruncatedRightJustifiedString(txt, str)
    txt:SetTruncatedString(str or "", txt._position.w, nil, true)
    local width, height = txt:GetRegionSize()
    txt:SetPosition(txt._position.x - width/2, txt._position.y)
end

-- trophy_widget_update(...)
local function trophy_widget_update(context, w, data, index)
    if w == nil then
        return
    elseif data == nil then
        w.root:Hide()
        return
    else
        w.root:Show()

        w.widgets.character:SetCharacter(data.prefab or "unknown")

        local filtered_text = ApplyLocalWordFilter(data.servername or STRINGS.ACCOMPLISHMENTS.UI.SERVER_LIST.SERVERNAME_MISSING, TEXT_FILTER_CTX_SERVERNAME)
        SetTruncatedLeftJustifiedString(w.widgets.servername, ServerPreferences:IsNameAndDescriptionHidden(data.servername) and STRINGS.UI.SERVERLISTINGSCREEN.HIDDEN_NAME or filtered_text or STRINGS.UI.MORGUESCREEN.UNKNOWN_DAYS)

        local data_str = data.last_updated ~= nil and os.date(STRINGS.ACCOMPLISHMENTS.UI.SERVER_LIST.DESC_FMT, data.last_updated) or STRINGS.UI.MORGUESCREEN.UNKNOWN_DAYS
        SetTruncatedLeftJustifiedString(w.widgets.desc, data_str)

        w.widgets.delete_btn._userid = data.userid
    end
end

-- KaAchievementsClusterPanel:DoInit()
function KaAchievementsClusterPanel:DoInit()
    self.arrayData = {}
    for k,v in pairs(self.data) do
        if v.mark_deleted ~= true then
            local worldData = deepcopy(v)
            worldData.session_identifier = k
            table.insert(self.arrayData, worldData)
        end
    end

    if #self.arrayData == 0 then
        if self.emptyText == nil then
            local emptyText = self:AddChild(Text(HEADERFONT, 32))
            emptyText:SetColour(UICOLOURS.GOLD)
            emptyText:SetString(STRINGS.ACCOMPLISHMENTS.UI.CLUSTER_PANEL.EMPTY)
            emptyText:SetHAlign(ANCHOR_MIDDLE)
            self.emptyText = emptyText
        end
        self.emptyText:Show()
    elseif self.emptyText ~= nil then
        self.emptyText:Hide()
    end

    if self.trophy_scroll_list ~= nil then
        self.root:RemoveChild(self.trophy_scroll_list)
        self.trophy_scroll_list:Kill()
    end

    self.trophy_scroll_list = self.root:AddChild(TEMPLATES.ScrollingGrid(
            self.arrayData,
            {
                scroll_context = {
                    clusterPanel = self,
                },
                widget_width  = row_width,
                widget_height = row_height,
                num_visible_rows = num_rows,
                num_columns = 1,
                item_ctor_fn = trophy_widget_constructor,
                apply_fn = trophy_widget_update,
                scrollbar_offset = 20,
                scrollbar_height_offset = -60
            }))
end

return KaAchievementsClusterPanel