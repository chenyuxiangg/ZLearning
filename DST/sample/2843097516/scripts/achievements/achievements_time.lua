require("kaachievement_utils/utils")

local modName = "kaAchievement"
local categoryName = "Time"

local variables =
{
    numSurvivedDayBase = -1,
    numSurvivedNight   = 0,
    numSurvivedDay     = 0,
    numSpoiledPowcake  = 0,
}

local function SetupPlayerFunctions(player)
    local manager = player.components.kaAchievementManager

    -- Register the variables.
    for k,v in pairs(variables) do
        manager:RegisterVariable(k, v)
    end

    player:ListenForEvent("ka_SurvivedNight", function()
        manager.numSurvivedNight = manager.numSurvivedNight + 1
        manager:DoAchieve({category=categoryName, name="firstnight"}, {"numSurvivedNight"})
    end)

    player:ListenForEvent("ka_SurvivedDay", function()
        if manager.numSurvivedDayBase == -1 then
            manager.numSurvivedDayBase = player.components.age:GetAgeInDays()
        else
            manager.numSurvivedDay = player.components.age:GetAgeInDays() - manager.numSurvivedDayBase
        end
        manager:DoAchieve({category=categoryName, name="twenty"}, {"numSurvivedDay"})
        manager:DoAchieve({category=categoryName, name="thirtyfive"}, {})
        manager:DoAchieve({category=categoryName, name="fiftyfive"}, {})
        manager:DoAchieve({category=categoryName, name="onehundred"}, {})
        manager:DoAchieve({category=categoryName, name="fivehundred"}, {})
        manager:DoAchieve({category=categoryName, name="onethousand"}, {})
    end)

    player:ListenForEvent("ka_SpoiledPowcake", function()
        manager.numSpoiledPowcake = manager.numSpoiledPowcake + 1
        manager:DoAchieve({category=categoryName, name="powcake"}, {"numSpoiledPowcake"})
    end)
end

local function SetupWorldFunctions(world)
    -- Not need to listen for "phasechanged" because we only need to check on the beginning of the day.
    world:ListenForEvent("cycleschanged", function(src, cycles)
        local clock_save = world.net.components.clock:OnSave()
        if clock_save and clock_save.segs.night > 0 then
            for i,v in pairs(AllPlayers) do
                if not IsEntityDeadOrGhost(v) then
                    v:PushEvent("ka_SurvivedNight")
                end
            end
        end

        for i,v in pairs(AllPlayers) do
            v:PushEvent("ka_SurvivedDay")
        end
    end)
end

local function SetupPowcakeFunctions(powcake)
    powcake:ListenForEvent("perished", function()
        local x,y,z = powcake.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, TUNING.KAACHIEVEMENT.TIME.BROADCAST_RANGE)
        for k,v in pairs(ents) do
            if v:HasTag("player") then
                v:PushEvent("ka_SpoiledPowcake")
            end
        end
    end)
end

-- RegisterTimeAchievements(inst)
function RegisterTimeAchievements(inst)
    if inst:HasTag("player") then
        local player = inst

        -- Register network variable on both server and client sides.
        for k,v in pairs(variables) do
            player.kaAchievementData[k] = net_shortint(player.GUID, k)
        end

        -- Server only.
        if not TheNet:GetIsClient() then
            SetupPlayerFunctions(player)
        end
    end

    if inst.prefab == "world" then
        local world = inst

        -- Server only.
        if not TheNet:GetIsClient() then
            SetupWorldFunctions(world)
        end
    end

    if inst.prefab == "powcake" then
        local powcake = inst

        -- Server only.
        if not TheNet:GetIsClient() then
            SetupPowcakeFunctions(powcake)
        end
    end
end

-- RegisterTimeAchievementEntries(root)
function RegisterTimeAchievementEntries(root)
    local function SingleOrPlural(num, single, plural)
        return num > 1 and plural or single
    end

    local function RecordLabel(var, lower, upper)
        return var and var >= lower and (upper == nil or var < upper) and
            SingleOrPlural(var, STRINGS.ACCOMPLISHMENTS.TIME.GENERIC_LABEL, STRINGS.ACCOMPLISHMENTS.TIME.GENERIC_LABEL_PLURAL) or ""
    end

    local entries =
    {
        {
            name        = "firstnight",
            Record      = function(data) return data.numSurvivedNight end,
            RecordLabel = "",
            Check       = function(data) return data.numSurvivedNight and data.numSurvivedNight > 0 or false end,
        },
        {
            name        = "twenty",
            Record      = function(data) return data.numSurvivedDay end,
            RecordLabel = function(data) return RecordLabel(data.numSurvivedDay, 0, 20) end,
            Check       = function(data) return data.numSurvivedDay and data.numSurvivedDay >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MED or false end,
        },
        {
            name        = "thirtyfive",
            Record      = function(data) return data.numSurvivedDay end,
            RecordLabel = function(data) return RecordLabel(data.numSurvivedDay, 20, 35) end,
            Check       = function(data) return data.numSurvivedDay and data.numSurvivedDay >= 35 or false end,
        },
        {
            name        = "fiftyfive",
            Record      = function(data) return data.numSurvivedDay end,
            RecordLabel = function(data) return RecordLabel(data.numSurvivedDay, 35, 55) end,
            Check       = function(data) return data.numSurvivedDay and data.numSurvivedDay >= 55 or false end,
        },
        {
            name        = "onehundred",
            Record      = function(data) return data.numSurvivedDay end,
            RecordLabel = function(data) return RecordLabel(data.numSurvivedDay, 55, 500) end,
            Check       = function(data) return data.numSurvivedDay and data.numSurvivedDay >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_HUGE or false end,
        },
        {
            name        = "fivehundred",
            Record      = function(data) return data.numSurvivedDay end,
            RecordLabel = function(data) return RecordLabel(data.numSurvivedDay, 500, 1000) end,
            Check       = function(data) return data.numSurvivedDay and data.numSurvivedDay >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDHUGE or false end,
            isHidden    = true,
        },
        {
            name        = "onethousand",
            Record      = function(data) return data.numSurvivedDay end,
            RecordLabel = function(data) return RecordLabel(data.numSurvivedDay, 1000) end,
            Check       = function(data) return data.numSurvivedDay and data.numSurvivedDay >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_SUPERHUGE or false end,
            isHidden    = true,
        },
        {
            name        = "powcake",
            Record      = function(data) return data.numSpoiledPowcake end,
            RecordLabel = "",
            Check       = function(data) return data.numSpoiledPowcake and data.numSpoiledPowcake > 0 or false end,
        },
    }

    local category = {}
    for k,v in pairs(entries) do
        print(modName, "RegisterTimeAchievementEntries()", k, v)
        category[k] = v
    end

    print(modName, "RegisterTimeAchievementEntries()", categoryName)
    root[categoryName] = category
end
