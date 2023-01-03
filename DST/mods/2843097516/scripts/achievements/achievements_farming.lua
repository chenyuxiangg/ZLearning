require("kaachievement_utils/utils")

local modName = "kaAchievement"
local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS
local FERTILIZER_DEFS = require("prefabs/fertilizer_nutrient_defs").FERTILIZER_DEFS
local categoryName = "Farming"

local variables =
{
    numTilled             = 0,
    numHammeredRottenCrop = 0,
}

local bool_variables =
{
    hasGrownCrop      = false,
    hasGrownGiantCrop = false,
    hasBeenSnared     = false,
}

local function GetSeedVarName(productName)
    return string.format("numPlanted%sSeed", FirstToUpper(string.lower(productName)))
end

local function GetFertVarName(prefab)
    return string.format("numUsedFert_%s", prefab)
end

for k,v in pairs(PLANT_DEFS) do
    variables[GetSeedVarName(k == "randomseed" and "random" or k)] = 0
end

for k,v in pairs(FERTILIZER_DEFS) do
    bool_variables[GetFertVarName(k)] = false
end

-- SetupPlayerFunctions(player)
local function SetupPlayerFunctions(player)
    local manager = player.components.kaAchievementManager

    -- Register the variables.
    for k,v in pairs(variables) do
        manager:RegisterVariable(k, v)
    end

    for k,v in pairs(bool_variables) do
        manager:RegisterVariable(k, v)
    end

    -- Adai: Could be used for pinecone, birchnut, or toothtrap
    --[[
    -- Event "deployitem"
    local function ondeployitem(src, data)
        dumptable(data)
    end

    -- deployer:PushEvent("deployitem", { prefab = self.inst.prefab })
    player:ListenForEvent("deployitem", ondeployitem)
    --]]

    -- doer:PushEvent("ka_UsedFertilizer", {inst=inst,final_use=final_use,doer=doer,target=target})
    player:ListenForEvent("ka_UsedFertilizer", function(inst, data)
        if data and data.inst and data.inst.prefab then
            local varName = GetFertVarName(data.inst.GetFertilizerKey and data.inst:GetFertilizerKey() or data.inst.prefab)
            if not manager[varName] then
                manager[varName] = true
                manager:DoAchieve({category=categoryName, name="fertilizerall"}, {varName})
            end
        end
    end)

    -- picker:PushEvent("picksomething", { object = self.inst, loot = loot })
    player:ListenForEvent("picksomething", function(inst, data)
        local function IsPlantRotten(inst)
            local plantregistryinfo = inst.plant_def.plantregistryinfo
            if plantregistryinfo == nil then
                return nil
            end
            local research_stage = inst:GetResearchStage()
            local research_stage_info = plantregistryinfo[research_stage]

            if research_stage_info == nil then
                return nil
            end

            return research_stage_info and research_stage_info.is_rotten
        end

        local plant = data.object
        if plant and plant:HasTag("farm_plant") and plant.plant_def ~= nil then
            if not IsPlantRotten(plant) then
                if not manager.hasGrownCrop then
                    manager.hasGrownCrop = true
                    manager:DoAchieve({category=categoryName, name="growcrop"}, {"hasGrownCrop"})
                end

                local oversized = plant.is_oversized
                if oversized and not manager.hasGrownGiantCrop then
                    manager.hasGrownGiantCrop = true
                    manager:DoAchieve({category=categoryName, name="growgiantcrop"}, {"hasGrownGiantCrop"})
                end
            end
        end
    end)

    -- doer:PushEvent("tilling")
    player:ListenForEvent("tilling", function(inst)
        manager.numTilled = manager.numTilled + 1
        manager:DoAchieve({category=categoryName, name="tilling"}, {"numTilled"})
        manager:DoAchieve({category=categoryName, name="tilling2"}, {})
    end)

    -- target:PushEvent("snared", { attacker = inst, announce = "ANNOUNCE_SNARED_IVY" })
    player:ListenForEvent("snared", function(inst, data)
        if not manager.hasBeenSnared and data.attacker and data.attacker.prefab == "weed_ivy" then
            manager.hasBeenSnared = true
            manager:DoAchieve({category=categoryName, name="killweed"}, {"hasBeenSnared"})
        end
    end)

    player:ListenForEvent("ka_HammerRottenCrop", function()
        manager.numHammeredRottenCrop = manager.numHammeredRottenCrop + 1
        manager:DoAchieve({category=categoryName, name="rotcrop"}, {"numHammeredRottenCrop"})
    end)
end

-- SetupFarmPlantFunctions(inst)
local function SetupFarmPlantFunctions(inst)
    local seed = inst

    local function onplanted(src, data)
        if data.doer then
            local player = data.doer

            -- Any seed is planted, increment numPlantedXxxxSeeds.
            if player and player:HasTag("player") then
                local manager = player.components.kaAchievementManager
                if manager then
                    local product = seed.plant_def and seed.plant_def.product or "random"
                    local varName = GetSeedVarName(product)
                    if manager[varName] then
                        manager[varName] = manager[varName] + 1
                        manager:DoAchieve({category=categoryName, name="sowall"}, {varName})
                    end
                end
            end
        end
    end

    -- plant:PushEvent("on_planted", { doer = planter, seed = self.inst, in_soil = true })
    seed:ListenForEvent("on_planted", onplanted)
end

-- IsFertilizer(inst)
local function IsFertilizer(inst)
    return inst:HasTag("fertilizerresearchable")
end

-- SetupFertilizerFunctions(inst)
local function SetupFertilizerFunctions(inst)
    local fertilizer = inst.components.fertilizer
    if fertilizer then
        -- self.onappliedfn(self.inst, final_use, doer, target)
        local old_onappliedfn = fertilizer.onappliedfn
        fertilizer.onappliedfn = function(inst, final_use, doer, target)
            if old_onappliedfn then old_onappliedfn(inst, final_use, doer, target) end
            if doer and doer:HasTag("player") then
                doer:PushEvent("ka_UsedFertilizer", {inst=inst,final_use=final_use,doer=doer,target=target})
            end
        end
    end
end

-- SetupOversizedVeggieFunctions(inst)
local function SetupOversizedVeggieFunctions(inst)
    if inst.components.inspectable.nameoverride == "VEGGIE_OVERSIZED_ROTTEN" then
        local workable = inst.components.workable
        if workable then
            local _onfinish = workable.onfinish
            workable.onfinish = function(inst, doer)
                if _onfinish ~= nil then _onfinish(inst, doer) end
                if doer and doer:HasTag("player") then
                    doer:PushEvent("ka_HammerRottenCrop")
                end
            end
        end
    end
end

-- RegisterXxxxAchievements(inst)
_G[string.format("Register%sAchievements", categoryName)] = function(inst)
    if inst:HasTag("player") then
        local player = inst

        -- Register network variable on both server and client sides.
        for k,v in pairs(variables) do
            player.kaAchievementData[k] = net_shortint(player.GUID, k)
        end

        for k,v in pairs(bool_variables) do
            player.kaAchievementData[k] = net_bool(player.GUID, k)
        end

        -- Server only.
        if not TheNet:GetIsClient() then
            SetupPlayerFunctions(player)
        end
    elseif inst:HasTag("farm_plant") then
        -- Server only.
        if not TheNet:GetIsClient() then
            SetupFarmPlantFunctions(inst)
        end
    end

    -- Server only.
    if not TheNet:GetIsClient() then
        if IsFertilizer(inst) then
            SetupFertilizerFunctions(inst)
        elseif inst:HasTag("oversized_veggie") then
            SetupOversizedVeggieFunctions(inst)
        end
    end
end

-- RegisterXxxxAchievementEntries(root)
local registerEntriesFuncName = string.format("Register%sAchievementEntries", categoryName)
_G[registerEntriesFuncName] = function(root)

    -- GetNumTypeOfSeedsPlanted(data)
    local function GetNumTypeOfSeedsPlanted(data)
        return KaGetNumDone(PLANT_DEFS, function(k, v)
            local varName = GetSeedVarName(k == "randomseed" and "random" or k)
            return data[varName] and data[varName] > 0
        end)
    end

    -- GetNumTypeOfFertsUsed(data)
    local function GetNumTypeOfFertsUsed(data)
        return KaGetNumDone(FERTILIZER_DEFS, function(k, v)
            return data[GetFertVarName(k)] == true
        end)
    end

    local function SingleOrPlural(num, single, plural)
        return num > 1 and plural or single
    end

    local function RecordLabel(var, lower, upper, singular, plural)
        return var and var >= lower and (upper == nil or var < upper) and
            SingleOrPlural(var, singular, plural) or ""
    end

    local entries =
    {
        {
            name        = "sowall",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumTypeOfSeedsPlanted(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumTypeOfSeedsPlanted(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumTypeOfSeedsPlanted(data)
                    return numDone == maxNum
                end,
        },
        {
            name        = "fertilizerall",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumTypeOfFertsUsed(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumTypeOfFertsUsed(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumTypeOfFertsUsed(data)
                    return numDone == maxNum
                end,
        },
        {
            name        = "growcrop",
            Record      = function(data) return data and data.hasGrownCrop end,
            Check       = function(data) return data and data.hasGrownCrop or false end,
        },
        {
            name        = "growgiantcrop",
            Record      = function(data) return data and data.hasGrownGiantCrop end,
            Check       = function(data) return data and data.hasGrownGiantCrop or false end,
        },
        {
            name        = "rotcrop",
            Record      = function(data) return data and data.numHammeredRottenCrop end,
            Check       = function(data) return data and data.numHammeredRottenCrop and data.numHammeredRottenCrop >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDSMALL or false end,
            isHidden    = true,
        },
        {
            name        = "tilling",
            Record      = function(data) return data and data.numTilled end,
            RecordLabel = function(data) return RecordLabel(data.numTilled,
                                                            0,
                                                            200,
                                                            STRINGS.ACCOMPLISHMENTS.FARMING.TILLING_LABEL,
                                                            STRINGS.ACCOMPLISHMENTS.FARMING.TILLING_LABEL_PLURAL) end,
            Check       = function(data) return data and data.numTilled and data.numTilled >= 200 or false end,
        },
        {
            name        = "tilling2",
            Record      = function(data) return data and data.numTilled end,
            RecordLabel = function(data) return RecordLabel(data.numTilled,
                                                            200,
                                                            nil,
                                                            STRINGS.ACCOMPLISHMENTS.FARMING.TILLING_LABEL,
                                                            STRINGS.ACCOMPLISHMENTS.FARMING.TILLING_LABEL_PLURAL) end,
            Check       = function(data) return data and data.numTilled and data.numTilled >= 400 or false end,
        },
        {
            name        = "killweed",
            Record      = function(data) return data and data.hasBeenSnared end,
            Check       = function(data) return data and data.hasBeenSnared or false end,
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
