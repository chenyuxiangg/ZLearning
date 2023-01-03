local modName = "KaAchievement"
local _G = GLOBAL
local TheNet = _G.TheNet

require("kaachievement_utils/utils")

-- function ka_resettrophy(player, category, name)
-- Reset trophies for the player
-- Example 1: ka_resettrophy(ThePlayer)                       -- Reset all trophies
-- Example 2: ka_resettrophy(ThePlayer, "Food")               -- Reset all trophies in the "Food" category
-- Example 3: ka_resettrophy(ThePlayer, "Food", "generic")
-- Example 4: ka_resettrophy(ThePlayer, "Combat", "bunnyman")
_G.ka_resettrophy = function(player, category, name)
    player = player or _G.ConsoleCommandPlayer()
    local manager = player.components.kaAchievementManager
    if manager then
        if name == nil then
            for category_name,category_entries in pairs(_G.GetKaAchievementLoader().entries) do
                if category == nil or category == category_name then
                    for _,v in ipairs(category_entries) do
                        if v.name then
                            manager:DebugReset(_G.GetCompletedVarName(category_name, v.name))
                        end
                    end
                end
            end
        else
            manager:DebugReset(_G.GetCompletedVarName(category, name))
        end
    end
end

-- function ka_resetvar(player, varName)
-- Example 1: ka_resetvar(ThePlayer)                          -- Reset all registered variables
-- Example 2: ka_resetvar(ThePlayer, "numEatenFood")
_G.ka_resetvar = function(player, varName)
    player = player or _G.ConsoleCommandPlayer()
    local manager = player.components.kaAchievementManager
    if manager then
        if varName == nil then
            for k,v in pairs(manager.initVals) do
                manager:DebugReset(k)
            end
        else
            manager:DebugReset(varName)
        end

        -- Update trophy status
        manager:DoAchieve()
    end
end

-- function ka_setvar(player, varName, value)
-- Example 1: ka_setvar(ThePlayer, "numEatenFood", 0)
-- Example 2: ka_setvar(ThePlayer, "completed_Food_generic", nil)
_G.ka_setvar = function(player, varName, value)
    player = player or _G.ConsoleCommandPlayer()
    local manager = player.components.kaAchievementManager
    if manager then
        manager:DebugSet(varName, value)

        -- Update trophy status
        manager:DoAchieve()
    end
end

-- function ka_pushnotif(player, category, name)
-- Example 1: ka_pushnotif(ThePlayer, "Food", "generic")
_G.ka_pushnotif = function(player, category, name)
    player = player or _G.ConsoleCommandPlayer()
    SendModRPCToClient(GetClientModRPC(modName, "ClientPopUp"), player and player.userid or _G.ThePlayer.userid, category, name)
end

-- Unlock all boss trophy
_G.ka_unlockallbosstrophy = function(player)
    player = player or _G.ConsoleCommandPlayer()
    local manager = player.components.kaAchievementManager
    if manager then
        local variables =
        {
            "numKilledDeerclopsYule",
            "numKilledTwinsOfTerror",
            "numKilledShadowChess",
            "numKilledDeerclops",
            "numKilledMoose",
            "numKilledDragonfly",
            "numKilledMalbatross",
            "numKilledKlaus",
            "numKilledMinotaur",
            "numKilledBearger",
            "numKilledBeequeen",
            "numKilledAntlion",
            "numKilledToadstool",
            "numKilledToadstoolMisery",
            "numKilledStalker",
            "numKilledStalkerAtrium",
            "numKilledCrabking",
            "numKilledSpiderqueen",
            "numKilledLeif",
            "numKilledEyeOfTerror",
            "numKilledAlterGuardian",
            "numKilledLordFruitFly",
        }

        local update = false

        for _,v in ipairs(variables) do
            if manager[v] == 0 then
                manager:DebugSet(v, 1)
                update = true
            end
        end

        -- Update trophy status
        if update then
            manager:DoAchieve()
        end
    end
end

-- Unlock all combat trophy
_G.ka_unlockallcombattrophy = function(player)
    player = player or _G.ConsoleCommandPlayer()
    local manager = player.components.kaAchievementManager
    if manager then
        manager:DebugSet("numKilledHound", math.max(manager["numKilledHound"], 100))
        manager:DebugSet("numKilledWorm", math.max(manager["numKilledWorm"], 100))
        manager:DebugSet("numKilledPigman", math.max(manager["numKilledPigman"], 30))
        manager:DebugSet("numKilledBunnyman", math.max(manager["numKilledBunnyman"], 30))
        manager:DebugSet("numKilledKrampus", math.max(manager["numKilledKrampus"], 10))
        manager:DebugSet("numKilledRocky", math.max(manager["numKilledRocky"], 5))
        manager:DebugSet("numKilledGhost", math.max(manager["numKilledGhost"], 1))
        manager:DebugSet("numKilledShark", math.max(manager["numKilledShark"], 1))
        manager:DebugSet("numDartKilledWalrus", math.max(manager["numDartKilledWalrus"], 1))

        -- Update trophy status
        manager:DoAchieve()
    end
end

_G.ka_giveallfood = function(player)
    player = player or _G.ConsoleCommandPlayer()
    local preparedfoods = require("preparedfoods")
    for k,v in pairs(preparedfoods) do
        local inst = _G.DebugSpawn(k)
        if inst ~= nil then
            player.components.inventory:GiveItem(inst)
        end
    end
end

_G.ka_warly1 = function(player, unlock)
    player = player or _G.ConsoleCommandPlayer()
    local manager = player.components.kaAchievementManager
    if manager then
        local preparedfoods = require("preparedfoods")
        for k,v in pairs(preparedfoods) do
            local varName = "hasEaten_" .. k
            manager:DebugSet(varName, unlock == true)
        end

        -- Update trophy status
        manager:DoAchieve()
    end
end

_G.ka_warly2 = function(player, unlock)
    player = player or _G.ConsoleCommandPlayer()
    local manager = player.components.kaAchievementManager
    if manager then
        local preparedfoods_warly = require("preparedfoods_warly")
        for k,v in pairs(preparedfoods_warly) do
            local varName = "hasCookedWarly_" .. k
            manager:DebugSet(varName, unlock == true)
        end

        -- Update trophy status
        manager:DoAchieve()
    end
end

_G.ka_cookbook = function(player, unlock)
    for k,_ in pairs(require("preparedfoods")) do
        _G.ka_setvar(player,"hasCooked_" .. k, unlock)
    end
end

_G.ka_catchfish = function(player, unlock)
    for k,_ in pairs(require("prefabs/oceanfishdef").fish) do
        _G.ka_setvar(player,"hasCaught_" .. k, unlock)
    end
end

-- ka_setvar(ThePlayer, "hasBeenInAtriumBiome", false) ka_setvar(ThePlayer, "hasBeenInAtriumBiome", true)
_G.ka_exploration = function(player, unlock)
    _G.ka_setvar(player, "hasBeenInCavesBiome", unlock)
    _G.ka_setvar(player, "hasBeenInRuinsBiome", unlock)
    _G.ka_setvar(player, "hasBeenInArchivesBiome", unlock)
    _G.ka_setvar(player, "hasBeenInDeciduousBiome", unlock)
    _G.ka_setvar(player, "hasBeenInMosaicBiome", unlock)
    _G.ka_setvar(player, "hasBeenInSwampBiome", unlock)
    _G.ka_setvar(player, "hasBeenInRedMushroomBiome", unlock)
    _G.ka_setvar(player, "hasBeenInGreenMushroomBiome", unlock)
    _G.ka_setvar(player, "hasBeenInBlueMushroomBiome", unlock)
    _G.ka_setvar(player, "hasBeenInMoonMushroomBiome", unlock)
    _G.ka_setvar(player, "hasBeenInAllmushBiome", unlock)
    _G.ka_setvar(player, "hasBeenInLunarBiome", unlock)
    _G.ka_setvar(player, "hasBeenInHermitBiome", unlock)
    _G.ka_setvar(player, "hasBeenInOasisBiome", unlock)
    _G.ka_setvar(player, "hasBeenInMonkeyBiome", unlock)
    _G.ka_setvar(player, "hasBeenInWaterlogBiome", unlock)
    _G.ka_setvar(player, "hasBeenInAtriumBiome", unlock)
end

_G.ka_giveallrelic = function(player)
    player = player or _G.ConsoleCommandPlayer()
    player.components.inventory:GiveItem(_G.DebugSpawn("ruinsrelic_table_blueprint"))
    player.components.inventory:GiveItem(_G.DebugSpawn("ruinsrelic_chair_blueprint"))
    player.components.inventory:GiveItem(_G.DebugSpawn("ruinsrelic_vase_blueprint"))
    player.components.inventory:GiveItem(_G.DebugSpawn("ruinsrelic_plate_blueprint"))
    player.components.inventory:GiveItem(_G.DebugSpawn("ruinsrelic_bowl_blueprint"))
    player.components.inventory:GiveItem(_G.DebugSpawn("ruinsrelic_chipbowl_blueprint"))
end

_G.ka_giveallbooks = function(player)
    player = player or _G.ConsoleCommandPlayer()
    player.components.inventory:GiveItem(_G.DebugSpawn("book_tentacles"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_birds"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_brimstone"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_sleep"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_gardening"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_horticulture"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_silviculture"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_horticulture_upgraded"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_fish"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_fire"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_web"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_temperature"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_light"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_light_upgraded"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_rain"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_moon"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_bees"))
    player.components.inventory:GiveItem(_G.DebugSpawn("book_research_station"))
end

_G.ka_debugservertrophyannounce = function(player, category_name, trophy_name)
    local userid = TheNet:GetUserID()
    player = player or _G.ConsoleCommandPlayer()
    if player and player.userid then
        userid = player.userid
    end

    if userid then
        _G.KaBroadcastAnnounceTrophy(userid, category_name or "Boss", trophy_name or "dragonfly")
    end
end

_G.ka_debugclienttrophyannounce = function(player, category_name, trophy_name)
    local userid = TheNet:GetUserID()
    player = player or _G.ConsoleCommandPlayer()
    if player and player.userid then
        userid = player.userid
    end

    if userid then
        local clientTable = TheNet:GetClientTableForUser(userid)
        local trophy_packet = {userid=userid, category_name=category_name or "Boss", trophy_name=trophy_name or "dragonfly"}
        _G.KaTrophyAnnounce(clientTable.name, clientTable.colour, _G.json.encode(trophy_packet), userid)
    else
        print("ka_debugclienttrophyannounce", "userid == nil")
        print(debugstack())
    end

    -- Networking_SkinAnnouncement(ThePlayer.name, ThePlayer.playercolour, "wilson_formal")
end

_G.ka_testwx781 = function(player, unlock)
    local userid = TheNet:GetUserID()
    player = player or _G.ConsoleCommandPlayer()
    _G.ka_setvar(player, "hasLearned_wx78module_bee", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_cold", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_heat", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_light", false)             -- lightflier
    _G.ka_setvar(player, "hasLearned_wx78module_maxhealth", unlock)        -- spider
    _G.ka_setvar(player, "hasLearned_wx78module_maxhealth2", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_maxhunger", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_maxhunger1", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_maxsanity", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_maxsanity1", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_movespeed", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_movespeed2", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_music", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_nightvision", unlock)
    _G.ka_setvar(player, "hasLearned_wx78module_taser", unlock)

    player.components.inventory:GiveItem(_G.SpawnPrefab("lightflier"))
    player.components.inventory:GiveItem(_G.SpawnPrefab("lightflier"))
end

print(modName, "loaded moddebug.lua successfully.")