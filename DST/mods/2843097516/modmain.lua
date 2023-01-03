-- Mod Dependencies.
local _G        = GLOBAL
local require   = _G.require
local dumptable = _G.dumptable
local modName   = "KaAchievement"

_G.TheKaAchievementLoader = nil
require("kaachievement_utils/utils")
_G.TheKaAchievementLoader = _G.GetKaAchievementLoader()

require("kaachievement_utils/rpc")

local PlayerStatusScreen  = require("screens/playerstatusscreen")
local ImageButton         = require("widgets/imagebutton")
local Text                = require("widgets/text")

-- Mod Assets.
Assets =
{
    Asset("IMAGE", "images/achievementsimages/achievements_images.tex"),
    Asset("ATLAS", "images/achievementsimages/achievements_images.xml"),

    Asset("IMAGE", "images/achievementsimages/achievements_buttons.tex"),
    Asset("ATLAS", "images/achievementsimages/achievements_buttons.xml"),

    Asset("IMAGE", "images/achievementsimages/achievements_bg.tex"),
    Asset("ATLAS", "images/achievementsimages/achievements_bg.xml"),

    Asset("IMAGE", "images/achievementsimages/achievements_bg_black.tex"),
    Asset("ATLAS", "images/achievementsimages/achievements_bg_black.xml"),
}

-- Import all achievement files.
for i,categoryName in ipairs(_G.KAACHIEVEMENT.CATEGORIES) do
    -- require("achievements/achievements_xxxx")
    require("achievements/achievements_" .. string.lower(categoryName))
end

-- PatchRerollFunctions(player)
local function PatchRerollFunctions(player)
    -- Save the data before reroll-ed
    local old_SaveForReroll = player.SaveForReroll
    player.SaveForReroll = function(inst)
        local data = old_SaveForReroll(inst) or {}
        data.kaAchievementManager = inst.components.kaAchievementManager ~= nil and inst.components.kaAchievementManager:OnSave() or nil
        return _G.next(data) ~= nil and data or nil
    end

    -- Load the data back after reroll-ed
    local old_LoadForReroll = player.LoadForReroll
    player.LoadForReroll = function(inst, data)
        old_LoadForReroll(inst, data)
        if data.kaAchievementManager ~= nil and inst.components.kaAchievementManager ~= nil then
            inst.components.kaAchievementManager:OnLoad(data.kaAchievementManager)
        end
    end
end

-- AddPrefabPostInitAny(...)
AddPrefabPostInitAny(function(inst)
    if inst:HasTag("player") then
        local player = inst

        if player.kaAchievementData == nil then player.kaAchievementData = {} end

        if _G.TheNet:GetIsClient() then
            -- Client only.
            player.IsIntegratedBackpackOpen = function(self)
                local backpack = self.replica.inventory and self.replica.inventory:GetOverflowContainer()
                return _G.Profile:GetIntegratedBackpack() and backpack and backpack._isopen or false
            end
        else
            -- Server only.
            player:AddComponent("kaAchievementManager")
        end

        PatchRerollFunctions(player)
    end

    for i,categoryName in ipairs(_G.KAACHIEVEMENT.CATEGORIES) do
        -- Call RegisterXxxxAchievementEntries()
        _G["Register" .. _G.FirstToUpper(string.lower(categoryName)) .. "Achievements"](inst)
    end
end)

-- For debugging.
if _G.TheNet:GetIsClient() then
    _G.TheInput:AddKeyHandler(_G.KaAchievementKeyHandler)
end

-- Inject DoInit in PlayerStatusScreen.
local old_DoInit = PlayerStatusScreen.DoInit
function PlayerStatusScreen:DoInit(ClientObjs, ...)
    old_DoInit(self, ClientObjs, ...)

    if ClientObjs == nil then
        ClientObjs = _G.TheNet:GetClientTable() or {}
    end

    self.kaachievement_buttons = {}
    for _,playerListing in ipairs(self.player_widgets) do
        for _,client in ipairs(ClientObjs) do
            if playerListing.userid == client.userid and ((not playerListing.ishost) or _G.TheNet:GetServerIsClientHosted()) then
                local button = self.kaachievement_buttons[playerListing.userid]

                if button == nil then
                    button = playerListing:AddChild(ImageButton("images/achievementsimages/achievements_buttons.xml", "achievements_buttons_trophy1.tex"))
                end

                button:SetNormalScale(.5,.5)
                button:SetFocusScale(.6,.6)
                button:SetOnClick(function()
                    self:Close()
                    _G.PushAchievementScreen(playerListing.userid)
                end)

                local player = _G.UserToPlayer(playerListing.userid)
                local playerName = tostring(player and player.name or playerListing.userid)
                -- button:SetHoverText(_G.STRINGS.ACCOMPLISHMENTS.UI.ACHIEVEMENT_BUTTON .. ": " .. playerName, {font = NEWFONT_OUTLINE, size = 24, offset_x = 0, offset_y = 30, colour = WHITE})
                button:SetPosition(-306,-13) -- Put it at the bottom right of the player badge.
                -- button:SetPosition(377,5) -- Don't use this. It's on the right which covers the scroll bar.
                button:Hide()

                self.kaachievement_buttons[playerListing.userid] = button

                playerListing.kaAchievementShowTrophyButton = button
            end
        end
    end

    self.kaAchievementRebuild = true
end

-- Inject OnUpdate in PlayerStatusScreen.
local old_PlayerStatusScreen_OnUpdate = PlayerStatusScreen.OnUpdate
function PlayerStatusScreen:OnUpdate(dt, ...)
    old_PlayerStatusScreen_OnUpdate(self, dt, ...)

    if not self.kaAchievementRebuild then return end

    self.kaAchievementRebuild = false

    if self.scroll_list ~= nil then
        local ClientObjs = _G.TheNet:GetClientTable() or {}

        for _,playerListing in ipairs(self.player_widgets) do
            local button = playerListing.kaAchievementShowTrophyButton
            if button then
                button:Show()
            end
        end
    end
end

-- Hijack Klei's achievement helper function.
local old_AwardPlayerAchievement = _G.AwardPlayerAchievement
_G.AwardPlayerAchievement = function(name, player)
    old_AwardPlayerAchievement(name, player)
end


-- chatline.lua, chathistory.lua
local maxChatTypes = 0
local ChatTypes = _G.ChatTypes
local ChatHistory = _G.ChatHistory
for k,v in pairs(ChatTypes) do
    if v > maxChatTypes then maxChatTypes = v end
end
ChatTypes.TrophyAnnouncement = maxChatTypes + 1

_G.NoWordFilterForChatType[ChatTypes.TrophyAnnouncement] = false

AddClassPostConstruct("widgets/redux/chatline", require("kaachievement_utils/chatline_classpostconstruct"))
AddClassPostConstruct("widgets/redux/lobbychatline", require("kaachievement_utils/lobbychatline_classpostconstruct"))

ChatHistory.OnTrophyAnnouncement = function(self, user_name, user_colour, trophy_name, sender_userid, sender_netid)
    if self.join_server then return end
    self:AddToHistory(ChatTypes.TrophyAnnouncement, sender_userid, sender_netid, user_name, trophy_name, user_colour)
end

_G.ANNOUNCEMENT_ICONS["trophy"] = { atlas = "images/achievementsimages/achievements_buttons.xml", texture = "achievements_buttons_showall.tex" }


-- Register functions for debug.
modimport("scripts/kaachievement_utils/moddebug")

print(modName, "Loaded modmain.lua")
