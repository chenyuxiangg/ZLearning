require("kaachievement_utils/utils")

local modName = "kaAchievement"
local categoryName = "Hunt"

local variables =
{
    numKilledBeast       = 0,
    numKilledKoalaSummer = 0,
    numKilledKoalaWinter = 0,
    numKilledWarg        = 0,
    numKilledSpat        = 0,
    numKilledGoat        = 0,
    numEscapedPhlegm     = 0,
}

-- function IsBeast(inst)
local function IsBeast(inst)
    local beast_list =
    {
        koalefant_summer = true,
        koalefant_winter = true,
        warg             = true,
        spat             = true,
        lightninggoat    = true,
    }
    return beast_list[inst.prefab] and true or false
end

-- SetupPlayerFunctions(player)
local function SetupPlayerFunctions(player)
    local manager = player.components.kaAchievementManager

    -- Register the variables.
    for k,v in pairs(variables) do
        manager:RegisterVariable(k, v)
    end

    -- Register an event callback function.
    player:ListenForEvent("killed", function(player, data)
        local victim = data.victim

        -- Any victim is killed, increment numKilledBeast.
        if victim then
            local stackCount = victim.components.stackable and victim.components.stackable:StackSize() or 1

            if victim:HasTag("beast") then
                manager.numKilledBeast = manager.numKilledBeast + stackCount
                manager:DoAchieve({category=categoryName, name="generic"}, {"numKilledBeast"})
                manager:DoAchieve({category=categoryName, name="greathunter"}, {})

                print(modName, "ListenForEvent(): killed beast", player, victim)
            end

            if victim.prefab == "koalefant_summer" then
                manager.numKilledKoalaSummer = manager.numKilledKoalaSummer + stackCount
                manager:DoAchieve({category=categoryName, name="koalefantsummer"}, {"numKilledKoalaSummer"})
            elseif victim.prefab == "koalefant_winter" then
                manager.numKilledKoalaWinter = manager.numKilledKoalaWinter + stackCount
                manager:DoAchieve({category=categoryName, name="koalefantwinter"}, {"numKilledKoalaWinter"})
            elseif victim.prefab == "warg" then
                manager.numKilledWarg = manager.numKilledWarg + stackCount
                manager:DoAchieve({category=categoryName, name="warg"}, {"numKilledWarg"})
            elseif victim.prefab == "spat" then
                manager.numKilledSpat = manager.numKilledSpat + stackCount
                manager:DoAchieve({category=categoryName, name="spat"}, {"numKilledSpat"})
            elseif victim.prefab == "lightninggoat" then
                manager.numKilledGoat = manager.numKilledGoat + stackCount
                manager:DoAchieve({category=categoryName, name="lightninggoat"}, {"numKilledGoat"})
            end

            manager:DoAchieve({category=categoryName, name="allhunt"}, {})
        end
    end)

    -- Adai: Is "pinnable" component or "unpinned" event only used for phlegm?
    player:ListenForEvent("unpinned", function()
        manager.numEscapedPhlegm = manager.numEscapedPhlegm + 1
        manager:DoAchieve({category=categoryName, name="phlegm"}, {"numEscapedPhlegm"})
        manager:DoAchieve({category=categoryName, name="allhunt"}, {})
    end)
end

-- RegisterXxxxAchievements(inst)
_G[string.format("Register%sAchievements", categoryName)] = function(inst)
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

    if IsBeast(inst) then
        inst:AddTag("beast")
    end
end

-- RegisterXxxxAchievementEntries(root)
local registerEntriesFuncName = string.format("Register%sAchievementEntries", categoryName)
_G[registerEntriesFuncName] = function(root)
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
            name        = "generic",
            Record      = function(data) return data.numKilledBeast end,
            RecordLabel = function(data) return RecordLabel(data.numKilledBeast,
                                                            0,
                                                            10,
                                                            STRINGS.ACCOMPLISHMENTS.HUNT.GENERIC_LABEL,
                                                            STRINGS.ACCOMPLISHMENTS.HUNT.GENERIC_LABEL) end,
            Check       = function(data) return data.numKilledBeast and data.numKilledBeast >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDSMALL or false end,
        },
        {
            name        = "greathunter",
            Record      = function(data) return data.numKilledBeast end,
            RecordLabel = function(data) return RecordLabel(data.numKilledBeast,
                                                            10,
                                                            nil,
                                                            STRINGS.ACCOMPLISHMENTS.HUNT.GENERIC_LABEL,
                                                            STRINGS.ACCOMPLISHMENTS.HUNT.GENERIC_LABEL) end,
            Check       = function(data) return data.numKilledBeast and data.numKilledBeast >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MED or false end,
        },
        {
            name        = "koalefantsummer",
            Record      = function(data) return data.numKilledKoalaSummer end,
            RecordLabel = "",
            Check       = function(data) return data.numKilledKoalaSummer and data.numKilledKoalaSummer > 0 or false end,
        },
        {
            name        = "koalefantwinter",
            Record      = function(data) return data.numKilledKoalaWinter end,
            RecordLabel = "",
            Check       = function(data) return data.numKilledKoalaWinter and data.numKilledKoalaWinter > 0 or false end,
        },
        {
            name        = "warg",
            Record      = function(data) return data.numKilledWarg end,
            RecordLabel = "",
            Check       = function(data) return data.numKilledWarg and data.numKilledWarg > 0 or false end,
        },
        {
            name        = "spat",
            Record      = function(data) return data.numKilledSpat end,
            RecordLabel = "",
            Check       = function(data) return data.numKilledSpat and data.numKilledSpat > 0 or false end,
        },
        {
            name        = "lightninggoat",
            Record      = function(data) return data.numKilledGoat end,
            RecordLabel = "",
            Check       = function(data) return data.numKilledGoat and data.numKilledGoat > 0 or false end,
        },
        {
            name        = "phlegm",
            Record      = function(data) return data.numEscapedPhlegm end,
            RecordLabel = "",
            Check       = function(data) return data.numEscapedPhlegm and data.numEscapedPhlegm > 0 or false end,
        },
        {
            name        = "allhunt",
            Record      =
                function(data)
                    local numDone = (data.numKilledKoalaSummer > 0 and 1 or 0) +
                                    (data.numKilledKoalaWinter > 0 and 1 or 0) +
                                    (data.numKilledWarg > 0 and 1 or 0) +
                                    (data.numKilledSpat > 0 and 1 or 0) +
                                    (data.numKilledGoat > 0 and 1 or 0)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=5})
                end,
            Check       =
                function(data)
                    return ((data.numKilledKoalaSummer > 0 and 1 or 0) +
                            (data.numKilledKoalaWinter > 0 and 1 or 0) +
                            (data.numKilledWarg > 0 and 1 or 0) +
                            (data.numKilledSpat > 0 and 1 or 0) +
                            (data.numKilledGoat > 0 and 1 or 0)) == 5
                end,
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
