require("kaachievement_utils/utils")

local modName = "kaAchievement"
local categoryName = "Boss"

-- @Note: "wathgrithr1" trophy has dependency on these variables.
local variables =
{
    numKilledBossAsWigfrid    = 0,
    numKilledDeerclopsYule    = 0,
    numKilledTwinsOfTerror    = 0,
    numKilledShadowChess      = 0,
    numKilledKlaus            = 0,
    numKilledEnragedKlaus     = 0,
    numKilledEnragedDragonfly = 0,
}

-- @Note: "wathgrithr1" trophy has dependency on these variables.
local boss_data =
{
    { index=0,  prefab = "deerclops",            varName = "numKilledDeerclops",        trophyName = "deerclops" },
    { index=2,  prefab = "moose",                varName = "numKilledMoose",            trophyName = "moose" },
    { index=3,  prefab = "dragonfly",            varName = "numKilledDragonfly",        trophyName = "dragonfly" },
    { index=5,  prefab = "malbatross",           varName = "numKilledMalbatross",       trophyName = "malbatross" },
    { index=6,  prefab = "minotaur",             varName = "numKilledMinotaur",         trophyName = "minotaur" },
    { index=7,  prefab = "bearger",              varName = "numKilledBearger",          trophyName = "bearger" },
    { index=8,  prefab = "beequeen",             varName = "numKilledBeequeen",         trophyName = "beequeen" },
    { index=9,  prefab = "antlion",              varName = "numKilledAntlion",          trophyName = "antlion" },
    { index=10, prefab = "toadstool",            varName = "numKilledToadstool",        trophyName = "toadstool" },
    { index=11, prefab = "toadstool_dark",       varName = "numKilledToadstoolMisery",  trophyName = "mtoadstool" },
    { index=12, prefab = "stalker",              varName = "numKilledStalker",          trophyName = "stalkercave" },
    { index=13, prefab = "stalker_atrium",       varName = "numKilledStalkerAtrium",    trophyName = "stalkeratrium" },
    { index=14, prefab = "crabking",             varName = "numKilledCrabking",         trophyName = "crabking" },
    { index=15, prefab = "spiderqueen",          varName = "numKilledSpiderqueen",      trophyName = "spiderqueen" },
    { index=16, prefab = "leif",                 varName = "numKilledLeif",             trophyName = "leif" },
    { index=17, prefab = "leif_sparse",          varName = "numKilledLeif",             trophyName = "leif" },
    { index=18, prefab = "eyeofterror",          varName = "numKilledEyeOfTerror",      trophyName = "eyeofterror" },
    { index=19, prefab = "alterguardian_phase3", varName = "numKilledAlterGuardian",    trophyName = "alterguardian" },
    { index=20, prefab = "lordfruitfly",         varName = "numKilledLordFruitFly",     trophyName = "lordfruitfly" },
}

local boss_prefabs = {}
for _,v in ipairs(boss_data) do
    variables[v.varName] = 0
    boss_prefabs[v.prefab] = 1
end

-- function BroadcastEventForNearPlayers(inst, data)
local function BroadcastEventForNearPlayers(inst, data)
    local x,y,z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, TUNING.KAACHIEVEMENT.BOSS.BROADCAST_RANGE)
    local numPlayers = 0

    for k,v in pairs(ents) do
        if v:HasTag("player") then
            v:PushEvent("ka_KilledBoss", data)
            numPlayers = numPlayers + 1
        end
    end

    -- For social category "bossfriend" trophy
    if numPlayers > 1 then
        for k,v in pairs(ents) do
            if v:HasTag("player") then
                v:PushEvent("ka_TeamKilledBoss", data)
            end
        end
    end
end

-- OnPlayerKilledBoss(player)
local function OnPlayerKilledBoss(player)
    print(modName, "OnPlayerKilledBoss()")

    local manager = player.components.kaAchievementManager

    -- Register the variables.
    for k,v in pairs(variables) do
        manager:RegisterVariable(k, v)
    end

    -- Register event callback functions.
    player:ListenForEvent("killed", function(player, data)
        local victim = data.victim

        if victim then
            if boss_prefabs[victim.prefab] ~= nil then
                BroadcastEventForNearPlayers(victim, data)
            elseif victim.prefab == "klaus" then
                -- Has to be phase two.
                if victim:IsUnchained() then
                    BroadcastEventForNearPlayers(victim, data)
                end
            elseif victim.prefab == "shadow_rook"   or
                   victim.prefab == "shadow_knight" or
                   victim.prefab == "shadow_bishop" then
                if victim.level >= 3 then
                    BroadcastEventForNearPlayers(victim, data)
                end
            elseif victim.prefab == "twinofterror1" or victim.prefab == "twinofterror2" then
                local twinmanager = nil

                for k,v in pairs(Ents) do
                    if v.prefab == "twinmanager" then
                        twinmanager = v
                        break
                    end
                end

                if twinmanager then
                    local et = twinmanager.components.entitytracker
                    local t1 = et:GetEntity("twin1")
                    local t2 = et:GetEntity("twin2")
                    if (t1 == nil or t1.components.health:IsDead()) and
                    (t2 == nil or t2.components.health:IsDead()) then
                        BroadcastEventForNearPlayers(victim, data)
                    end
                else
                    print(modName, "Error: twinmanager is not available.")
                end
            end
        end
    end)

    player:ListenForEvent("ka_KilledBoss", function(player, data)
        local victim = data.victim

        print(modName, "ListenForEvent(): ka_KilledBoss", player, victim)

        -- @Todo: Make the achievement delayed after a few seconds for stalker_atrium and alterguardian_phase3

        -- Adai: It's the way to test if you don't have other players join to test with you.
        -- player.AnimState:SetAddColour(0.2, 0, 0, 1.0)

        local killedBoss = false

        if victim then
            if victim.prefab == "twinofterror1" or victim.prefab == "twinofterror2" then
                manager.numKilledTwinsOfTerror = manager.numKilledTwinsOfTerror + 1
                manager:DoAchieve({category=categoryName, name="twinsofterror"}, {"numKilledTwinsOfTerror"})
                killedBoss = true
            elseif victim.prefab == "shadow_rook"   or
                   victim.prefab == "shadow_knight" or
                   victim.prefab == "shadow_bishop" then
                manager.numKilledShadowChess = manager.numKilledShadowChess + 1
                manager:DoAchieve({category=categoryName, name="shadowchess"}, {"numKilledShadowChess"})
                killedBoss = true
            elseif victim.prefab == "klaus" then
                manager.numKilledKlaus = manager.numKilledKlaus + 1
                manager:DoAchieve({category=categoryName, name="klaus"}, {"numKilledKlaus"})
                killedBoss = true

                if victim.enraged then
                    manager.numKilledEnragedKlaus = manager.numKilledEnragedKlaus + 1
                    manager:DoAchieve({category=categoryName, name="rageklaus"}, {"numKilledEnragedKlaus"})
                end
            else
                if victim.prefab == "deerclops" and IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST) then
                    manager.numKilledDeerclopsYule = manager.numKilledDeerclopsYule + 1
                    manager:DoAchieve({category=categoryName, name="deerclopsyule"}, {"numKilledDeerclopsYule"})
                    killedBoss = true
                end
                for _,v in pairs(boss_data) do
                    if victim.prefab == v.prefab then
                        manager[v.varName] = manager[v.varName] + 1
                        manager:DoAchieve({category=categoryName, name=v.trophyName}, {v.varName})
                        killedBoss = true

                        if victim.prefab == "dragonfly" and victim.enraged then
                            manager.numKilledEnragedDragonfly = manager.numKilledEnragedDragonfly + 1
                            manager:DoAchieve({category=categoryName, name="ragedragonfly"}, {"numKilledEnragedDragonfly"})
                        end
                        break
                    end
                end
            end

            if killedBoss then
                manager:DoAchieve({category=categoryName, name="allbosses"})

                if player.prefab == "wathgrithr" then
                    manager.numKilledBossAsWigfrid = manager.numKilledBossAsWigfrid + 1
                    manager:DoAchieve({category="Character", name="wathgrithr1"}, {"numKilledBossAsWigfrid"})
                end
            end
        end
    end)
end

-- RegisterBossAchievements(inst)
function RegisterBossAchievements(inst)
    if inst:HasTag("player") then
        local player = inst

        -- Register network variable on both server and client sides.
        for k,v in pairs(variables) do
            player.kaAchievementData[k] = net_shortint(player.GUID, k)
        end

        -- Server only.
        if not TheNet:GetIsClient() then
            OnPlayerKilledBoss(player)
        end
    end
end

-- RegisterBossAchievementEntries(root)
function RegisterBossAchievementEntries(root)
    local entries =
    {
        {
            index       = 1,
            name        = "deerclopsyule",
            Record      = function(data) return data and data.numKilledDeerclopsYule end,
            Check       = function(data) return data and data.numKilledDeerclopsYule and data.numKilledDeerclopsYule > 0 or false end,
            isHidden    = true,
        },
        {
            index       = 4,
            name        = "ragedragonfly",
            Record      = function(data) return data and data.numKilledEnragedDragonfly end,
            Check       = function(data) return data and data.numKilledEnragedDragonfly and data.numKilledEnragedDragonfly > 0 or false end,
            isHidden    = true,
            allBossesExcluded = true,
        },
        {
            index       = 21,
            name        = "shadowchess",
            Record      = function(data) return data and data.numKilledShadowChess end,
            Check       = function(data) return data and data.numKilledShadowChess and data.numKilledShadowChess > 0 or false end,
        },
        {
            index       = 22,
            name        = "klaus",
            Record      = function(data) return data and data.numKilledKlaus end,
            Check       = function(data) return data and data.numKilledKlaus and data.numKilledKlaus > 0 or false end,
        },
        {
            index       = 23,
            name        = "rageklaus",
            Record      = function(data) return data and data.numKilledEnragedKlaus end,
            Check       = function(data) return data and data.numKilledEnragedKlaus and data.numKilledEnragedKlaus > 0 or false end,
            isHidden    = true,
            allBossesExcluded = true,
        },
        {
            index       = 24,
            name        = "twinsofterror",
            Record      = function(data) return data and data.numKilledTwinsOfTerror end,
            Check       = function(data) return data and data.numKilledTwinsOfTerror and data.numKilledTwinsOfTerror > 0 or false end,
        },
    }

    local trophyNames = {}

    for _,v in pairs(boss_data) do
        if trophyNames[v.trophyName] == nil  then
            trophyNames[v.trophyName] = true
            table.insert(entries,
                {
                    index       = v.index,
                    name        = v.trophyName,
                    Record      = function(data) return data and data[v.varName] end,
                    Check       = function(data) return data and data[v.varName] and data[v.varName] > 0 or false end,
                })
        end
    end

    table.sort(entries, function(a, b)
        local x = a.index or 999
        local y = b.index or 999
        return x < y
    end)

    -- GetNumCompletedTrophy(data)
    -- @return (numDone, maxNum)
    local function GetNumCompletedTrophy(entries, data)
        local numDone = 0
        local maxNum  = 0
        for _,entry in ipairs(entries) do
            if entry.allBossesExcluded ~= true and entry.Check then
                if entry.Check(data) then
                    numDone = numDone + 1
                end
                maxNum = maxNum + 1
            end
        end

        return numDone, maxNum
    end

    table.insert(entries,
        {
            allBossesExcluded = true,
            name        = "allbosses",
            Record      =
                function(data)
                    local numDone, maxNum = GetNumCompletedTrophy(entries, data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumCompletedTrophy(entries, data)
                    return numDone == maxNum
                end,
        })

    local category = {}
    for k,v in pairs(entries) do
        print(modName, "RegisterBossAchievementEntries()", k, v)
        category[k] = v
    end

    print(modName, "RegisterBossAchievementEntries()", categoryName)
    root[categoryName] = category
end
