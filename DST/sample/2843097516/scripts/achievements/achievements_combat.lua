require("kaachievement_utils/utils")

local modName = "kaAchievement"
local categoryName = "Combat"

-- OnKilledOther(player)
local function OnKilledOther(player)
    print(modName, "OnKilledOther()")

    local manager = player.components.kaAchievementManager

    -- Register a variable.
    manager:RegisterVariable("numKilledHound", 0)
    manager:RegisterVariable("numKilledWorm", 0)
    manager:RegisterVariable("numKilledPigman", 0)
    manager:RegisterVariable("numKilledBunnyman", 0)
    manager:RegisterVariable("numKilledKrampus", 0)
    manager:RegisterVariable("numKilledRocky", 0)
    manager:RegisterVariable("numKilledGhost", 0)
    manager:RegisterVariable("numKilledShark", 0)
    manager:RegisterVariable("numDartKilledWalrus", 0)

    -- Register an event callback function.
    player:ListenForEvent("killed", function(player, data)
        local victim = data.victim

        print(modName, "ListenForEvent(): killed", player, victim)

        if victim then
            local stackCount = victim.components.stackable and victim.components.stackable:StackSize() or 1

            -- Any hound is killed, increment numKilledHound.
            if victim:HasTag("hound") then
                manager.numKilledHound = manager.numKilledHound + stackCount
                manager:DoAchieve({category=categoryName, name="hound"}, {"numKilledHound"})
            end

            -- Any worm is killed, increment numKilledWorm.
            if victim:HasTag("worm") then
                manager.numKilledWorm = manager.numKilledWorm + stackCount
                manager:DoAchieve({category=categoryName, name="worm"}, {"numKilledWorm"})
            end

            -- Any pigman is killed, increment numKilledPigman.
            if victim:HasTag("pig") and not victim:HasTag("manrabbit") then
                manager.numKilledPigman = manager.numKilledPigman + stackCount
                manager:DoAchieve({category=categoryName, name="pigman"}, {"numKilledPigman"})
            end

            -- Any bunnyman is killed, increment numKilledBunnyman.
            if victim:HasTag("manrabbit") then
                manager.numKilledBunnyman = manager.numKilledBunnyman + stackCount
                manager:DoAchieve({category=categoryName, name="bunnyman"}, {"numKilledBunnyman"})
            end

            -- Any krampus is killed, increment numKilledKrampus.
            if victim.prefab == "krampus" then
                manager.numKilledKrampus = manager.numKilledKrampus + stackCount
                manager:DoAchieve({category=categoryName, name="krampus"}, {"numKilledKrampus"})
            end

            -- Any rocky is killed, increment numKilledRocky.
            if victim:HasTag("rocky") then
                manager.numKilledRocky = manager.numKilledRocky + stackCount
                manager:DoAchieve({category=categoryName, name="rocky"}, {"numKilledRocky"})
            end

            -- Any ghost is killed at night, increment numKilledGhost.
            if victim:HasTag("ghost") and TheWorld.state.isfullmoon then
                manager.numKilledGhost = manager.numKilledGhost + stackCount
                manager:DoAchieve({category=categoryName, name="ghost"}, {"numKilledGhost"})
            end

            -- Any shark is killed, increment numKilledShark.
            if victim:HasTag("shark") then
                manager.numKilledShark = manager.numKilledShark + stackCount
                manager:DoAchieve({category=categoryName, name="shark"}, {"numKilledShark"})
            end
        end
    end)

    player:ListenForEvent("ka_KilledOther", function(player, data)
        local victim = data.victim
        local weapon = data.weapon

        if victim then
            if victim.prefab == "walrus" and weapon and weapon.prefab == "blowdart_pipe" then
                manager.numDartKilledWalrus = manager.numDartKilledWalrus + 1
                manager:DoAchieve({category=categoryName, name="walrusdart"}, {"numDartKilledWalrus"})
            end
        end
    end)
end

-- RegisterCombatAchievements(inst)
function RegisterCombatAchievements(inst)
    if inst:HasTag("player") then
        local player = inst

        -- Register network variable on both server and client sides.
        player.kaAchievementData.numKilledHound = net_shortint(player.GUID, "numKilledHound")
        player.kaAchievementData.numKilledWorm = net_shortint(player.GUID, "numKilledWorm")
        player.kaAchievementData.numKilledPigman = net_shortint(player.GUID, "numKilledPigman")
        player.kaAchievementData.numKilledBunnyman = net_shortint(player.GUID, "numKilledBunnyman")
        player.kaAchievementData.numKilledKrampus = net_shortint(player.GUID, "numKilledKrampus")
        player.kaAchievementData.numKilledRocky = net_shortint(player.GUID, "numKilledRocky")
        player.kaAchievementData.numKilledGhost = net_shortint(player.GUID, "numKilledGhost")
        player.kaAchievementData.numKilledShark = net_shortint(player.GUID, "numKilledShark")
        player.kaAchievementData.numDartKilledWalrus = net_shortint(player.GUID, "numDartKilledWalrus")

        -- Server only.
        if not TheNet:GetIsClient() then
            OnKilledOther(player)
        end
    end

    if inst.prefab == "walrus" then
        inst:ListenForEvent("attacked", function(inst, data)
            if inst.components.health and inst.components.health:IsDead() and data.attacker then
                data.victim = inst
                data.attacker:PushEvent("ka_KilledOther", data)
            end
        end)
    end
end

-- RegisterCombatAchievementEntries(root)
function RegisterCombatAchievementEntries(root)
    local entries =
    {
        -- Houndmaster
        {
            name        = "hound",
            Record      = function(data) return data and data.numKilledHound end,
            Check       = function(data) return data and data.numKilledHound and data.numKilledHound >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_HUGE or false end,
        },
        -- Worms Armageddon
        {
            name        = "worm",
            Record      = function(data) return data and data.numKilledWorm end,
            Check       = function(data) return data and data.numKilledWorm and data.numKilledWorm >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_HUGE or false end,
        },
        -- Slaughterhouse
        {
            name        = "pigman",
            Record      = function(data) return data and data.numKilledPigman end,
            Check       = function(data) return data and data.numKilledPigman and data.numKilledPigman >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE or false end,
        },
        -- Hop! Hop! Hop!
        {
            name        = "bunnyman",
            Record      = function(data) return data and data.numKilledBunnyman end,
            Check       = function(data) return data and data.numKilledBunnyman and data.numKilledBunnyman >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE or false end,
        },
        -- Naughty And Nice
        {
            name        = "krampus",
            Record      = function(data) return data and data.numKilledKrampus end,
            Check       = function(data) return data and data.numKilledKrampus and data.numKilledKrampus >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDSMALL or false end,
        },
        -- It's Not A Rock!
        {
            name        = "rocky",
            Record      = function(data) return data and data.numKilledRocky end,
            Check       = function(data) return data and data.numKilledRocky and data.numKilledRocky >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_SMALL or false end,
        },
        -- Phasmophobia
        {
            name        = "ghost",
            Record      = function(data) return data and data.numKilledGhost end,
            RecordLabel = "",
            Check       = function(data) return data and data.numKilledGhost and data.numKilledGhost >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_TINY or false end,
        },
        -- Maneater
        {
            name        = "shark",
            Record      = function(data) return data and data.numKilledShark end,
            RecordLabel = "",
            Check       = function(data) return data and data.numKilledShark and data.numKilledShark >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_TINY or false end,
        },
        -- Back To You, Friend
        {
            name        = "walrusdart",
            Record      = function(data) return data and data.numDartKilledWalrus end,
            RecordLabel = "",
            Check       = function(data) return data and data.numDartKilledWalrus and data.numDartKilledWalrus >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_TINY or false end,
        },
    }

    local category = {}
    for k,v in pairs(entries) do
        print(modName, "RegisterCombatAchievementEntries()", k, v)
        category[k] = v
    end

    print(modName, "RegisterCombatAchievementEntries()", categoryName)
    root[categoryName] = category
end
