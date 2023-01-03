local KA_DEBUG_UTILS = false
local modName = "KaAchievement"
local settingsFileName = "KaAchievementSettings"
local PlayerHud = require("screens/playerhud")

STRINGS.ACCOMPLISHMENTS = require("kaachievement_utils/strings_en").ACCOMPLISHMENTS

-- Copied from Klei
local function DoTranslateStringTable(base, tbl)
    for k,v in pairs(tbl) do
        local path = base.."."..k
        if type(v) == "table" then
            DoTranslateStringTable(path, v)
        else
            local str
            if LanguageTranslator.use_longest_locs then
                str = LanguageTranslator:GetLongestTranslatedString(path)
            else
                str = LanguageTranslator:GetTranslatedString(path)
            end

            if str and str ~= "" then
                tbl[k] = str
            end
        end
    end
end

-- Copied from Klei
function KaTranslateStringTable(tbl)
    local root = "STRINGS"
    DoTranslateStringTable(root, tbl)
end

function ApplyLocalization()
    local supportedLangs =
    {
        kr = true,
        zh = true,
        zht = true,
        br = true,
    }

    -- Recursive function to process table structure
    local function LinearizeTable(base, src, dst)
        _G.assert(dst ~= src)
        for k,v in pairs(src) do
            local path = base.."."..k
            if type(v) == "table" then
                LinearizeTable(path, v, dst)
            else
                dst[path] = v
            end
        end
    end

    for langCode,_ in pairs(supportedLangs) do
        if _G.LanguageTranslator.languages[langCode] == nil then
            _G.LanguageTranslator.languages[langCode] = {}
        end
        LinearizeTable("STRINGS", require("kaachievement_utils/strings_" .. langCode), _G.LanguageTranslator.languages[langCode])
    end

    TheSim:GetPersistentString("KaAchievementSettings", function(load_success, data)
        if load_success and data then
            local status, data = pcall(function() return json.decode(data) end)

            if status and data and data.lang and data.lang ~= nil then
                LanguageTranslator.defaultlang = data.lang
                print(modName, 'Setting language to', data.lang)
                KaTranslateStringTable(STRINGS)
            end
        else
            print(modName, 'Failed to load persistent data', "KaAchievementSettings")
        end
    end)
end

ApplyLocalization()

require("kaachievement_utils/constants")

function GetCompletedVarName(category_name, achievement_name)
    return string.format("completed_%s_%s", category_name, achievement_name)
end

-- function PushAchievementScreen()
function PushAchievementScreen(userid, sessionId)
    assert(TheFrontEnd ~= nil)

    if TheFrontEnd.screenroot.achievementScreen == nil then
        local KaAchievementsPopup = require("screens/kaachievementspopup");
        local userid = userid or (ThePlayer and ThePlayer.userid) or TheNet:GetUserID() or nil
        local sessionId = sessionId or (TheWorld and TheWorld.net.components.shardstate:GetMasterSessionId()) or nil
        TheFrontEnd.screenroot.achievementScreen = TheFrontEnd.screenroot:AddChild(KaAchievementsPopup(sessionId, userid));
        TheFrontEnd:PushScreen(TheFrontEnd.screenroot.achievementScreen);
    end
end

-- function PopAchievementScreen()
function PopAchievementScreen()
    assert(TheFrontEnd ~= nil)

    if TheFrontEnd.screenroot.achievementScreen then
        TheFrontEnd.screenroot.achievementScreen:_Close()
    end
end

function GetKaAchievementPopupWidget(screen)
    local screenroot = TheFrontEnd and TheFrontEnd.screenroot

    if screen then
        screenroot = screen
    end

    if screenroot then
        if screenroot.kaAchievementsNotifPopUp == nil then
            local KaAchievementsNotifPopUp = require("widgets/kaachievementsnotifpopup")
            screenroot.kaAchievementsNotifPopUp = screenroot:AddChild(KaAchievementsNotifPopUp(ThePlayer))
        end
        assert(screenroot.kaAchievementsNotifPopUp ~= nil)
    end
    return screenroot and screenroot.kaAchievementsNotifPopUp
end

-- function KeyHandler(key, down)
-- For debugging.
function KaAchievementKeyHandler(key, down)
    if down then
        if TheFrontEnd then
            if KA_DEBUG_UTILS then
                local popupWidget = GetKaAchievementPopupWidget(TheFrontEnd:GetActiveScreen())
                if popupWidget ~= nil then
                    if key == KEY_F1 then
                        popupWidget:PushFake()
                    elseif key == KEY_F2 and popupWidget:IsVisible() then
                        popupWidget:FadeOut()
                    end
                else
                    print(modName, "KaAchievementKeyHandler: popupWidget is nil")
                    print(debugstack())
                end
            end

            if key == GetKaAchievementSettings().hotkey and (KA_DEBUG_UTILS or (TheWorld ~= nil and MOD_RPC[modName] ~= nil)) then
                local saveToPushScreen = not PlayerHud.IsConsoleScreenOpen() and
                                         not PlayerHud.IsChatInputScreenOpen() and
                                         not (ThePlayer and ThePlayer.HUD and ThePlayer.HUD:IsCraftingOpen())

                if saveToPushScreen then
                    if TheFrontEnd.screenroot.achievementScreen then
                        PopAchievementScreen()
                    else
                        PushAchievementScreen()
                    end
                end
            end
        end
    end
end

function GetKaAchievementLoader()
    if _G.TheKaAchievementLoader == nil then
        local KaAchievementLoader = require("kaachievementloader")
        _G.TheKaAchievementLoader = KaAchievementLoader()
    end
    return _G.TheKaAchievementLoader
end

function GetKaAchievementSettings()
    local settings = TheFrontEnd and TheFrontEnd.KaAchievementSettings

    if settings == nil then
        TheSim:GetPersistentString(settingsFileName, function(load_success, data)
            if load_success and data then
                local status, data = pcall(function() return json.decode(data) end)

                if status then
                    settings = data
                end
            else
                print(modName, 'Failed to load persistent data', settingsFileName)
            end

            if settings == nil then
                settings =
                {
                    hideTime       = true,
                    hideCounter    = true,
                    announceTrophy = false,
                    filter         = false,
                    sort           = 0,
                    lang           = "en",
                    showSetting    = false,
                    hotkey         = KEY_F4,
                }
            end
        end)
    end

    return settings
end

function SaveKaAchievementSettings(settings)
    local compress = false
    TheSim:SetPersistentString(settingsFileName, json.encode(settings), compress)
end

function GetTrophyTitle(category_name, trophy_name)
    return STRINGS.ACCOMPLISHMENTS[string.upper(category_name)][string.upper(trophy_name) .. "_TITLE"]
end

function GetTrophyDesc(category_name, trophy_name)
    return STRINGS.ACCOMPLISHMENTS[string.upper(category_name)][string.upper(trophy_name) .. "_DESC"]
end

function GetTrophyLabel(category_name, trophy_name)
    return STRINGS.ACCOMPLISHMENTS[string.upper(category_name)][string.upper(trophy_name) .. "_LABEL"] or
           STRINGS.ACCOMPLISHMENTS[string.upper(category_name)]["GENERIC_LABEL"]
end

function KaBroadcastAnnounceTrophy(userid, category_name, trophy_name)
    if userid then
        -- @Todo: Change to use TheNet:GetClientTable() instead. Make sure to exclude [Host].
        -- @Todo: To support cross-server announcement.
        for i,v in ipairs(AllPlayers) do
            print("SendModRPCToClient", "ClientAnnounceTrophy", i, v, v.userid)
            SendModRPCToClient(GetClientModRPC(modName, "ClientAnnounceTrophy"),
                v.userid,
                userid,
                category_name,
                trophy_name)
        end
    else
        print("KaBroadcastAnnounceTrophy", "userid == nil")
    end
end

function KaTrophyAnnounce(user_name, user_colour, trophy_title, sender_userid, sender_netid)
    print("KaTrophyAnnounce", user_name, user_colour, trophy_title, sender_userid, sender_netid)
    if user_name and user_colour and trophy_title then
        ChatHistory:OnTrophyAnnouncement(user_name, user_colour, trophy_title, sender_userid, sender_netid)
    end
end

function KaGetNumDone(dict, fn)
    local maxNum = 0
    local numDone = 0
    local candidates = {}

    for k,v in pairs(dict) do
        maxNum = maxNum + 1
        if fn(k,v) then
            numDone = numDone + 1
            candidates[k] = true
        else
            candidates[k] = false
        end
    end

    return numDone, maxNum, candidates
end

-- We manually update this if klei adds new weapons?
-- Exclude exclusive weapons. i.e: Wigfrid's Battle Spear
KaAllWeapons =
{
    batbat          = true,
    blowdart_fire   = true,
    blowdart_pipe   = true,
    blowdart_sleep  = true,
    blowdart_yellow = true,
    boomerang       = true,
    firestaff       = true,
    glasscutter     = true,
    hambat          = true,
    icestaff        = true,
    nightstick      = true,
    nightsword      = true,
    ruins_bat       = true,
    spear           = true,
    staff_tornado   = true,
    trident         = true,
    whip            = true,
    bullkelp_root   = true,
    tentaclespike   = true,
    waterplant_bomb = true,
    cutless         = true,
    fence_rotator   = true,
}

KaAllRelics =
{
    ruinsrelic_table    = true,
    ruinsrelic_chair    = true,
    ruinsrelic_vase     = true,
    ruinsrelic_plate    = true,
    ruinsrelic_bowl     = true,
    ruinsrelic_chipbowl = true,
}

KaAllBooks =
{
    book_tentacles             = true,
    book_birds                 = true,
    book_brimstone             = true,
    book_sleep                 = true,
    -- book_gardening             = true,
    book_horticulture          = true,
    book_silviculture          = true,
    book_horticulture_upgraded = true,
    book_fish                  = true,
    book_fire                  = true,
    book_web                   = true,
    book_temperature           = true,
    book_light                 = true,
    book_light_upgraded        = true,
    book_rain                  = true,
    book_moon                  = true,
    book_bees                  = true,
    book_research_station      = true,
}

KaAllSpiders =
{
    spider         = true,
    spider_warrior = true,
    spider_hider   = true,
    spider_spitter = true,
    spider_dropper = true,
    spider_moon    = true,
    spider_healer  = true,
    spider_water   = true,
}

local module_defs = require("wx78_moduledefs").module_definitions

KaWx78Modules = {}
for i,def in ipairs(module_defs) do
    KaWx78Modules["wx78module_" .. def.name] = true
end

KaAllFish =
{
    wobster_sheller   = true,
    wobster_moonglass = true,
}

local fish_defs = require("prefabs/oceanfishdef").fish

for k,_ in pairs(fish_defs) do
    KaAllFish[k] = true
end

-- https://www.lua.org/pil/19.3.html
function KaPairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
        table.sort(a, f)
        local i = 0      -- iterator variable
        local iter = function ()   -- iterator function
            i = i + 1
            if a[i] == nil then return nil
            else return a[i], t[a[i]]
        end
    end
    return iter
end