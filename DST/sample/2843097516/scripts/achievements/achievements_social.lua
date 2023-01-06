require("kaachievement_utils/utils")

local modName = "kaAchievement"
local categoryName = "Social"

local variables =
{
    numDeath             = 0,
    numMaxOnlinePlayers  = 0,
    numMaxSameCharacters = 0,
    numSoakedPlayer      = 0,
    numGivenToPlayer     = 0,
    numTeamKilledBoss    = 0,
    numRevivedPlayer     = 0,
    hasEquippedAll       = 0,
    numKilledPlayer      = 0,
    numMadeAsleepPlayer  = 0,
}

local bool_variables =
{
    hasDoneEmote     = false,
    hasLitFlare      = false,
    hasPairedCompass = false,
}

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

    -- Register event callback functions.
    -- PushEvent("death", { cause = cause, afflicter = afflicter })
    player:ListenForEvent("death", function(inst, data)
        manager.numDeath = manager.numDeath + 1
        manager:DoAchieve({category=categoryName, name="firstdeath"}, {"numDeath"})
        manager:DoAchieve({category=categoryName, name="tendeath"}, {})
    end)

    local function OnPlayerJoined(src, newPlayer)
        player:DoTaskInTime(1, function()
            local numPlayers        = 0
            local maxSameCharacters = 0
            local characters        = {}
            local DEBUG             = false

            if DEBUG then
                for k,v in pairs(Ents) do
                    -- @Note: Fake players (e.g. c_spawn("wes")) will have empty string userid.
                    -- @Note: Ents only check entities in the same shard.
                    -- if v:HasTag("player") and (v.userid ~= "" and v.userid ~= nil) then
                    if v:HasTag("player") then
                        numPlayers = numPlayers + 1
                        characters[v.prefab] = (characters[v.prefab] or 0) + 1
                        maxSameCharacters = math.max(maxSameCharacters, characters[v.prefab])
                    end
                end
            else
                local clientTable = TheNet:GetClientTable() or {}
                for _,client in ipairs(clientTable) do
                    if (client.performance == nil) or _G.TheNet:GetServerIsClientHosted() then
                        numPlayers = numPlayers + 1
                        print("OnPlayerJoined():", player.name, player.prefab, client.name, client.prefab)
                        if client.prefab ~= "" then
                            characters[client.prefab] = (characters[client.prefab] or 0) + 1
                            maxSameCharacters = math.max(maxSameCharacters, characters[client.prefab])
                        end
                    end
                end
            end

            manager.numMaxOnlinePlayers = math.max(manager.numMaxOnlinePlayers, numPlayers)
            manager:DoAchieve({category=categoryName, name="sixplayers"}, {"numMaxOnlinePlayers"})

            manager.numMaxSameCharacters = math.max(manager.numMaxSameCharacters, maxSameCharacters)
            manager:DoAchieve({category=categoryName, name="samecharacter"}, {"numMaxSameCharacters"})
        end)
    end

    -- @Todo: Check if reroll or despawn will call this event.
    player:ListenForEvent("ms_playerjoined", OnPlayerJoined, TheWorld)

    player:ListenForEvent("ka_SoakedPlayer", function(player, data)
        manager.numSoakedPlayer = manager.numSoakedPlayer + 1
        manager:DoAchieve({category=categoryName, name="soakplayer"}, {"numSoakedPlayer"})
    end)

    local trader = player.components.trader
    if trader then
        local old_onaccept = trader.onaccept
        trader.onaccept = function(inst, giver, item)
            if item ~= nil and giver and giver:HasTag("player") then
                if item.prefab == "reviver" and inst:HasTag("playerghost") then
                    giver:PushEvent("ka_ReveivePlayer", inst)
                else
                    if giver.components.age:GetAgeInDays() >= TUNING.KAACHIEVEMENT.SOCIAL.GIVEPLAYER_GIVER_MIN_AGE and
                       inst.components.age:GetAgeInDays() <= TUNING.KAACHIEVEMENT.SOCIAL.GIVEPLAYER_RECEIVER_MAX_AGE then
                        giver:PushEvent("ka_GivenToPlayer", inst)
                    end
                end
            end

            -- Inb4 the items got removed. The old function should go later.
            old_onaccept(inst, giver, item)
        end
    end

    player:ListenForEvent("ka_ReveivePlayer", function(player, otherplayer)
        manager.numRevivedPlayer = manager.numRevivedPlayer + 1
        manager:DoAchieve({category=categoryName, name="reviveplayer"}, {"numRevivedPlayer"})
    end)

    player:ListenForEvent("ka_GivenToPlayer", function(player, otherplayer)
        manager.numGivenToPlayer = manager.numGivenToPlayer + 1
        manager:DoAchieve({category=categoryName, name="giveplayer"}, {"numGivenToPlayer"})
    end)

    -- Has dependency with boss category
    player:ListenForEvent("ka_TeamKilledBoss", function(player, data)
        manager.numTeamKilledBoss = manager.numTeamKilledBoss + 1
        manager:DoAchieve({category=categoryName, name="bossfriend"}, {"numTeamKilledBoss"})
    end)

    local function CheckEquippedAll(inventory)
        local equippedAll = true
        if inventory and inventory.equipslots then
            for k,v in pairs(EQUIPSLOTS) do
                if inventory.equipslots[v] == nil then
                    equippedAll = false
                    break
                end
            end
        else
            equippedAll = false
        end

        return equippedAll
    end

    -- self.inst:PushEvent("equip", { item = item, eslot = eslot })
    player:ListenForEvent("equip", function(player, data)
        -- Adai: Delay 1 frame to wait for the achievement data be loaded correctly.
        --       Without this the manager would not be ready, and it would think the trophy is just new unlocked.
        player:DoTaskInTime(0, function()
            local inventory = player.components.inventory
            if manager.hasEquippedAll ~= 1 and CheckEquippedAll(inventory) then
                manager.hasEquippedAll = 1
                manager:DoAchieve({category=categoryName, name="equipall"}, {"hasEquippedAll"})
            end
        end)
    end)

    player:ListenForEvent("killed", function(player, data)
        local victim = data.victim
        if victim and victim:HasTag("player") then
            manager.numKilledPlayer = manager.numKilledPlayer + 1
            manager:DoAchieve({category=categoryName, name="killplayer"}, {"numKilledPlayer"})
        end
    end)

    player:ListenForEvent("knockedout", function(player)
        for k,v in pairs(player.mandrake_effecting or {}) do
            local doer = UserToPlayer(k)
            if doer then
                doer:PushEvent("ka_MadeAsleepPlayer", {player=player, cause="mandrake"})
            end
        end
    end)

    player:ListenForEvent("ka_MadeAsleepPlayer", function(player, data)
        manager.numMadeAsleepPlayer = manager.numMadeAsleepPlayer + 1
        manager:DoAchieve({category=categoryName, name="sleepplayer"}, {"numMadeAsleepPlayer"})
    end)

    -- player:PushEvent("emote", emotedef.data)
    player:ListenForEvent("emote", function(inst, data)
        local x,y,z = player.Transform:GetWorldPosition()
        local players = FindPlayersInRange(x, y, z, TUNING.KAACHIEVEMENT.ACTIVITY.DO_EMOTE_RANGE)
        -- Adai: Show "everyone" means at least show to some other players
        if #players >= TUNING.KAACHIEVEMENT.ACTIVITY.DO_EMOTE_PLAYERS then
            manager.hasDoneEmote = true
            manager:DoAchieve({category=categoryName, name="doemote"}, {"hasDoneEmote"})
        end
    end)

    player:ListenForEvent("ka_LightFlare", function(player)
        manager.hasLitFlare = true
        manager:DoAchieve({category=categoryName, name="litflare"}, {"hasLitFlare"})
    end)

    player:ListenForEvent("ka_PairCompass", function(player)
        manager.hasPairedCompass = true
        manager:DoAchieve({category=categoryName, name="holdcompass"}, {"hasPairedCompass"})
    end)
end

-- SetupWaterballoonFunctions(inst)
local function SetupWaterballoonFunctions(inst)
    local complexprojectile = inst.components.complexprojectile
    if complexprojectile then
        local old_onhitfn = complexprojectile.onhitfn
        local function OnHitWater(self, attacker, target)
            old_onhitfn(self, attacker, target)
            local x,y,z = self.Transform:GetWorldPosition()
            local ents = TheSim:FindEntities(x,y,z, 4) -- constant 4, see WateryProtection:SpreadProtectionAtPoint()
            for i, v in ipairs(ents) do
                if v ~= attacker and v:HasTag("player") and (not inst:HasTag("playerghost")) then
                    attacker:PushEvent("ka_SoakedPlayer", v)
                end
            end
        end
        complexprojectile.onhitfn = OnHitWater
    end
end

-- SetupMandrakeFunctions(inst)
local function SetupMandrakeFunctions(inst)
    local SLEEPTARGETS_CANT_TAGS = { "playerghost", "FX", "DECOR", "INLIMBO" }
    local SLEEPTARGETS_ONEOF_TAGS = { "sleeper", "player" }

    -- This is a bad implementation. Should improve if Klei gives the reason of event "knockedout" or "yawn"
    local function doareasleep(inst, range, time)
        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, range, nil, SLEEPTARGETS_CANT_TAGS, SLEEPTARGETS_ONEOF_TAGS)
        local canpvp = not inst:HasTag("player") or TheNet:GetPVPEnabled()
        for i, v in ipairs(ents) do
            if (v == inst or canpvp or not v:HasTag("player")) and
                not (v.components.freezable ~= nil and v.components.freezable:IsFrozen()) and
                not (v.components.pinnable ~= nil and v.components.pinnable:IsStuck()) and
                not (v.components.fossilizable ~= nil and v.components.fossilizable:IsFossilized()) then

                if v ~= inst and v:HasTag("player") then
                    if v.mandrake_effecting == nil then
                        v.mandrake_effecting = {}
                    end
                    v.mandrake_effecting[inst.userid] = os.time()
                    v:DoTaskInTime(3, function()
                        if v.mandrake_effecting and os.time() - v.mandrake_effecting[inst.userid] > 3 then
                            v.mandrake_effecting[inst.userid] = nil
                        end
                    end)

                    -- Just need one, but if don't break, we can count the real number of sleepen players.
                    -- break
                end
            end
        end
    end

    local edible = inst.components.edible
    if edible then
        local old_oneaten = edible.oneaten
        edible.oneaten = function(inst, eater)
            old_oneaten(inst, eater)
            eater:DoTaskInTime(0.5, function()
                doareasleep(eater, TUNING.MANDRAKE_SLEEP_RANGE, TUNING.MANDRAKE_SLEEP_TIME)
            end)
        end
    end

    local cookable = inst.components.cookable
    if cookable then
        local old_oncooked = cookable.oncooked
        cookable.oncooked = function(inst, cooker, chef)
            old_oncooked(inst, cooker, chef)
            chef:DoTaskInTime(0.5, function()
                doareasleep(chef, TUNING.MANDRAKE_SLEEP_RANGE, TUNING.MANDRAKE_SLEEP_TIME)
            end)
        end
    end
end

local function IsHoldingCompass(player)
    local inventory = player.components.inventory
    if inventory then
        for k, v in pairs(inventory.equipslots) do
            if v:HasTag("compass") then
                return true
            end
        end
    end
    return false
end

-- SetupCompassFunctions(inst)
local function SetupCompassFunctions(inst)
    local equippable = inst.components.equippable
    if equippable then
        local _onequipfn = equippable.onequipfn
        equippable.onequipfn = function(inst, owner, from_ground)
            if _onequipfn ~= nil then _onequipfn(inst, owner, from_ground) end

            inst:DoTaskInTime(1, function()
                local players = {}

                for k,v in pairs(Ents) do
                    if v:HasTag("player") and IsHoldingCompass(v) then
                        table.insert(players, v)
                    end
                end

                if #players >= 2 then
                    for _,player in pairs(players) do
                        player:PushEvent("ka_PairCompass")
                    end
                end
            end)
        end
    end
end

local function BroadcastEvent(inst, range, event, data)
    local x,y,z = inst.Transform:GetWorldPosition()
    local players = FindPlayersInRange(x, y, z, range or 30)
    for i,v in ipairs(players) do
        v:PushEvent(event, data)
    end
end

-- SetupFlareFunctions(inst)
local function SetupFlareFunctions(inst)
    -- @Note: Klei didn't put arguments in self:Ignite() in burnable, so we get no doer.
    -- self.inst:PushEvent("onignite", {doer = doer})
    inst:ListenForEvent("onignite", function(inst)
        BroadcastEvent(inst, TUNING.KAACHIEVEMENT.SOCIAL.LIGHT_FLARE_RANGE, "ka_LightFlare")
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

        for k,v in pairs(bool_variables) do
            player.kaAchievementData[k] = net_bool(player.GUID, k)
        end

        -- Server only.
        if not TheNet:GetIsClient() then
            SetupPlayerFunctions(player)
        end
    end

    -- Server only.
    if not TheNet:GetIsClient() then
        if inst.prefab == "waterballoon" then
            SetupWaterballoonFunctions(inst)
        elseif inst.prefab == "mandrake" or inst.prefab == "cookedmandrake" then
            SetupMandrakeFunctions(inst)
        elseif inst:HasTag("compass") then
            SetupCompassFunctions(inst)
        elseif inst.prefab == "miniflare" then
            SetupFlareFunctions(inst)
        end
    end
end

-- RegisterXxxxAchievementEntries(root)
local registerEntriesFuncName = string.format("Register%sAchievementEntries", categoryName)
_G[registerEntriesFuncName] = function(root)
    local entries =
    {
        {
            name        = "firstdeath",
            Record      = function(data) return data.numDeath end,
            Check       = function(data) return data.numDeath and data.numDeath > 0 or false end,
        },
        {
            name        = "tendeath",
            Record      = function(data) return data.numDeath end,
            Check       = function(data) return data.numDeath and data.numDeath >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDSMALL or false end,
        },
        {
            name        = "sixplayers",
            Record      = function(data) return data.numMaxOnlinePlayers end,
            Check       = function(data) return data.numMaxOnlinePlayers and data.numMaxOnlinePlayers >= 6 or false end,
        },
        {
            name        = "samecharacter",
            Record      = function(data) return data.numMaxSameCharacters end,
            Check       = function(data) return data.numMaxSameCharacters and data.numMaxSameCharacters >= 3 or false end,
        },
        {
            name        = "soakplayer",
            Record      = function(data) return data.numSoakedPlayer end,
            Check       = function(data) return data.numSoakedPlayer and data.numSoakedPlayer >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDSMALL or false end,
        },
        {
            name        = "giveplayer",
            Record      = function(data) return data.numGivenToPlayer end,
            Check       = function(data) return data.numGivenToPlayer and data.numGivenToPlayer > 0 or false end,
        },
        {
            name        = "bossfriend",
            Record      = function(data) return data.numTeamKilledBoss end,
            Check       = function(data) return data.numTeamKilledBoss and data.numTeamKilledBoss > 0 or false end,
        },
        {
            name        = "reviveplayer",
            Record      = function(data) return data.numRevivedPlayer end,
            Check       = function(data) return data.numRevivedPlayer and data.numRevivedPlayer > 0 or false end,
        },
        {
            name        = "equipall",
            Record      = function(data) return data.hasEquippedAll end,
            Check       = function(data) return data.hasEquippedAll and data.hasEquippedAll > 0 or false end,
        },
        {
            name        = "killplayer",
            Record      = function(data) return data.numKilledPlayer end,
            Check       = function(data) return data.numKilledPlayer and data.numKilledPlayer > 0 or false end,
        },
        {
            name        = "sleepplayer",
            Record      = function(data) return data.numMadeAsleepPlayer end,
            Check       = function(data) return data.numMadeAsleepPlayer and data.numMadeAsleepPlayer > 0 or false end,
        },
        {
            name        = "doemote",
            Record      = function(data) return data and data.hasDoneEmote end,
            Check       = function(data) return data and data.hasDoneEmote or false end,
        },
        {
            name        = "litflare",
            Record      = function(data) return data.hasLitFlare end,
            Check       = function(data) return data.hasLitFlare or false end,
        },
        {
            name        = "holdcompass",
            Record      = function(data) return data.hasPairedCompass end,
            Check       = function(data) return data.hasPairedCompass or false end,
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
