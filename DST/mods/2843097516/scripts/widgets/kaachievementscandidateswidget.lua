require("kaachievement_utils/utils")

local Widget      = require("widgets/widget")
local TEMPLATES   = require("widgets/redux/templates")
local Image       = require("widgets/image")
local ImageButton = require("widgets/imagebutton")
local Text        = require("widgets/text")

local modName     = "KaAchievement"

local dialog_w    = 130
local dialog_h    = 200
local icon_size   = 40
local ICONS_PER_ROW = 5
local NUM_ITEMS_PER_PAGE = ICONS_PER_ROW * 8
local total_width = dialog_w / 0.7
local spacing     = (total_width - ICONS_PER_ROW * icon_size) / (ICONS_PER_ROW + 1)
local v_spacing   = math.max(spacing, 3)

-- Class KaAchievementsCandidatesWidget
local KaAchievementsCandidatesWidget = Class(Widget, function(self, unlockedList)
    Widget._ctor(self, "KaAchievementsCandidatesWidget")

    self.root = self:AddChild(Widget("root"))

    self.dialog = self.root:AddChild(TEMPLATES.RectangleWindow(dialog_w, 0))
    local r,g,b,a = unpack(UICOLOURS.BROWN_DARK)
    self.dialog:SetBackgroundTint(r,g,b,a)
    self.dialog:SetPosition(0,0)
    -- self.dialog.top:Hide() -- top crown

    -- Example of the unlockedList:
    -- unlockedList =
    -- {
    --     seeds = true,
    --     spear = false,
    --     oceanfish_small_5 = true,
    -- }
    local _OnControl = self.dialog.OnControl
    self.dialog.OnControl = function(_self, control, down)
        if down then
            if control == CONTROL_SCROLLBACK then
                self:PageUp()
            elseif control == CONTROL_SCROLLFWD  then
                self:PageDown()
            end
        end

        if _OnControl then _OnControl(_self, control, down) end
    end

    self.group = self.dialog:AddChild(Widget("group"))

    self.pageUpBtn = self.group:AddChild(ImageButton("images/global_redux.xml",
                                                     "arrow2_left.tex",
                                                     "arrow2_left_over.tex",
                                                     "arrow_left_disabled.tex",
                                                     "arrow2_left_down.tex"))
    self.pageUpBtn:SetOnClick(function() self:PageUp() end)
    self.pageUpBtn:SetScale(0.3, 0.3)

    self.pageDownBtn = self.group:AddChild(ImageButton("images/global_redux.xml",
                                                       "arrow2_right.tex",
                                                       "arrow2_right_over.tex",
                                                       "arrow_right_disabled.tex",
                                                       "arrow2_right_down.tex"))
    self.pageDownBtn:SetOnClick(function() self:PageDown() end)
    self.pageDownBtn:SetScale(0.3, 0.3)

    self.counter = 0

    self:Hide()
end)

local function MakeHoverText(prettyName, prefabCode)
    -- Kyno doesn't like prefab name be shown.
    -- return string.format("%s\n(%s)", tostring(prettyName), tostring(prefabCode))
    return tostring(prettyName)
end

function KaAchievementsCandidatesWidget:Prepare(unlockedList)
    self.candidates = {}

    if true then
        for prefab,bool in KaPairsByKeys(KaAllFish) do
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = prefab,
                hover    = MakeHoverText(STRINGS.NAMES[string.upper(prefab)], prefab),
                tex      = prefab:sub(1,#"wobster") == "wobster" and (prefab .. "_land.tex") or (prefab .. "_inv.tex"),
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end

    if true then
        for prefab,bool in KaPairsByKeys(KaAllWeapons) do
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = prefab,
                hover    = MakeHoverText(STRINGS.NAMES[string.upper(prefab)], prefab),
                tex      = prefab .. ".tex",
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end

    if true then
        local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS

        for k,v in KaPairsByKeys(PLANT_DEFS) do
            local prefab = k
            local texName = (k == "randomseed" and "seeds" or (k.."_seeds"))
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = prefab,
                hover    = MakeHoverText(STRINGS.NAMES[string.upper(texName)], texName),
                tex      = texName .. ".tex",
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end

    if true then
        local fertDefs = require("prefabs/fertilizer_nutrient_defs")

        for i,v in ipairs(fertDefs.SORTED_FERTILIZERS) do
            local prefab = v
            local fertDef = fertDefs.FERTILIZER_DEFS[prefab]
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = prefab,
                hover    = MakeHoverText(STRINGS.NAMES[fertDef.name], prefab),
                tex      = fertDef.inventoryimage,
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end

    if true then
        local allFoods = {}
        local preparedFoods = require("preparedfoods")
        local preparedNonFoods = require("preparednonfoods")

        for k,_ in pairs(preparedFoods) do allFoods[k] = true end
        for k,_ in pairs(preparedNonFoods) do allFoods[k] = true end

        for k,v in KaPairsByKeys(allFoods) do
            local prefab = k
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = prefab,
                hover    = MakeHoverText(STRINGS.NAMES[string.upper(prefab)], prefab),
                tex      = prefab .. ".tex",
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end

    if true then
        for k,v in KaPairsByKeys(KaAllRelics) do
            local prefab = k
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = prefab,
                hover    = MakeHoverText(STRINGS.NAMES[string.upper(prefab)], prefab),
                tex      = prefab .. ".tex",
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end

    if true then
        for k,v in KaPairsByKeys(KaAllBooks) do
            local prefab = k
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = prefab,
                hover    = MakeHoverText(STRINGS.NAMES[string.upper(prefab)], prefab),
                tex      = prefab .. ".tex",
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end

    if true then
        local preparedfoods_warly = require("preparedfoods_warly")
        for k,v in KaPairsByKeys(preparedfoods_warly) do
            local prefab = k
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = prefab,
                hover    = MakeHoverText(STRINGS.NAMES[string.upper(prefab)], prefab),
                tex      = prefab .. ".tex",
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end

    if true then
        for k,v in KaPairsByKeys(KaAllSpiders) do
            local prefab = k
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = prefab,
                hover    = MakeHoverText(STRINGS.NAMES[string.upper(prefab)], prefab),
                tex      = prefab .. ".tex",
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end

    if true then
        for k,v in KaPairsByKeys(KaWx78Modules) do
            local prefab = k
            local unlocked = unlockedList[prefab] and true or nil
            local candidate =
            {
                prefab   = k,
                hover    = MakeHoverText(STRINGS.NAMES[string.upper(prefab)], prefab),
                tex      = prefab .. ".tex",
                unlocked = unlocked,
            }

            table.insert(self.candidates, candidate)
        end
    end
end

function KaAchievementsCandidatesWidget:Bake(unlockedList)
    unlockedList = unlockedList or {}

    self:Prepare(unlockedList)

    if self.unlockedList then
        if self.unlockedList == unlockedList and unlockedList ~= {} then
            if self:IsVisible() or self.counter == 0 then
                self:Hide()
            else
                self:Show()
            end
            return
        end
    end

    local max_rows = 0
    local counter = 0
    local index_in_page = 0

    if self.pages then
        for i,v in ipairs(self.pages) do
            v:Kill()
        end
        self.pages = nil
    end

    self.pages = {}
    self.currentPage = 1

    local page = nil

    for i,candidate in ipairs(self.candidates) do
        if unlockedList[candidate.prefab] ~= nil or candidate.unlocked then
            index_in_page = counter % NUM_ITEMS_PER_PAGE

            if page == nil or index_in_page == 0 then
                page = self.group:AddChild(Widget("page"))
                table.insert(self.pages, page)
            end

            local img = page:AddChild(Image(GetInventoryItemAtlas(candidate.tex), candidate.tex))
            local col = index_in_page % ICONS_PER_ROW             -- 0-based
            local row = math.floor(index_in_page / ICONS_PER_ROW) -- 0-based

            max_rows = math.max(max_rows, row + 1)

            img:ScaleToSize(icon_size * 0.9, icon_size * 0.9)
            img:SetPosition(icon_size/2 + spacing + col * (icon_size + spacing), - icon_size/2 - v_spacing - row * (icon_size + v_spacing))
            img:SetHoverText(candidate.hover)

            if not candidate.unlocked then
                img:SetTint(unpack(UICOLOURS.BLACK))
            else
                img.check_icon = img:AddChild(Image("images/frontend_redux.xml", "accountitem_frame_arrow.tex")) -- This is the "check" icon
                img.check_icon:ScaleToSize(icon_size*0.5, icon_size*0.5)
                img.check_icon:SetPosition(icon_size*0.45, -icon_size*0.45)
            end

            page:AddChild(img)
            counter = counter + 1
        end
    end

    self:RefreshPage()

    local total_height = max_rows * icon_size + (max_rows + 1) * v_spacing
    self.group:SetPosition(-total_width/2, total_height/2)
    self.pageUpBtn:SetPosition(-20, -total_height/2)
    self.pageDownBtn:SetPosition(20+total_width, -total_height/2)

    -- local bg = self.root:AddChild(Image("images/global.xml", "square.tex"))
    -- bg:SetPosition(0, 0)
    -- bg:SetTint(0,1,0,0.2)
    -- bg:ScaleToSize(total_width, total_height)

    self.dialog:SetSize(dialog_w, total_height)

    self.unlockedList = unlockedList
    self.counter = counter

    if counter == 0 then
        print(modName, "KaAchievementsCandidatesWidget", "counter == 0, hide the widget.")
        self:Hide()
    else
        self:Show()
    end
end

function KaAchievementsCandidatesWidget:RefreshPage()
    for i,v in ipairs(self.pages) do
        if i == self.currentPage then
            v:Show()
        else
            v:Hide()
        end
    end

    if #self.pages <= 1 then
        self.pageUpBtn:Hide()
        self.pageDownBtn:Hide()
    else
        self.pageUpBtn:Show()
        self.pageDownBtn:Show()
        self.pageUpBtn:Disable()
        self.pageDownBtn:Disable()

        if self.currentPage ~= 1 then
            self.pageUpBtn:Enable()
        end

        if self.currentPage ~= #self.pages then
            self.pageDownBtn:Enable()
        end
    end
end

function KaAchievementsCandidatesWidget:PageUp()
    self.currentPage = math.max(1, self.currentPage - 1)
    self:RefreshPage()
end

function KaAchievementsCandidatesWidget:PageDown()
    self.currentPage = math.min(#self.pages, self.currentPage + 1)
    self:RefreshPage()
end

return KaAchievementsCandidatesWidget
