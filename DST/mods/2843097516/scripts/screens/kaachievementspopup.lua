require("kaachievement_utils/utils")

local KaAchievementsPanel = require("widgets/kaachievementspanel")
local Screen              = require("widgets/screen")
local TEMPLATES           = require("widgets/redux/templates")
local Text                = require("widgets/text")
local Widget              = require("widgets/widget")

-- Class KaAchievementsPopup.
local KaAchievementsPopup = Class(Screen, function(self, session_identifier, userid)
    Screen._ctor(self, "KaAchievementsPopup")
    self.session_identifier = session_identifier

    self:DoInit(userid)

    self.default_focus = self.achievements

    SetAutopaused(true)
end)

-- KaAchievementsPopup:OnDestroy()
function KaAchievementsPopup:OnDestroy()
    SetAutopaused(false)
    KaAchievementsPopup._base.OnDestroy(self)
end

-- KaAchievementsPopup:DoInit(userid)
function KaAchievementsPopup:DoInit(userid)
    self.root = self:AddChild(TEMPLATES.ScreenRoot())
    self.bg = self.root:AddChild(TEMPLATES.BackgroundTint(TheWorld and 0.75 or 0.9)) -- Set the background transparency.

    if not TheInput:ControllerAttached() then
        self.back_button = self.root:AddChild(TEMPLATES.BackButton(
                function()
                    self:_Close()
                end
            ))
    end

    -- Flags and placeholder header
    --[[
    self.level_text = self.root:AddChild(Text(HEADERFONT, 28, STRINGS.ACCOMPLISHMENTS.UI.TITLE, UICOLOURS.HIGHLIGHT_GOLD))
    self.level_text:SetPosition(0, 270)
    local w,h  = self.level_text:GetRegionSize()

    self.badge = self.root:AddChild(TEMPLATES.FestivalNumberBadge(FESTIVAL_EVENTS.QUAGMIRE))
    self.badge:SetRank(97)
    self.badge:SetScale(0.85)
    self.badge.num:SetSize(30/0.85)
    self.badge:SetPosition(w/2 + 35, 275)

    self.badge2 = self.root:AddChild(TEMPLATES.FestivalNumberBadge(FESTIVAL_EVENTS.LAVAARENA))
    self.badge2:SetRank(10)
    self.badge2.num:SetSize(30)
    self.badge2:SetPosition(-w/2 -40, 270)
    --]]

    self.achievements = self.root:AddChild(KaAchievementsPanel(self.session_identifier, userid))
    self.achievements:SetPosition(0, 0)
end

-- KaAchievementsPopup:OnControl()
function KaAchievementsPopup:OnControl(control, down)
    if KaAchievementsPopup._base.OnControl(self, control, down) then return true end

    if not down and control == CONTROL_CANCEL then
        self:_Close()
        return true
    end
end

-- KaAchievementsPopup:GetHelpText()
function KaAchievementsPopup:GetHelpText()
    local controller_id = TheInput:GetControllerID()
    local t = {}

    table.insert(t, TheInput:GetLocalizedControl(controller_id, CONTROL_CANCEL) .. " " .. STRINGS.UI.SERVERLISTINGSCREEN.BACK)

    return table.concat(t, "  ")
end

-- KaAchievementsPopup:_Close()
function KaAchievementsPopup:_Close()
    TheFrontEnd:PopScreen(self)
    TheFrontEnd.screenroot.achievementScreen = nil
    TheFrontEnd.screenroot:RemoveChild(self)
end

-- KaAchievementsPopup:ScrollTo(category, trophy)
function KaAchievementsPopup:ScrollToTrophy(category, trophy)
    self.achievements:ScrollToTrophy(category, trophy)
end

return KaAchievementsPopup
