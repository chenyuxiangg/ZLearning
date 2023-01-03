require("kaachievement_utils/utils")

local spicedfoods = require("spicedfoods")

local modName = "kaAchievement"
local categoryName = "Character"

local variables =
{
    -- Wilson
    maxBeardedDay = 0,

    -- Willow
    numCookedWithLighter = 0,

    -- Wolfgang
    numKilledWhenWimpy = 0,

    -- Wendy
    numHelpedSmallGhost = 0,
    numKilledWithAbi = 0,

    -- Wickerbottom
    numReadBook = 0,

    -- Woodie
    numChoppedAsBeaver = 0,
    numKilledAsMoose = 0,

    -- Waxwell
    numShadowDuelistKilled = 0,
    maxInsaneTime = 0,

    -- Wathgrithr
    maxSingingSongs = 0,

    -- Winona
    numUsedSewingTape = 0,
    numResistedGrue = 0,

    -- Wortox
    numHealedHp = 0,

    -- Wormwood
    numTendedToCropWithBloom = 0,

    -- Walter
    numKilledWithSlingShot = 0,

    -- Wanda
    numKilledWithAlarm = 0,

    -- Wonkey
    numEatenBananaAsWonkey = 0,
}

local bool_variables =
{
    -- Wilson
    beardlessWinter = false,

    -- Willow
    hasPassedWillow2 = false,

    -- Wolfgang
    hasFullyWorkedOut = false,

    -- WX78
    hasRepairedChessJunk = false,

    -- Wickerbottom
    -- hasSleptAsWicker = false,

    -- Wes
    hasDiedToBalloon = false,
    hasDiedToDebris = false,

    -- Webber
    hasPassedWebber1 = false,

    -- Wortox
    hasSoulHopDoudged = false,

    -- Wormwood
    fullBloomSpring = false,

    -- Wurt
    hasCreatedMermKing = false,

    -- Walter
    hasHeavyLiftedWithWoby = false,

    -- Wanda
    hasAvoidedFatalHit = false,

    -- Wonkey
    hasPassedWonkey2 = false,
}

local spiders = KaAllSpiders

for k,v in pairs(spiders) do
    bool_variables["hasBefriended_" .. k] = false
end

local books = KaAllBooks

for k,v in pairs(books) do
    bool_variables["hasPerused_" .. k] = false
    bool_variables["hasCraftedBook_" .. k] = false
end

local preparedfoods = require("preparedfoods")

for k,v in pairs(preparedfoods) do
    bool_variables["hasEaten_" .. k] = false
end

local preparedfoods_warly = require("preparedfoods_warly")

for k,v in pairs(preparedfoods_warly) do
    bool_variables["hasCookedWarly_" .. k] = false
end

for k,v in pairs(KaWx78Modules) do
    bool_variables["hasLearned_" .. k] = false
end

-- Wilson
local function SetupWilsonFunctions(player)
    local manager = player.components.kaAchievementManager

    local beard = player.components.beard
    if beard then
        beard:WatchWorldState("cycles", function(beard)
            manager.maxBeardedDay = math.max(manager.maxBeardedDay, beard.daysgrowth)
            manager:DoAchieve({category=categoryName, name="wilson1"}, {"maxBeardedDay"})
        end)

        -- Initialize this when player joins the world.
        player.ka_isWinter = TheWorld.state.iswinter

        player.WatcherIsWinter = function()
            if TheWorld.state.iswinter then
                player.ka_isWinter = true
            else
                -- Was winter and now it's not.
                local skin, length = beard:GetBeardSkinAndLength()
                if player.ka_isWinter == true and length == nil and not IsEntityDeadOrGhost(player) then
                    manager.beardlessWinter = true
                    manager:DoAchieve({category=categoryName, name="wilson2"}, {"beardlessWinter"})
                    -- player:StopWatchingWorldState("iswinter", player.WatcherIsWinter)    -- Comment this to support trophy reset
                end
                player.ka_isWinter = false
            end
        end
        player:WatchWorldState("iswinter", player.WatcherIsWinter)
    end
end

-- Willow
local function SetupWillowFunctions(player)
    local manager = player.components.kaAchievementManager

    -- chef:PushEvent("ka_CookedWithLighter", {product=product, chef=chef})
    player:ListenForEvent("ka_CookedWithLighter", function(inst, data)
        manager.numCookedWithLighter = manager.numCookedWithLighter + 1
        manager:DoAchieve({category=categoryName, name="willow1"}, {"numCookedWithLighter"})
    end)

    player.ka_startBurningTime = nil
    player.ka_burningCounterTask = nil

    -- self.inst:PushEvent("onignite", {doer = doer})
    player:ListenForEvent("onignite", function(inst, data)
        if player.ka_startBurningTime == nil then
            player.ka_startBurningTime = os.time()
        end

        if player.ka_burningCounterTask ~= nil then
            player.ka_burningCounterTask:Cancel()
            player.ka_burningCounterTask = nil
        end
    end)

    -- inst:PushEvent("onburnt")
    player:ListenForEvent("onburnt", function(inst)
        if player.ka_startBurningTime ~= nil then
            if os.time() - player.ka_startBurningTime >= TUNING.KAACHIEVEMENT.CHARACTER.WILLOW_BURN_TIME then
                manager.hasPassedWillow2 = true
                manager:DoAchieve({category=categoryName, name="willow2"}, {"hasPassedWillow2"})
            end
        end

        player.ka_burningCounterTask = player:DoTaskInTime(TUNING.KAACHIEVEMENT.CHARACTER.WILLOW_BURN_RESET_DELAY, function()
            player.ka_startBurningTime = nil
            player.ka_burningCounterTask = nil
        end)
    end)
end

-- Wolfgang
local function SetupWolfgangFunctions(player)
    local manager = player.components.kaAchievementManager

    local strongman = player.components.strongman
    if strongman then
        local _StopWorkout = strongman.StopWorkout
        strongman.StopWorkout = function(self, gym)
            local mightiness = player.components.mightiness
            if mightiness and mightiness.current == mightiness.max then
                manager.hasFullyWorkedOut = true
                manager:DoAchieve({category=categoryName, name="wolfgang1"}, {"hasFullyWorkedOut"})
            end

            _StopWorkout(self, gym)
        end
    end

    local mightiness = player.components.mightiness
    if mightiness then
        player:ListenForEvent("killed", function(player, data)
            if mightiness:IsWimpy() then
                local victim = data.victim
                if victim then
                    local stackCount = victim.components.stackable and victim.components.stackable:StackSize() or 1
                    manager.numKilledWhenWimpy = manager.numKilledWhenWimpy + stackCount
                    manager:DoAchieve({category=categoryName, name="wolfgang2"}, {"numKilledWhenWimpy"})
                end
            end
        end)
    end
end

-- Wendy
local function SetupWendyFunctions(player)
    local manager = player.components.kaAchievementManager

    player:ListenForEvent("ka_HelpSmallGhost", function()
        manager.numHelpedSmallGhost = manager.numHelpedSmallGhost + 1
        manager:DoAchieve({category=categoryName, name="wendy1"}, {"numHelpedSmallGhost"})
    end)

    player:ListenForEvent("ka_AbigailKilled", function()
        manager.numKilledWithAbi = manager.numKilledWithAbi + 1
        manager:DoAchieve({category=categoryName, name="wendy2"}, {"numKilledWithAbi"})
    end)
end

-- WX78
local function SetupWX78Functions(player)
    local manager = player.components.kaAchievementManager

    -- learner:PushEvent("learnrecipe", { teacher = inst, recipe = inst.components.teacher.recipe })
    -- player:ListenForEvent("learnrecipe", function(inst, data)
    --     local function IsWX78ModuleRecipe(t)
    --         local s = "wx78module_"
    --         return tostring(t):sub(1,#s) == s
    --     end

    --     if IsWX78ModuleRecipe(data.recipe or "") then
    --         local varName = "hasLearned_" .. data.recipe
    --         manager[varName] = true
    --         manager:DoAchieve({category=categoryName, name="wx781"}, {varName})
    --     end
    -- end)

    player:ListenForEvent("ka_LearnWx78Module", function(player, data)
        local varName = "hasLearned_" .. data
        manager[varName] = true
        manager:DoAchieve({category=categoryName, name="wx781"}, {varName})
    end)

    player:ListenForEvent("ka_RepairChessJunk", function()
        manager.hasRepairedChessJunk = true
        manager:DoAchieve({category=categoryName, name="wx782"}, {"hasRepairedChessJunk"})
    end)
end

-- Wickerbottom
local function SetupWickerbottomFunctions(player)
    local manager = player.components.kaAchievementManager

    -- reader:PushEvent("ka_ReadBook", {book=inst})
    player:ListenForEvent("ka_ReadBook", function(player, data)
        manager.numReadBook = manager.numReadBook + 1
        manager:DoAchieve({category=categoryName, name="wickerbottom1"}, {"numReadBook"})
    end)

    --[[
    player:ListenForEvent("knockedout", function()
        manager.hasSleptAsWicker = true
        manager:DoAchieve({category=categoryName, name="wickerbottom2"}, {"hasSleptAsWicker"})
    end)
    ]]--

    player:ListenForEvent("builditem", function(player, data)
        if data and data.item then
            local item = data.item
            local varName = "hasCraftedBook_" .. item.prefab
            if manager[varName] ~= nil then
                manager[varName] = true
                manager:DoAchieve({category=categoryName, name="wickerbottom2"}, {varName})
            end
        end
    end)
end

-- Woodie
local function SetupWoodieFunctions(player)
    local manager = player.components.kaAchievementManager

    -- worker:PushEvent("finishedwork", { target = self.inst, action = self.action })
    player:ListenForEvent("finishedwork", function(inst, data)
        if player:HasTag("beaver") and data.target and data.target:HasTag("tree") then
            manager.numChoppedAsBeaver = manager.numChoppedAsBeaver + 1
            manager:DoAchieve({category=categoryName, name="woodie1"}, {"numChoppedAsBeaver"})
        end
    end)

    player:ListenForEvent("killed", function(player, data)
        if player:HasTag("weremoose") then
            local victim = data.victim
            if victim then
                local stackCount = victim.components.stackable and victim.components.stackable:StackSize() or 1
                manager.numKilledAsMoose = manager.numKilledAsMoose + stackCount
                manager:DoAchieve({category=categoryName, name="woodie2"}, {"numKilledAsMoose"})
            end
        end
    end)
end

-- Waxwell
local function SetupWaxwellFunctions(player)
    local manager = player.components.kaAchievementManager

    player:ListenForEvent("ka_ShadowDuelistKilled", function()
        manager.numShadowDuelistKilled = manager.numShadowDuelistKilled + 1
        manager:DoAchieve({category=categoryName, name="waxwell1"}, {"numShadowDuelistKilled"})
    end)

    player.ka_insaneTask = nil

    -- self.inst:PushEvent("goinsane")
    player:ListenForEvent("goinsane", function()
        player.ka_startInsaneTime = os.time()

        -- 10 seconds to avoid busy saving
        player.ka_insaneTask = player:DoPeriodicTask(10, function()
            manager.maxInsaneTime = math.max(manager.maxInsaneTime, os.time() - player.ka_startInsaneTime)
            manager:DoAchieve({category=categoryName, name="waxwell2"}, {"maxInsaneTime"})
        end)
    end)

    -- self.inst:PushEvent("gosane")
    player:ListenForEvent("gosane", function()
        if player.ka_insaneTask ~= nil then
            player.ka_insaneTask:Cancel()
            player.ka_insaneTask = nil
            player.ka_startInsaneTime = nil
        end
    end)
end

-- Wes
local function SetupWesFunctions(player)
    local manager = player.components.kaAchievementManager

    local function IsQuakerDebris(prefab)
        local quakerDebrisTable =
        {
            "rocks",
            "flint",
            "goldnugget",
            "nitre",
            "rabbit",
            "mole",
            "redgem",
            "bluegem",
            "marble",
            "rocks",
            "flint",
            "moonglass",
            "rock_avocado_fruit",
            "carrat",
        }

        for i,v in ipairs(quakerDebrisTable) do
            if v == prefab then
                return true
            end
        end

        return false
    end

    -- self.inst:PushEvent("death", { cause = cause, afflicter = afflicter })
    player:ListenForEvent("death", function(inst, data)
        if data then
            if data.afflicter and data.afflicter:HasTag("balloon") then
                manager.hasDiedToBalloon = true
                manager:DoAchieve({category=categoryName, name="wes1"}, {"hasDiedToBalloon"})
            elseif IsQuakerDebris(data.cause) then
                manager.hasDiedToDebris = true
                manager:DoAchieve({category=categoryName, name="wes2"}, {"hasDiedToDebris"})
            end
        end
    end)
end

-- Wathgrithr
local function SetupWathgrithrFunctions(player)
    local manager = player.components.kaAchievementManager

    -- self.inst:PushEvent("inspirationsongchanged", {songdata = songdata, slotnum = slot})
    player:ListenForEvent("inspirationsongchanged", function(player, data)
        local singinginspiration = player.components.singinginspiration
        if singinginspiration then
            manager.maxSingingSongs = math.max(manager.maxSingingSongs, #singinginspiration.active_songs)
            manager:DoAchieve({category=categoryName, name="wathgrithr2"}, {"maxSingingSongs"})
        end
    end)
end

-- Webber
local function SetupWebberFunctions(player)
    local manager = player.components.kaAchievementManager

    local leader = player.components.leader
    if leader then
        player:ListenForEvent("killed", function(player, data)
            local function HasSpiderFollower(leader)
                for k,v in pairs(leader.followers) do
                    if k:HasTag("spider") then return true end
                end
                return false
            end

            local victim = data.victim
            if victim and victim.prefab == "spiderqueen" and HasSpiderFollower(leader) then
                manager.hasPassedWebber1 = true
                manager:DoAchieve({category=categoryName, name="webber1"}, {"hasPassedWebber1"})
            end
        end)

        local _AddFollower = leader.AddFollower
        leader.AddFollower = function(self, follower)
            local varName = "hasBefriended_" .. tostring(follower.prefab)
            if manager[varName] ~= nil then
                manager[varName] = true
                manager:DoAchieve({category=categoryName, name="webber2"}, {varName})
            end
            _AddFollower(self, follower)
        end
    end
end

-- Winona
local function SetupWinonaFunctions(player)
    local manager = player.components.kaAchievementManager

    player:ListenForEvent("ka_UsedSewingTape", function()
        manager.numUsedSewingTape = manager.numUsedSewingTape + 1
        manager:DoAchieve({category=categoryName, name="winona1"}, {"numUsedSewingTape"})
    end)

    -- self.inst:PushEvent("resistedgrue")
    player:ListenForEvent("resistedgrue", function()
        manager.numResistedGrue = manager.numResistedGrue + 1
        manager:DoAchieve({category=categoryName, name="winona2"}, {"numResistedGrue"})
    end)
end

-- Wortox
local function SetupWortoxFunctions(player)
    local manager = player.components.kaAchievementManager

    player:ListenForEvent("dropitem", function(inst, data)
        if data.item ~= nil and data.item.prefab == "wortox_soul" then
            local soul = data.item
            local targets = {}
            local x, y, z = soul.Transform:GetWorldPosition()
            for i, v in ipairs(AllPlayers) do
                if not (v.components.health:IsDead() or v:HasTag("playerghost")) and
                    v.entity:IsVisible() and
                    v:GetDistanceSqToPoint(x, y, z) < TUNING.WORTOX_SOULHEAL_RANGE * TUNING.WORTOX_SOULHEAL_RANGE then
                    table.insert(targets, v)
                end
            end

            if #targets > 0 then
                local amt = TUNING.HEALING_MED - math.min(8, #targets) + 1

                manager.numHealedHp = manager.numHealedHp + amt * #targets
                manager:DoAchieve({category=categoryName, name="wortox2"}, {"numHealedHp"})
            end
        end
    end)

    player.ka_soulHopped = nil
    player.ka_soulHopTask = nil

    player:ListenForEvent("soulhop", function()
        player.ka_soulHopped = true

        if player.ka_soulHopTask ~= nil then
            player.ka_soulHopTask:Cancel()
            player.ka_soulHopTask = nil
        end

        player.ka_soulHopTask = player:DoTaskInTime(1, function()
            player.ka_soulHopped = nil
        end)
    end)

    -- target:PushEvent("ka_DodgeAttack")
    player:ListenForEvent("ka_DodgeAttack", function()
        if player.ka_soulHopped == true then
            manager.hasSoulHopDoudged = true
            manager:DoAchieve({category=categoryName, name="wortox1"}, {"hasSoulHopDoudged"})
        end
    end)
end

-- Wormwood
local function SetupWormwoodFunctions(player)
    local manager = player.components.kaAchievementManager

    player:ListenForEvent("ka_TendToCropWithBloom", function()
        manager.numTendedToCropWithBloom = manager.numTendedToCropWithBloom + 1
        manager:DoAchieve({category=categoryName, name="wormwood1"}, {"numTendedToCropWithBloom"})
    end)

    -- Initialize this when player joins the world.
    player.ka_isSpring = TheWorld.state.isspring

    player.WatcherIsSpring = function()
        if TheWorld.state.isspring then
            player.ka_isSpring = true
        else
            -- Was spring and now it's not.
            if player.ka_isSpring == true and player.fullbloom == true and not IsEntityDeadOrGhost(player) then
                manager.fullBloomSpring = true
                manager:DoAchieve({category=categoryName, name="wormwood2"}, {"fullBloomSpring"})
                player:StopWatchingWorldState("isspring", player.WatcherIsSpring)
            end
            player.ka_isSpring = false
        end
    end
    player:WatchWorldState("isspring", player.WatcherIsSpring)
end

-- Warly
local function SetupWarlyFunctions(player)
    local manager = player.components.kaAchievementManager

    player:ListenForEvent("oneat", function(inst, data)
        local product = (data ~= nil and data.food ~= nil and data.food:HasTag("preparedfood")) and data.food.prefab or nil
        if product ~= nil then
            local varName = "hasEaten_" .. product
            if manager[varName] ~= nil then
                manager[varName] = true
                manager:DoAchieve({category=categoryName, name="warly1"}, {varName})
            end
        end
    end)

    player:ListenForEvent("learncookbookrecipe", function(inst, data)
        -- data.product, data.ingredients
        local varName = "hasCookedWarly_" .. data.product
        if manager[varName] ~= nil then
            manager[varName] = true
            manager:DoAchieve({category=categoryName, name="warly2"}, {varName})
        end
    end)
end

-- Wurt
local function SetupWurtFunctions(player)
    local manager = player.components.kaAchievementManager

    -- reader:PushEvent("ka_PeruseBook", {book=inst})
    player:ListenForEvent("ka_PeruseBook", function(player, data)
        local varName = "hasPerused_" .. data.book.prefab
        if manager[varName] ~= nil then
            manager[varName] = true
            manager:DoAchieve({category=categoryName, name="wurt1"}, {varName})
        end
    end)

    -- TheWorld:PushEvent("onmermkingcreated", {king = self.king, throne = self:GetMainThrone()})
    player:ListenForEvent("onmermkingcreated", function(inst, data)
        if player:IsNear(data.king, TUNING.KAACHIEVEMENT.CHARACTER.WURT_MERMKING_RANGE) then
            manager.hasCreatedMermKing = true
            manager:DoAchieve({category=categoryName, name="wurt2"}, {"hasCreatedMermKing"})
        end
    end, TheWorld)
end

-- Walter
local function SetupWalterFunctions(player)
    local manager = player.components.kaAchievementManager

    -- @Note: "killed" event will be triggered even if mob is killed in hands, which is not expected.
    player:ListenForEvent("ka_KilledOtherWithWeapon", function(player, data)
        local function IsSlingShotAmmo(t)
            local s = "slingshotammo"
            return tostring(t):sub(1,#s) == s
        end

        local weapon = data.weapon
        if weapon and IsSlingShotAmmo(weapon.prefab) then
            manager.numKilledWithSlingShot = manager.numKilledWithSlingShot + 1
            manager:DoAchieve({category=categoryName, name="walter1"}, {"numKilledWithSlingShot"})
        end
    end)

    player.ka_CheckIsHeavyLiftingWithWoby = function(self)
        local mount = self.components.rider:GetMount()
        if mount and mount.prefab == "wobybig" and self.components.inventory:IsHeavyLifting() then
            manager.hasHeavyLiftedWithWoby = true
            manager:DoAchieve({category=categoryName, name="walter2"}, {"hasHeavyLiftedWithWoby"})
        end
    end

    player:ListenForEvent("ka_RideOnWoby", function(player, data)
        player:ka_CheckIsHeavyLiftingWithWoby()
    end)

    player:ListenForEvent("equip", function(player, data)
        -- Adai: Delay 1 frame to wait for the achievement data be loaded correctly.
        --       Without this the manager would not be ready, and it would think the trophy is just new unlocked.
        player:DoTaskInTime(0, function()
            player:ka_CheckIsHeavyLiftingWithWoby()
        end)
    end)
end

-- Wanda
local function SetupWandaFunctions(player)
    local manager = player.components.kaAchievementManager

    local oldager = player.components.oldager
    local health = player.components.health
    if oldager then
        local _StopDamageOverTime = oldager.StopDamageOverTime
        oldager.StopDamageOverTime = function(self)
            if health.currenthealth - self.damage_remaining <= 0 then
                manager.hasAvoidedFatalHit = true
                manager:DoAchieve({category=categoryName, name="wanda1"}, {"hasAvoidedFatalHit"})
            end
            _StopDamageOverTime(self)
        end
    end

    -- @Note: "killed" event will be triggered even if mob is killed in hands, which is not expected.
    player:ListenForEvent("ka_KilledOtherWithWeapon", function(player, data)
        local weapon = data.weapon
        if weapon and weapon.prefab == "pocketwatch_weapon" and player.age_state == "old" then
            manager.numKilledWithAlarm = manager.numKilledWithAlarm + 1
            manager:DoAchieve({category=categoryName, name="wanda2"}, {"numKilledWithAlarm"})
        end
    end)
end

-- Wonkey
local function SetupWonkeyFunctions(player)
    local manager = player.components.kaAchievementManager

    -- self.inst:PushEvent("oneat", { food = food, feeder = feeder })
    player:ListenForEvent("oneat", function(player, data)
        if data.food and data.food:HasTag("banana") then
            manager.numEatenBananaAsWonkey = manager.numEatenBananaAsWonkey + 1
            manager:DoAchieve({category=categoryName, name="wonkey1"}, {"numEatenBananaAsWonkey"})
        end
    end)

    local locomotor = player.components.locomotor
    if locomotor then
        local _RunForward = locomotor.RunForward
        locomotor.RunForward = function(...)
            if not manager.hasPassedWonkey2 then
                local timeRunning = locomotor:GetTimeMoving() - TUNING.WONKEY_TIME_TO_RUN

                local function CheckPirateOutfit(inventory)
                    local pirate =
                    {
                        monkey_smallhat = false,
                        cutless         = false,
                    }

                    if inventory and inventory.equipslots then
                        for k,v in pairs(EQUIPSLOTS) do
                            for kk,vv in pairs(pirate) do
                                if inventory.equipslots[v] ~= nil and inventory.equipslots[v].prefab == kk then
                                    pirate[kk] = true
                                end
                            end
                        end
                    end

                    local isPirate = true

                    for kk,vv in pairs(pirate) do
                        if not vv then
                            isPirate = false
                            break
                        end
                    end

                    return isPirate
                end

                local inventory = player.components.inventory

                -- Check if Wonkey has been running for 60 seconds, and is wearing the pirate outfit.
                -- Adai: People might not wear the outfit from the very beginning of the running.
                if timeRunning >= TUNING.KAACHIEVEMENT.VALUE.MINUTE_TINY and
                   CheckPirateOutfit(inventory) then
                    manager.hasPassedWonkey2 = true
                    manager:DoAchieve({category=categoryName, name="wonkey2"}, {"hasPassedWonkey2"})
                end
            end
            _RunForward(...)
        end
    end
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

    if player.prefab == "wilson" then
        SetupWilsonFunctions(player)
    elseif player.prefab == "willow" then
        SetupWillowFunctions(player)
    elseif player.prefab == "wolfgang" then
        SetupWolfgangFunctions(player)
    elseif player.prefab == "wendy" then
        SetupWendyFunctions(player)
    elseif player.prefab == "wx78" then
        SetupWX78Functions(player)
    elseif player.prefab == "wickerbottom" then
        SetupWickerbottomFunctions(player)
    elseif player.prefab == "woodie" then
        SetupWoodieFunctions(player)
    elseif player.prefab == "waxwell" then
        SetupWaxwellFunctions(player)
    elseif player.prefab == "wes" then
        SetupWesFunctions(player)
    elseif player.prefab == "wathgrithr" then
        SetupWathgrithrFunctions(player)
    elseif player.prefab == "webber" then
        SetupWebberFunctions(player)
    elseif player.prefab == "winona" then
        SetupWinonaFunctions(player)
    elseif player.prefab == "wortox" then
        SetupWortoxFunctions(player)
    elseif player.prefab == "wormwood" then
        SetupWormwoodFunctions(player)
    elseif player.prefab == "warly" then
        SetupWarlyFunctions(player)
    elseif player.prefab == "wurt" then
        SetupWurtFunctions(player)
    elseif player.prefab == "walter" then
        SetupWalterFunctions(player)
    elseif player.prefab == "wanda" then
        SetupWandaFunctions(player)
    elseif player.prefab == "wonkey" then
        SetupWonkeyFunctions(player)
    end
end

-- function SetupLighterFunctions(inst)
local function SetupLighterFunctions(inst)
    local cooker = inst.components.cooker
    if cooker then
        local _oncookfn = cooker.oncookfn
        cooker.oncookfn = function(inst, product, chef)
            if _oncookfn then _oncookfn(inst, product, chef) end
            if chef and chef.prefab == "willow" then
                chef:PushEvent("ka_CookedWithLighter", {product=product, chef=chef})
            end
        end
    end
end

-- function SetupBookFunctions(inst)
local function SetupBookFunctions(inst)
    local book = inst.components.book
    if book then
        local _onread = book.onread
        book.onread = function(inst, reader)
            if reader and reader.prefab == "wickerbottom" then
                reader:PushEvent("ka_ReadBook", {book=inst})
            end

            if _onread ~= nil then
                return _onread(inst, reader)
            end

            return true
        end

        local _onperuse = book.onperuse
        book.onperuse = function(inst, reader)
            if reader and reader.prefab == "wurt" then
                reader:PushEvent("ka_PeruseBook", {book=inst})
            end

            if _onperuse ~= nil then
                return _onperuse(inst, reader)
            end

            return true
        end
    end
end

-- function SetupShadowDuelistFunctions(inst)
local function SetupShadowDuelistFunctions(inst)
    inst:ListenForEvent("killed", function(inst, data)
        local leader = inst.components.follower:GetLeader()
        if leader and data.victim then
            leader:PushEvent("ka_ShadowDuelistKilled")
        end
    end)
end

-- function SetupSewingTapeFunctions(inst)
local function SetupSewingTapeFunctions(inst)
    -- self.onsewn(self.inst, target, doer)
    local sewing = inst.components.sewing
    if sewing then
        local _onsewn = sewing.onsewn
        sewing.onsewn = function(inst, target, doer)
            if _onsewn then _onsewn(inst, target, doer) end
            if doer and doer.prefab == "winona" then
                doer:PushEvent("ka_UsedSewingTape")
            end
        end
    end
end

-- function SetupFarmPlantFunctions(inst)
local function SetupFarmPlantFunctions(inst)
    -- Debug only: to force player bloom
    -- ThePlayer.components.bloomness.onlevelchangedfn(ThePlayer, 3)

    -- inst.components.farmplanttendable.ontendtofn = ontendto
    local farmplanttendable = inst.components.farmplanttendable
    if farmplanttendable then
        local _ontendtofn = farmplanttendable.ontendtofn
        farmplanttendable.ontendtofn = function(inst, doer)
            if doer and doer.prefab == "wormwood" and doer.fullbloom == true then
                doer:PushEvent("ka_TendToCropWithBloom")
            end
            return _ontendtofn(inst, doer)
        end
    end
end

-- function SetupWobyFunctions(inst)
local function SetupWobyFunctions(inst)
    -- self.inst:PushEvent("riderchanged", { oldrider = oldrider, newrider = self.rider })
    inst:ListenForEvent("riderchanged", function(inst, data)
        if data.newrider and data.newrider.prefab == "walter" then
            data.newrider:PushEvent("ka_RideOnWoby")
        end
    end)
end

-- function SetupMobMissFunctions(inst)
local function SetupMobMissFunctions(inst)
    -- Adai: Doesn't seem to work for bishop (projectile attack?)
    -- self.inst:PushEvent("onmissother", { target = targ, weapon = weapon })
    inst:ListenForEvent("onmissother", function(inst, data)
        local target = data and data.target
        if target and target.prefab == "wortox" then
            target:PushEvent("ka_DodgeAttack")
        end
    end)
end

-- function SetupSmallGhostFunctions(inst)
local function SetupSmallGhostFunctions(inst)
    -- self.inst:PushEvent("newstate", {statename = statename})
    inst:ListenForEvent("newstate", function(inst, data)
        if data.statename == "quest_finished" then
            if inst.ka_linkedPlayer ~= nil and inst.ka_linkedPlayer.prefab == "wendy" then
                inst.ka_linkedPlayer:PushEvent("ka_HelpSmallGhost")
            end
            inst.ka_linkedPlayer = nil
        elseif data.statename == "quest_begin" then
            inst.ka_linkedPlayer = inst._playerlink
        end
    end)
end

-- function SetupAbigailFunctions(inst)
local function SetupAbigailFunctions(inst)
    inst:ListenForEvent("killed", function(player, data)
        local leader = inst.components.follower.leader
        if leader then
            -- Must be Wendy though.
            leader:PushEvent("ka_AbigailKilled")
        end
    end)
end

-- function SetupChessJunkFunctions(inst)
local function SetupChessJunkFunctions(inst)
    local repairable = inst.components.repairable
    if repairable then
        local _onrepaired = repairable.onrepaired
        repairable.onrepaired = function(inst, doer)
            if _onrepaired then _onrepaired(inst,doer) end
            if inst.repaired == true and doer and doer.prefab == "wx78" then
                doer:PushEvent("ka_RepairChessJunk")
            end
        end
    end
end

-- function SetupWx78ScannerFunctions(inst)
local function SetupWx78ScannerFunctions(inst)
    local _OnSuccessfulScan = inst.OnSuccessfulScan
    inst.OnSuccessfulScan = function(self)
        _OnSuccessfulScan(self)

        local owner = inst:OwnerFn()
        print(owner, "_module_recipe_to_teach", self._module_recipe_to_teach)
        print(owner, "_scanned_prefab", self._scanned_prefab)

        if owner and self._module_recipe_to_teach then
            owner:PushEvent("ka_LearnWx78Module", self._module_recipe_to_teach)
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
            SetupPlayerFunctions(inst)
        end
    end

    -- Both client and server should have the tag
    local bananas =
    {
        cave_banana          = true,
        cave_banana_cooked   = true,
        bananapop            = true,
        bananajuice          = true,
        frozenbananadaiquiri = true,
    }
    if bananas[inst.prefab] == true or
       (spicedfoods[inst.prefab] ~= nil and bananas[spicedfoods[inst.prefab].basename] == true) then
        inst:AddTag("banana")
    end

    -- Server only.
    if not TheNet:GetIsClient() then
        if inst.prefab == "lighter" then
            SetupLighterFunctions(inst)
        elseif inst.components.book ~= nil then
            SetupBookFunctions(inst)
        elseif inst.prefab == "shadowduelist" then
            SetupShadowDuelistFunctions(inst)
        elseif inst.prefab == "sewing_tape" then
            SetupSewingTapeFunctions(inst)
        elseif inst:HasTag("farm_plant") then
            SetupFarmPlantFunctions(inst)
        elseif inst.prefab == "wobybig" then
            SetupWobyFunctions(inst)
        elseif inst.prefab == "smallghost" then
            SetupSmallGhostFunctions(inst)
        elseif inst.prefab == "abigail" then
            SetupAbigailFunctions(inst)
        elseif inst.prefab == "chessjunk1" or
               inst.prefab == "chessjunk2" or
               inst.prefab == "chessjunk3" then
            SetupChessJunkFunctions(inst)
        elseif inst.prefab == "wx78_scanner" then
            SetupWx78ScannerFunctions(inst)
        end

        -- @Note: "killed" event will be triggered even if mob is killed in hands, which is not expected.
        if inst.components.combat ~= nil and inst.components.health ~= nil then
            inst:ListenForEvent("attacked", function(inst, data)
                if inst.components.health:IsDead() and data and data.attacker and data.attacker:HasTag("player") then
                    data.victim = inst
                    data.attacker:PushEvent("ka_KilledOtherWithWeapon", data)
                end
            end)

            SetupMobMissFunctions(inst)
        end
    end
end

-- RegisterXxxxAchievementEntries(root)
local registerEntriesFuncName = string.format("Register%sAchievementEntries", categoryName)
_G[registerEntriesFuncName] = function(root)
    local function GetNumBefriendedSpiders(data)
        return KaGetNumDone(spiders, function(k, v) return data["hasBefriended_" .. k] == true end)
    end

    local function GetNumPerusedBooks(data)
        return KaGetNumDone(books, function(k, v) return data["hasPerused_" .. k] == true end)
    end

    local function GetNumEatenPreparedFoods(data)
        return KaGetNumDone(preparedfoods, function(k, v) return data["hasEaten_" .. k] == true end)
    end

    local function GetNumCookedWarlyPreparedFoods(data)
        return KaGetNumDone(preparedfoods_warly, function(k, v) return data["hasCookedWarly_" .. k] == true end)
    end

    local function GetNumLearnedWX78Modules(data)
        return KaGetNumDone(KaWx78Modules, function(k, v) return data["hasLearned_" .. k] == true end)
    end

    local function GetNumCraftedBooks(data)
        return KaGetNumDone(books, function(k, v) return data["hasCraftedBook_" .. k] == true end)
    end

    local entries =
    {
        {
            name        = "wilson1",
            Record      = function(data) return data and data.maxBeardedDay end,
            Check       = function(data) return data and data.maxBeardedDay and data.maxBeardedDay >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MED end,
        },
        {
            name        = "wilson2",
            Record      = function(data) return data and data.beardlessWinter end,
            Check       = function(data) return data and data.beardlessWinter or false end,
        },
        {
            name        = "willow1",
            Record      = function(data) return data and data.numCookedWithLighter end,
            Check       = function(data) return data and data.numCookedWithLighter and data.numCookedWithLighter >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        {
            name        = "willow2",
            Record      = function(data) return data and data.hasPassedWillow2 end,
            Check       = function(data) return data and data.hasPassedWillow2 or false end,
        },
        {
            name        = "wolfgang1",
            Record      = function(data) return data and data.hasFullyWorkedOut end,
            Check       = function(data) return data and data.hasFullyWorkedOut or false end,
        },
        {
            name        = "wolfgang2",
            Record      = function(data) return data and data.numKilledWhenWimpy end,
            Check       = function(data) return data and data.numKilledWhenWimpy and data.numKilledWhenWimpy >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        {
            name        = "wendy1",
            Record      = function(data) return data and data.numHelpedSmallGhost end,
            Check       = function(data) return data and data.numHelpedSmallGhost and data.numHelpedSmallGhost >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MED end,
        },
        {
            name        = "wendy2",
            Record      = function(data) return data and data.numKilledWithAbi end,
            Check       = function(data) return data and data.numKilledWithAbi and data.numKilledWithAbi >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        {
            name        = "wx781",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumLearnedWX78Modules(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumLearnedWX78Modules(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumLearnedWX78Modules(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
        {
            name        = "wx782",
            Record      = function(data) return data and data.hasRepairedChessJunk end,
            Check       = function(data) return data and data.hasRepairedChessJunk or false end,
        },
        {
            name        = "wickerbottom1",
            Record      = function(data) return data and data.numReadBook end,
            Check       = function(data) return data and data.numReadBook and data.numReadBook >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        --[[
        {
            name        = "wickerbottom2",
            Record      = function(data) return data and data.hasSleptAsWicker end,
            Check       = function(data) return data and data.hasSleptAsWicker or false end,
        },
        ]]--
        {
            name        = "wickerbottom2",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumCraftedBooks(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumCraftedBooks(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumCraftedBooks(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
        {
            name        = "woodie1",
            Record      = function(data) return data and data.numChoppedAsBeaver end,
            Check       = function(data) return data and data.numChoppedAsBeaver and data.numChoppedAsBeaver >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDHUGE end,
        },
        {
            name        = "woodie2",
            Record      = function(data) return data and data.numKilledAsMoose end,
            Check       = function(data) return data and data.numKilledAsMoose and data.numKilledAsMoose >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        {
            name        = "waxwell1",
            Record      = function(data) return data and data.numShadowDuelistKilled end,
            Check       = function(data) return data and data.numShadowDuelistKilled and data.numShadowDuelistKilled >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        {
            name        = "waxwell2",
            Record      = function(data) return data and data.maxInsaneTime end,
            Check       = function(data) return data and data.maxInsaneTime and data.maxInsaneTime >= TUNING.KAACHIEVEMENT.VALUE.MINUTE_MEDSMALL end,
        },
        {
            name        = "wes1",
            Record      = function(data) return data and data.hasDiedToBalloon end,
            Check       = function(data) return data and data.hasDiedToBalloon or false end,
        },
        {
            name        = "wes2",
            Record      = function(data) return data and data.hasDiedToDebris end,
            Check       = function(data) return data and data.hasDiedToDebris or false end,
        },
        {
            -- Variable "numKilledBossAsWigfrid" is declared in the Boss category.
            name        = "wathgrithr1",
            Record      = function(data) return data and data.numKilledBossAsWigfrid end,
            Check       = function(data) return data and data.numKilledBossAsWigfrid and data.numKilledBossAsWigfrid >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MED end,
        },
        {
            name        = "wathgrithr2",
            Record      = function(data) return data and data.maxSingingSongs end,
            Check       = function(data) return data and data.maxSingingSongs and data.maxSingingSongs >= 3 end,
        },
        {
            name        = "webber1",
            Record      = function(data) return data and data.hasPassedWebber1 end,
            Check       = function(data) return data and data.hasPassedWebber1 or false end,
        },
        {
            name        = "webber2",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumBefriendedSpiders(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumBefriendedSpiders(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumBefriendedSpiders(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
        {
            name        = "winona1",
            Record      = function(data) return data and data.numUsedSewingTape end,
            Check       = function(data) return data and data.numUsedSewingTape and data.numUsedSewingTape >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        {
            name        = "winona2",
            Record      = function(data) return data and data.numResistedGrue end,
            Check       = function(data) return data and data.numResistedGrue and data.numResistedGrue >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_SMALL end,
        },
        {
            name        = "wortox1",
            Record      = function(data) return data and data.hasSoulHopDoudged end,
            Check       = function(data) return data and data.hasSoulHopDoudged or false end,
        },
        {
            name        = "wortox2",
            Record      = function(data) return data and data.numHealedHp end,
            Check       = function(data) return data and data.numHealedHp and data.numHealedHp >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_SUPERHUGE end,
        },
        {
            name        = "wormwood1",
            Record      = function(data) return data and data.numTendedToCropWithBloom end,
            Check       = function(data) return data and data.numTendedToCropWithBloom and data.numTendedToCropWithBloom >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_HUGE end,
        },
        {
            name        = "wormwood2",
            Record      = function(data) return data and data.fullBloomSpring end,
            Check       = function(data) return data and data.fullBloomSpring or false end,
        },
        {
            name        = "warly1",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumEatenPreparedFoods(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumEatenPreparedFoods(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumEatenPreparedFoods(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
        {
            name        = "warly2",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumCookedWarlyPreparedFoods(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumCookedWarlyPreparedFoods(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumCookedWarlyPreparedFoods(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
        {
            name        = "wurt1",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumPerusedBooks(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumPerusedBooks(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumPerusedBooks(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
        {
            name        = "wurt2",
            Record      = function(data) return data and data.hasCreatedMermKing end,
            Check       = function(data) return data and data.hasCreatedMermKing or false end,
        },
        {
            name        = "walter1",
            Record      = function(data) return data and data.numKilledWithSlingShot end,
            Check       = function(data) return data and data.numKilledWithSlingShot and data.numKilledWithSlingShot >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        {
            name        = "walter2",
            Record      = function(data) return data and data.hasHeavyLiftedWithWoby end,
            Check       = function(data) return data and data.hasHeavyLiftedWithWoby or false end,
        },
        {
            name        = "wanda1",
            Record      = function(data) return data and data.hasAvoidedFatalHit end,
            Check       = function(data) return data and data.hasAvoidedFatalHit or false end,
        },
        {
            name        = "wanda2",
            Record      = function(data) return data and data.numKilledWithAlarm end,
            Check       = function(data) return data and data.numKilledWithAlarm and data.numKilledWithAlarm >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        {
            name        = "wonkey1",
            Record      = function(data) return data and data.numEatenBananaAsWonkey end,
            Check       = function(data) return data and data.numEatenBananaAsWonkey and data.numEatenBananaAsWonkey >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDLARGE end,
        },
        {
            name        = "wonkey2",
            Record      = function(data) return data and data.hasPassedWonkey2 end,
            Check       = function(data) return data and data.hasPassedWonkey2 and data.hasPassedWonkey2 or false end,
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
