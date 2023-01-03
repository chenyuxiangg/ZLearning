require("kaachievement_utils/utils")

local modName = "kaAchievement"
local categoryName = "Exploration"

local bool_variables =
{
    hasBeenInCavesBiome         = false,
    hasBeenInRuinsBiome         = false,
    hasBeenInArchivesBiome      = false,
    hasBeenInDeciduousBiome     = false,
    hasBeenInMosaicBiome        = false,
    hasBeenInSwampBiome         = false,
    hasBeenInRedMushroomBiome   = false,
    hasBeenInGreenMushroomBiome = false,
    hasBeenInBlueMushroomBiome  = false,
    hasBeenInMoonMushroomBiome  = false,
    hasBeenInAllmushBiome       = false,
    hasBeenInLunarBiome         = false,
    hasBeenInHermitBiome        = false,
    hasBeenInOasisBiome         = false,
    hasBeenInMonkeyBiome        = false,
    hasBeenInWaterlogBiome      = false,
    hasBeenInAtriumBiome        = false,
}

local function IsNearPrefabs(inst, prefabList, radius)
    local x,y,z = inst:GetPosition():Get()
    local ents = TheSim:FindEntities(x,y,z, radius or TUNING.KAACHIEVEMENT.EXPLORATION.BROADCAST_RANGE)
    if type(prefabList) == "string" then prefabList = {prefabList} end
    for k,v in pairs(ents) do
        for _,prefab in pairs(prefabList) do
            if v.prefab == prefab then
                return true
            end
        end
    end
    return false
end

local function IsOnLand(inst)
    return TheWorld.Map:IsVisualGroundAtPoint(inst.Transform:GetWorldPosition())
end

-- SetupPlayerFunctions(player)
local function SetupPlayerFunctions(player)
    local manager = player.components.kaAchievementManager

    -- Register the variables.
    for k,v in pairs(bool_variables) do
        manager:RegisterVariable(k, v)
    end

    player:ListenForEvent("onhop", function(inst)
        player:DoTaskInTime(1, function()
            if IsOnLand(player) then
                if IsNearPrefabs(player, {"hermithouse",
                                          "hermithouse_construction1",
                                          "hermithouse_construction2",
                                          "hermithouse_construction3"}) then
                    manager["hasBeenInHermitBiome"] = true
                    manager:DoAchieve({category=categoryName, name="hermitbiome"}, {"hasBeenInHermitBiome"})
                elseif IsNearPrefabs(player, {"monkeyqueen",
                                              "monkeyisland_portal"}) then
                    manager["hasBeenInMonkeyBiome"] = true
                    manager:DoAchieve({category=categoryName, name="monkeybiome"}, {"hasBeenInMonkeyBiome"})
                end
            end
        end)
    end)

    -- @Note: "changearea" does not guarentee that it's in the correct biome.
    --        There must be some inconsistency in Klei's code.
    player:ListenForEvent("changearea", function(inst, data)
        local id = data and data.id
        if id then
            -- print(modName, "changearea", id)
            if string.find(id, "CaveExitRoom") then     -- caves
                -- Delay some time to show the pop-up animation.
                player:DoTaskInTime(10, function()
                    manager["hasBeenInCavesBiome"] = true
                    manager:DoAchieve({category=categoryName, name="cavesbiome"}, {"hasBeenInCavesBiome"})
                end)
            elseif string.find(id, "Ruined") then       -- ruins
                manager["hasBeenInRuinsBiome"] = true
                manager:DoAchieve({category=categoryName, name="ruinsbiome"}, {"hasBeenInRuinsBiome"})
            elseif string.find(id, "ArchiveMazeRooms") then  -- archive
                manager["hasBeenInArchivesBiome"] = true
                manager:DoAchieve({category=categoryName, name="archivesbiome"}, {"hasBeenInArchivesBiome"})
            elseif string.find(id, "BGDeciduous") then  -- deciduous
                manager["hasBeenInDeciduousBiome"] = true
                manager:DoAchieve({category=categoryName, name="deciduousbiome"}, {"hasBeenInDeciduousBiome"})
            elseif string.find(id, "BGNoise") then      -- mosaic
                manager["hasBeenInMosaicBiome"] = true
                manager:DoAchieve({category=categoryName, name="mosaicbiome"}, {"hasBeenInMosaicBiome"})
            elseif string.find(id, "Marsh") or string.find(id, "Swamp") then  -- swamp
                manager["hasBeenInSwampBiome"] = true
                manager:DoAchieve({category=categoryName, name="swampbiome"}, {"hasBeenInSwampBiome"})
            elseif string.find(id, "RedMush") then      -- red mushroom
                manager["hasBeenInRedMushroomBiome"] = true
                manager:DoAchieve({category=categoryName, name="mushroombiome"}, {"hasBeenInRedMushroomBiome"})
                manager:DoAchieve({category=categoryName, name="allmushbiome"}, {})
            elseif string.find(id, "GreenMush") then    -- green mushroom
                manager["hasBeenInGreenMushroomBiome"] = true
                manager:DoAchieve({category=categoryName, name="mushroombiome"}, {"hasBeenInGreenMushroomBiome"})
                manager:DoAchieve({category=categoryName, name="allmushbiome"}, {})
            elseif string.find(id, "BlueMush") then     -- blue mushroom
                manager["hasBeenInBlueMushroomBiome"] = true
                manager:DoAchieve({category=categoryName, name="mushroombiome"}, {"hasBeenInBlueMushroomBiome"})
                manager:DoAchieve({category=categoryName, name="allmushbiome"}, {})
            elseif string.find(id, "MoonMush") then     -- moonmush
                manager["hasBeenInMoonMushroomBiome"] = true
                manager:DoAchieve({category=categoryName, name="moonmushbiome"}, {"hasBeenInMoonMushroomBiome"})
            elseif string.find(id, "MoonIsland") then   -- luna
                if IsNearPrefabs(player, "moon_fissure") then
                    manager["hasBeenInLunarBiome"] = true
                    manager:DoAchieve({category=categoryName, name="lunarbiome"}, {"hasBeenInLunarBiome"})
                end
            elseif string.find(id, "Hermit") then       -- hermit
                if IsNearPrefabs(player, {"hermithouse", "hermithouse_construction1", "hermithouse_construction2", "hermithouse_construction3"}) then
                    manager["hasBeenInHermitBiome"] = true
                    manager:DoAchieve({category=categoryName, name="hermitbiome"}, {"hasBeenInHermitBiome"})
                end
            elseif string.find(id, "LightningBluffOasis") then  -- oasis
                manager["hasBeenInOasisBiome"] = true
                manager:DoAchieve({category=categoryName, name="oasisbiome"}, {"hasBeenInOasisBiome"})
            elseif string.find(id, "MonkeyIsland") then -- monkey
                if IsNearPrefabs(player, {"monkeyqueen", "monkeyisland_portal"}) then
                    manager["hasBeenInMonkeyBiome"] = true
                    manager:DoAchieve({category=categoryName, name="monkeybiome"}, {"hasBeenInMonkeyBiome"})
                end
            elseif string.find(id, "Atrium") then -- atrium
                if IsNearPrefabs(player, {"atrium_light", "atrium_overgrowth", "atrium_rubble", "atrium_statue", "atrium_gate"}) then
                    manager["hasBeenInAtriumBiome"] = true
                    manager:DoAchieve({category=categoryName, name="atriumbiome"}, {"hasBeenInAtriumBiome"})
                end
            end
        end
    end)

    player:ListenForEvent("onchangecanopyzone", function()
        if IsNearPrefabs(player, {"watertree_pillar"}) then -- "watertree_root", "oceanvine_cocoon", "oceanvine_deco"
            manager["hasBeenInWaterlogBiome"] = true
            manager:DoAchieve({category=categoryName, name="waterlogbiome"}, {"hasBeenInWaterlogBiome"})
        end
    end)
end

-- RegisterXxxxAchievements(inst)
_G[string.format("Register%sAchievements", categoryName)] = function(inst)
    if inst:HasTag("player") then
        local player = inst

        -- Register network variable on both server and client sides.
        for k,v in pairs(bool_variables) do
            player.kaAchievementData[k] = net_bool(player.GUID, k)
        end

        -- Server only.
        if not TheNet:GetIsClient() then
            SetupPlayerFunctions(inst)
        end
    end
end

-- RegisterXxxxAchievementEntries(root)
local registerEntriesFuncName = string.format("Register%sAchievementEntries", categoryName)
_G[registerEntriesFuncName] = function(root)
    local entries =
    {
        {
            name        = "cavesbiome",
            Record      = function(data) return data and data.hasBeenInCavesBiome end,
            Check       = function(data) return data and data.hasBeenInCavesBiome end,
        },
        {
            name        = "ruinsbiome",
            Record      = function(data) return data and data.hasBeenInRuinsBiome end,
            Check       = function(data) return data and data.hasBeenInRuinsBiome end,
        },
        {
            name        = "archivesbiome",
            Record      = function(data) return data and data.hasBeenInArchivesBiome end,
            Check       = function(data) return data and data.hasBeenInArchivesBiome end,
        },
        {
            name        = "deciduousbiome",
            Record      = function(data) return data and data.hasBeenInDeciduousBiome end,
            Check       = function(data) return data and data.hasBeenInDeciduousBiome end,
        },
        {
            name        = "mosaicbiome",
            Record      = function(data) return data and data.hasBeenInMosaicBiome end,
            Check       = function(data) return data and data.hasBeenInMosaicBiome end,
        },
        {
            name        = "swampbiome",
            Record      = function(data) return data and data.hasBeenInSwampBiome end,
            Check       = function(data) return data and data.hasBeenInSwampBiome end,
        },
        {
            name        = "mushroombiome",
            Record      = function(data) return data and data.hasBeenInRedMushroomBiome   or
                                                         data.hasBeenInGreenMushroomBiome or
                                                         data.hasBeenInBlueMushroomBiome  end,
            Check       = function(data) return data and data.hasBeenInRedMushroomBiome   or
                                                         data.hasBeenInGreenMushroomBiome or
                                                         data.hasBeenInBlueMushroomBiome  end,
        },
        {
            name        = "moonmushbiome",
            Record      = function(data) return data and data.hasBeenInMoonMushroomBiome end,
            Check       = function(data) return data and data.hasBeenInMoonMushroomBiome end,
        },
        {
            name        = "allmushbiome",
            Record      =
                function(data)
                    local count = 0
                    if data then
                        count = count + (data.hasBeenInRedMushroomBiome   and 1 or 0)
                        count = count + (data.hasBeenInGreenMushroomBiome and 1 or 0)
                        count = count + (data.hasBeenInBlueMushroomBiome  and 1 or 0)
                    end
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=count, max=3})
                end,
            Check       = function(data) return data and data.hasBeenInRedMushroomBiome   and
                                                         data.hasBeenInGreenMushroomBiome and
                                                         data.hasBeenInBlueMushroomBiome  end,
        },
        {
            name        = "lunarbiome",
            Record      = function(data) return data and data.hasBeenInLunarBiome end,
            Check       = function(data) return data and data.hasBeenInLunarBiome end,
        },
        {
            name        = "hermitbiome",
            Record      = function(data) return data and data.hasBeenInHermitBiome end,
            Check       = function(data) return data and data.hasBeenInHermitBiome end,
        },
        {
            name        = "oasisbiome",
            Record      = function(data) return data and data.hasBeenInOasisBiome end,
            Check       = function(data) return data and data.hasBeenInOasisBiome end,
        },
        {
            name        = "monkeybiome",
            Record      = function(data) return data and data.hasBeenInMonkeyBiome end,
            Check       = function(data) return data and data.hasBeenInMonkeyBiome end,
        },
        {
            name        = "waterlogbiome",
            Record      = function(data) return data and data.hasBeenInWaterlogBiome end,
            Check       = function(data) return data and data.hasBeenInWaterlogBiome end,
        },
        {
            name        = "atriumbiome",
            Record      = function(data) return data and data.hasBeenInAtriumBiome end,
            Check       = function(data) return data and data.hasBeenInAtriumBiome end,
        },
    }

    local category = {}
    for k,v in pairs(entries) do
        print(modName, registerEntriesFuncName, k, v)
        category[k] = v
    end

    print(modName, registerEntriesFuncName, categoryName)
    root[categoryName] = category
end
