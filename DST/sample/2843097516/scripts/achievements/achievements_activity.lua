require("kaachievement_utils/utils")

local modName = "kaAchievement"
local categoryName = "Activity"

local variables =
{
    numKilledByFood             = 0,
    numKilledByHunger           = 0,
    numKilledByFreeze           = 0,
    numKilledByHeat             = 0,
    numBlinked                  = 0,
    numDiscountedBuild          = 0,
    numTradedWithPigKing        = 0,
    numPlantedFlower            = 0,
    maxPigFollowers             = 0,
    maxBunnyFollowers           = 0,
    maxRockyFollowers           = 0,
    numTeleportedBigTentacle    = 0,
    numTeleportedWormhole       = 0,
    numPickedTumbleweed         = 0,
    numStruckByLightning        = 0,
    timeFastFished              = 0,
    numFailedDish               = 0,
}

local bool_variables =
{
    hasHeldPearl                = false,
    hasWonMiniGame              = false,
    hasAdoptedCritter           = false,
    hasBeenBowedTo              = false,
    hasWornSkeletonHat          = false,
    hasWornEyebrellaHat         = false,
    hasWornRuinsHat             = false,
    hasBuiltLab2                = false, -- researchlab aka Alchemy Machine
    hasBuiltLab4                = false, -- researchlab4 aka Prestihatitator
    hasBuiltLab3                = false, -- researchlab3 aka Shadow Manipulator
    hasWitnessedHatch           = false,
    hasActivatedArchives        = false,
    hasWornLikeTurtle           = false,
    hasTamedBeefalo             = false,
    hasObtainedPotatoCup        = false,
    hasBuiltEyeTurret           = false,
    hasOneHp                    = false,
    hasPickedUpRose             = false,
    hasWitnessedWere            = false,
    hasPickedGlommerFlower      = false,
    hasHarvestedBeebox          = false,
    hasShavedBeefalo            = false,
    hasWitnessedKrampusSack     = false,
    hasOpenedPandorasChest      = false,
    hasSpawnedKrampus           = false,
    hasTeleportedOneself        = false,
    hasWitnessedOpalStaff       = false,
    hasWitnessedHutch           = false,
    hasWitnessedChester         = false,
    hasSewnItem                 = false,
    hasWornSlurperOutOfCave     = false,
    hasPacifiedForest           = false,
    hasUsedHalloweenPotionMoon  = false,
    hasDiedToNightmarePie       = false,
    hasHeardLivingLogScream     = false,
}

local weapons = KaAllWeapons

for k,_ in pairs(weapons) do
    bool_variables["equipped_" .. k] = false
end

local relics = KaAllRelics

for k,_ in pairs(relics) do
    bool_variables["hasLearned_" .. k] = false
end

local preparedFoods = require("preparedfoods")
local preparedNonFoods = require("preparednonfoods")

local allFoods = {}
for k,_ in pairs(preparedFoods) do allFoods[k] = true end
for k,_ in pairs(preparedNonFoods) do allFoods[k] = true end

for k,_ in pairs(allFoods) do
    bool_variables["hasCooked_" .. k] = false
end

for k,_ in pairs(KaAllFish) do
    bool_variables["hasCaught_" .. k] = false
end

local function BroadcastEvent(inst, range, event, data)
    local x,y,z = inst.Transform:GetWorldPosition()
    local players = FindPlayersInRange(x, y, z, range or 30)
    for i,v in ipairs(players) do
        v:PushEvent(event, data)
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

    -- Register event callback functions.
    -- self.inst:PushEvent("equip", { item = item, eslot = eslot })
    player:ListenForEvent("equip", function(player, data)
        local item = data.item

        -- Adai: Delay 1 frame to wait for the achievement data be loaded correctly.
        --       Without this the manager would not be ready, and it would think the trophy is just new unlocked.
        player:DoTaskInTime(0, function()
            if item then
                if weapons[item.prefab] and data.eslot == EQUIPSLOTS.HANDS then
                    local varName = "equipped_" .. item.prefab
                    manager[varName] = true
                    manager:DoAchieve({category=categoryName, name="allweapon"}, {varName})
                end

                if item.prefab == "skeletonhat" then
                    manager["hasWornSkeletonHat"] = true
                    manager:DoAchieve({category=categoryName, name="bonehelm"}, {"hasWornSkeletonHat"})
                elseif item.prefab == "eyebrellahat" then
                    manager["hasWornEyebrellaHat"] = true
                    manager:DoAchieve({category=categoryName, name="eyebrella"}, {"hasWornEyebrellaHat"})
                elseif item.prefab == "slurper" then
                    if TheWorld and not TheWorld:HasTag("cave") then
                        -- @Note: The player needs to bring it up to the surface world. Delay 5 seconds for HUD to be fully ready.
                        player:DoTaskInTime(5, function()
                            manager["hasWornSlurperOutOfCave"] = true
                            manager:DoAchieve({category=categoryName, name="slurper"}, {"hasWornSlurperOutOfCave"})
                        end)
                    end
                end

                local function CheckTurtle(inventory)
                    local turtle =
                    {
                        slurtlehat        = false,
                        armorsnurtleshell = false,
                    }

                    if inventory and inventory.equipslots then
                        for k,v in pairs(EQUIPSLOTS) do
                            for kk,vv in pairs(turtle) do
                                if inventory.equipslots[v] ~= nil and inventory.equipslots[v].prefab == kk then
                                    turtle[kk] = true
                                end
                            end
                        end
                    end

                    local isTurtle = true

                    for kk,vv in pairs(turtle) do
                        if not vv then
                            isTurtle = false
                        end
                    end

                    return isTurtle
                end

                -- "hasWornLikeTurtle"
                local inventory = player.components.inventory
                if not manager.hasWornLikeTurtle and CheckTurtle(inventory) then
                    manager.hasWornLikeTurtle = true
                    manager:DoAchieve({category=categoryName, name="turtle"}, {"hasWornLikeTurtle"})
                end

                local function CheckRoyalty(inventory)
                    local royalty =
                    {
                        ruinshat        = false,
                        armorruins      = false,
                    }

                    if inventory and inventory.equipslots then
                        for k,v in pairs(EQUIPSLOTS) do
                            for kk,vv in pairs(royalty) do
                                if inventory.equipslots[v] ~= nil and inventory.equipslots[v].prefab == kk then
                                    royalty[kk] = true
                                end
                            end
                        end
                    end

                    local isRoyalty = true

                    for kk,vv in pairs(royalty) do
                        if not vv then
                            isRoyalty = false
                        end
                    end

                    return isRoyalty
                end

                -- "hasWornRuinsHat"
                local inventory = player.components.inventory
                if not manager.hasWornRuinsHat and CheckRoyalty(inventory) then
                    manager.hasWornRuinsHat = true
                    manager:DoAchieve({category=categoryName, name="ruinshat"}, {"hasWornRuinsHat"})
                end
            end
        end)
    end)

    -- -- self.inst:PushEvent("builditem", { item = prod, recipe = recipe, skin = skin, prototyper = self.current_prototyper })
    -- player:ListenForEvent("builditem", function(player, data)
    --     print("builditem")
    --     dumptable(data)
    -- end)

    -- self.inst:PushEvent("buildstructure", { item = prod, recipe = recipe, skin = skin })
    player:ListenForEvent("buildstructure", function(player, data)
        if data and data.item then
            local item = data.item
            if item.prefab == "researchlab2" then
                manager["hasBuiltLab2"] = true
                manager:DoAchieve({category=categoryName, name="alchemy"}, {"hasBuiltLab2"})
            elseif item.prefab == "researchlab4" then
                manager["hasBuiltLab4"] = true
                manager:DoAchieve({category=categoryName, name="prestihati"}, {"hasBuiltLab4"})
            elseif item.prefab == "researchlab3" then
                manager["hasBuiltLab3"] = true
                manager:DoAchieve({category=categoryName, name="smanipulator"}, {"hasBuiltLab3"})
            end
        end
    end)

    player:ListenForEvent("ka_AdopttedCritter", function(player, data)
        if not manager.hasAdoptedCritter then
            manager.hasAdoptedCritter = true
            manager:DoAchieve({category=categoryName, name="critter"}, {"hasAdoptedCritter"})
        end
    end)

    -- self.inst:PushEvent("newstate", {statename = statename})
    player:ListenForEvent("newstate", function(inst, data)
        if data.statename == "bow" then
            local target = inst.sg.statemem.target
            if target then
                target:PushEvent("ka_BowedTo")
            end
        end
    end)

    player:ListenForEvent("ka_BowedTo", function()
        manager.hasBeenBowedTo = true
        manager:DoAchieve({category=categoryName, name="beecrown"}, {"hasBeenBowedTo"})
    end)

    -- self.inst:PushEvent("oneat", { food = food, feeder = feeder })
    player:ListenForEvent("oneat", function(inst, data)
        local health = player.components.health
        if health and health:IsDead() and data.feeder == player then
            manager.numKilledByFood = manager.numKilledByFood + 1
            manager:DoAchieve({category=categoryName, name="foodkill"}, {"numKilledByFood"})
        end
    end)

    -- self.inst:PushEvent("death", { cause = cause, afflicter = afflicter })
    player:ListenForEvent("death", function(inst, data)
        if data and data.cause == "hunger" then
            manager.numKilledByHunger = manager.numKilledByHunger + 1
            manager:DoAchieve({category=categoryName, name="starvation"}, {"numKilledByHunger"})
        elseif data and data.cause == "cold" then -- What the hell is up with these names?
            if TheWorld.state.issummer then
                manager.numKilledByFreeze = manager.numKilledByFreeze + 1
                manager:DoAchieve({category=categoryName, name="summerfreeze"}, {"numKilledByFreeze"})
            end
        elseif data and data.cause == "hot" then -- This one too, Look :volxS:
            if TheWorld.state.iswinter then
                manager.numKilledByHeat = manager.numKilledByHeat + 1
                manager:DoAchieve({category=categoryName, name="winterheat"}, {"numKilledByHeat"})
            end
        elseif data and data.cause == "nightmarepie" then
            manager.hasDiedToNightmarePie = true
            manager:DoAchieve({category=categoryName, name="grimgalette"}, {"hasDiedToNightmarePie"})
        end
    end)

    player:ListenForEvent("ka_Blinked", function(inst, data)
        manager.numBlinked = manager.numBlinked + 1
        manager:DoAchieve({category=categoryName, name="orangestaff"}, {"numBlinked"})
    end)

    player:ListenForEvent("ka_UsedGreenAmulet", function(inst, data)
        manager.numDiscountedBuild = manager.numDiscountedBuild + 1
        manager:DoAchieve({category=categoryName, name="greenamulet"}, {"numDiscountedBuild"})
    end)

    player:ListenForEvent("ka_TradedWithPigking", function(inst, data)
        manager.numTradedWithPigKing = manager.numTradedWithPigKing + 1
        manager:DoAchieve({category=categoryName, name="pigking"}, {"numTradedWithPigKing"})
    end)

    player:ListenForEvent("ka_WonPigkingMiniGame", function(inst, data)
        if not manager.hasWonMiniGame then
            manager.hasWonMiniGame = true
            manager:DoAchieve({category=categoryName, name="pigkingmg"}, {"hasWonMiniGame"})
        end
    end)

    -- deployer:PushEvent("deployitem", { prefab = self.inst.prefab })
    player:ListenForEvent("deployitem", function(inst, data)
        if data then
            if data.prefab == "butterfly" then
                manager.numPlantedFlower = manager.numPlantedFlower + 1
                manager:DoAchieve({category=categoryName, name="plantflower"}, {"numPlantedFlower"})
            elseif data.prefab == "eyeturret_item" then
                manager["hasBuiltEyeTurret"] = true
                manager:DoAchieve({category=categoryName, name="eyeturret"}, {"hasBuiltEyeTurret"})
            end
        end
    end)

    local leader = player.components.leader
    if leader then
        leader.CountRealPigFollowers = function(self)
            local count = 0
            for k,v in pairs(self.followers) do
                if k:HasTag("pig") and k.prefab ~= "bunnyman" then
                    count = count + 1
                end
            end
            return count
        end

        local old_AddFollower = leader.AddFollower
        leader.AddFollower = function(self, follower)
            old_AddFollower(self, follower)

            manager.maxPigFollowers = math.max(manager.maxPigFollowers, self:CountRealPigFollowers())
            manager:DoAchieve({category=categoryName, name="pigfollower"}, {"maxPigFollowers"})

            manager.maxBunnyFollowers = math.max(manager.maxBunnyFollowers, self:CountFollowers("manrabbit"))
            manager:DoAchieve({category=categoryName, name="bunnyfollower"}, {"maxBunnyFollowers"})

            manager.maxRockyFollowers = math.max(manager.maxRockyFollowers, self:CountFollowers("rocky"))
            manager:DoAchieve({category=categoryName, name="lobsterfollower"}, {"maxRockyFollowers"})
        end
    end

    player:ListenForEvent("ka_WitnessHatch", function(inst, data)
        if not manager.hasWitnessedHatch then
            manager.hasWitnessedHatch = true
            manager:DoAchieve({category=categoryName, name="smallbird"}, {"hasWitnessedHatch"})
        end
    end)

    -- obj:PushEvent("ka_DoneTeleporting", {hole=inst})
    player:ListenForEvent("ka_DoneTeleporting", function(inst, data)
        if data and data.hole then
            if data.hole.prefab == "tentacle_pillar_hole" then
                manager.numTeleportedBigTentacle = manager.numTeleportedBigTentacle + 1
                manager:DoAchieve({category=categoryName, name="bigtentacle"}, {"numTeleportedBigTentacle"})
            elseif data.hole.prefab == "wormhole" then
                manager.numTeleportedWormhole = manager.numTeleportedWormhole + 1
                manager:DoAchieve({category=categoryName, name="wormhole"}, {"numTeleportedWormhole"})
            end
        end
    end)

    player:ListenForEvent("ka_TamedBeefalo", function(inst)
        if not manager.hasTamedBeefalo then
            manager.hasTamedBeefalo = true
            manager:DoAchieve({category=categoryName, name="dbeefalo"}, {"hasTamedBeefalo"})
        end
    end)

    player:ListenForEvent("ka_ObtainPotatoCup", function(inst)
        if not manager.hasObtainedPotatoCup then
            manager.hasObtainedPotatoCup = true
            manager:DoAchieve({category=categoryName, name="potatocup"}, {"hasObtainedPotatoCup"})
        end
    end)

    -- self.inst:PushEvent("attacked", { attacker = attacker, damage = damage, damageresolved = damageresolved,
    --                                   original_damage = original_damage, weapon = weapon, stimuli = stimuli,
    --                                   redirected = damageredirecttarget, noimpactsound = self.noimpactsound })
    player:ListenForEvent("attacked", function(inst, data)
        local health = player.components.health
        if health and not health:IsDead() and math.floor(health.currenthealth + 0.5) == 1.0 then
            manager.hasOneHp = true
            manager:DoAchieve({category=categoryName, name="onehp"}, {"hasOneHp"})
        end
    end)


    -- picker:PushEvent("picksomething", { object = self.inst, loot = loot })
    player:ListenForEvent("picksomething", function(inst, data)
        if data.object and data.object.animname == "rose" then
            manager.hasPickedUpRose = true
            manager:DoAchieve({category=categoryName, name="roseflower"}, {"hasPickedUpRose"})
        end
    end)

    player:ListenForEvent("ka_WitnessWere", function(inst, data)
        manager.hasWitnessedWere = true
        manager:DoAchieve({category=categoryName, name="werepig"}, {"hasWitnessedWere"})
    end)

    player:ListenForEvent("ka_PickedTumbleweed", function(inst)
        manager.numPickedTumbleweed = manager.numPickedTumbleweed + 1
        manager:DoAchieve({category=categoryName, name="tumbleweed"}, {"numPickedTumbleweed"})
    end)

    player:ListenForEvent("ka_PickedStatueGlommer", function(inst)
        manager.hasPickedGlommerFlower = true
        manager:DoAchieve({category=categoryName, name="glommer"}, {"hasPickedGlommerFlower"})
    end)

    player:ListenForEvent("ka_HarvestedBeebox", function(inst)
        manager.hasHarvestedBeebox = true
        manager:DoAchieve({category=categoryName, name="beebox"}, {"hasHarvestedBeebox"})
    end)

    player:ListenForEvent("ka_ShavedBeefalo", function(inst)
        manager.hasShavedBeefalo = true
        manager:DoAchieve({category=categoryName, name="shavebeefalo"}, {"hasShavedBeefalo"})
    end)

    player:ListenForEvent("ka_WitnessedKrampusSack", function(inst)
        manager.hasWitnessedKrampusSack = true
        manager:DoAchieve({category=categoryName, name="krampussack"}, {"hasWitnessedKrampusSack"})
    end)

    player:ListenForEvent("ka_OpenedPandorasChest", function(inst)
        manager.hasOpenedPandorasChest = true
        manager:DoAchieve({category=categoryName, name="pandoraschest"}, {"hasOpenedPandorasChest"})
    end)

    player:ListenForEvent("ka_SpawnedKrampus", function(inst)
        manager.hasSpawnedKrampus = true
        manager:DoAchieve({category=categoryName, name="krampus"}, {"hasSpawnedKrampus"})
    end)

    local playerlightningtarget = player.components.playerlightningtarget
    if playerlightningtarget then
        local old_onstrikefn = playerlightningtarget.onstrikefn
        playerlightningtarget.onstrikefn = function(inst)
            if inst.components.health ~= nil and not (inst.components.health:IsDead() or inst.components.health:IsInvincible()) then
                if not inst.components.inventory:IsInsulated() then
                    manager.numStruckByLightning = manager.numStruckByLightning + 1
                    manager:DoAchieve({category=categoryName, name="lightning"}, {"numStruckByLightning"})
                end
            end
            if old_onstrikefn ~= nil then old_onstrikefn(inst) end
        end
    end

    player:ListenForEvent("ka_TeleportedOneself", function(inst)
        manager.hasTeleportedOneself = true
        manager:DoAchieve({category=categoryName, name="purplestaff"}, {"hasTeleportedOneself"})
    end)

    player:ListenForEvent("ka_WitnessedOpalStaff", function(inst)
        manager.hasWitnessedOpalStaff = true
        manager:DoAchieve({category=categoryName, name="opalstaff"}, {"hasWitnessedOpalStaff"})
    end)

    player:ListenForEvent("ka_WitnessedHutchChester", function(inst, which)
        if which == "hutch" then
            manager.hasWitnessedHutch = true
            manager:DoAchieve({category=categoryName, name="hutch"}, {"hasWitnessedHutch"})
        elseif which == "chester" then
            manager.hasWitnessedChester = true
            manager:DoAchieve({category=categoryName, name="chester"}, {"hasWitnessedChester"})
        end
    end)

    player:ListenForEvent("repair", function(inst, which)
        manager.hasSewnItem = true
        manager:DoAchieve({category=categoryName, name="sewitem"}, {"hasSewnItem"})
    end)

    -- harvester:PushEvent("learncookbookrecipe",
    --    {product = self.product, ingredients = self.ingredient_prefabs})
    player:ListenForEvent("learncookbookrecipe", function(inst, data)
        if data and type(data.product) == "string" then
            local varName = "hasCooked_" .. data.product
            if manager[varName] ~= nil then
                manager[varName] = true
                manager:DoAchieve({category=categoryName, name="cookbook"}, {varName})
            end
        end
    end)

    -- self.inst:PushEvent("itemget", { item = inst, slot = nil })
    player:ListenForEvent("itemget", function(inst, data)
        if data and data.item then
            if data.item.prefab == "hermit_cracked_pearl" or data.item.prefab == "hermit_pearl" then
                manager["hasHeldPearl"] = true
                manager:DoAchieve({category=categoryName, name="hermitquest"}, {"hasHeldPearl"})
            elseif data.item.recipetouse ~= nil then    -- blueprints
                for k,_ in pairs(relics) do
                    local varName = "hasLearned_" .. k
                    if not manager[varName] then
                        local bp = player.components.inventory:FindItem(function(v) return v.recipetouse == k end)
                        if bp ~= nil then
                            if player.components.builder:KnowsRecipe(k) then
                                player:PushEvent("ka_LearnRelic", {recipe=k})
                            end
                        end
                    end
                end
            end
        end
    end)

    -- player:PushEvent("ka_DoneFishing", {target=target,reason=reason})
    player:ListenForEvent("ka_DoneFishing", function(inst, data)
        if data.reason == "success" and data.target then
            -- wobster_sheller_land
            print("ka_DoneFishing", data.target.prefab)
            local varName = "hasCaught_" .. data.target.prefab
            if manager[varName] ~= nil then
                manager[varName] = true
                manager:DoAchieve({category=categoryName, name="catchfish"}, {varName})
            end

            manager.timeFastFished = os.time() - player.ka_startFishingTime
            manager:DoAchieve({category=categoryName, name="fastfish"}, {"timeFastFished"})
        end

        player.ka_startFishingTime = nil
    end)

    player.ka_startFishingTime = nil
    -- fisher:PushEvent("ka_StartFishing", {target=target})
    player:ListenForEvent("ka_StartFishing", function(inst, data)
        if player.ka_startFishingTime == nil then
            player.ka_startFishingTime = os.time()
        end
    end)

    -- hasActivatedArchives
    player:ListenForEvent("arhivepoweron", function(inst)
        local x,y,z = player.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, TUNING.KAACHIEVEMENT.ACTIVITY.BROADCAST_RANGE or 30)
        for _,v in pairs(ents) do
            if v.prefab == "archive_switch_base" then
                manager.hasActivatedArchives = true
                manager:DoAchieve({category=categoryName, name="archivespower"}, {"hasActivatedArchives"})
                break
            end
        end
    end, TheWorld)

    -- @Todo: Think of a way to implement it officially instead of hacking Klei's achievements.
    local _AwardPlayerAchievement = AwardPlayerAchievement
    AwardPlayerAchievement = function(name, _player)
        if name == "pacify_forest" and _player == player then
            manager.hasPacifiedForest = true
            manager:DoAchieve({category=categoryName, name="soothtree"}, {"hasPacifiedForest"})
        end
        _AwardPlayerAchievement(name, _player)
    end

    player:ListenForEvent("ka_UseHalloweenPotionMoon", function(inst)
        manager.hasUsedHalloweenPotionMoon = true
        manager:DoAchieve({category=categoryName, name="lunarpotion"}, {"hasUsedHalloweenPotionMoon"})
    end)

    player:ListenForEvent("ka_FailedCooking", function(inst)
        manager.numFailedDish = manager.numFailedDish + 1
        manager:DoAchieve({category=categoryName, name="faileddish"}, {"numFailedDish"})
    end)

    player:ListenForEvent("ka_HearLivinglogScream", function(inst)
        manager.hasHeardLivingLogScream = true
        manager:DoAchieve({category=categoryName, name="livinglog"}, {"hasHeardLivingLogScream"})
    end)

    player:ListenForEvent("learnrecipe", function(inst, data)
        player:PushEvent("ka_LearnRelic", data)
    end)

    player:ListenForEvent("ka_LearnRelic", function(inst, data)
        if data.recipe and relics[data.recipe] == true then
            local varName = "hasLearned_" .. data.recipe
            manager[varName] = true
            manager:DoAchieve({category=categoryName, name="allrelic"}, {varName})
        end
    end)
end

-- SetupCritterFunctions(critter)
local function SetupCritterFunctions(critter)
    critter:DoTaskInTime(0, function()
        local leader = critter.components.follower.leader
        if leader then
            leader:PushEvent("ka_AdopttedCritter", critter)
        end
    end)
end

-- SetupHermitCrabFunctions(pearl)
local function SetupHermitCrabFunctions(pearl)
    -- self.inst:PushEvent("newstate", {statename = statename})
    pearl:ListenForEvent("newstate", function(inst, data)
        if data.statename == "bow" then
            local target = inst.sg.statemem.target
            if target then
                target:PushEvent("ka_BowedTo")
            end
        end
    end)
end

-- SetupOrangeStaffFunctions(staff)
local function SetupOrangeStaffFunctions(staff)
    local blinkstaff = staff.components.blinkstaff
    if blinkstaff then
        -- self.onblinkfn(self.inst, pt, caster)
        local old_onblinkfn = blinkstaff.onblinkfn
        blinkstaff.onblinkfn = function(inst, pt, caster)
            old_onblinkfn(inst, pt, caster)
            if caster:HasTag("player") then
                caster:PushEvent("ka_Blinked", {blinkstaff=inst,pt=pt,caster=caster})
            end
        end
    end
end

-- SetupGreenAmuletFunctions(amulet)
local function SetupGreenAmuletFunctions(amulet)
    local function onequip_green(inst, owner)
        inst.ka_onitembuild = function()
            owner:PushEvent("ka_UsedGreenAmulet", {amulet=inst})
        end
        inst:ListenForEvent("consumeingredients", inst.ka_onitembuild, owner)
    end

    local function onunequip_green(inst, owner)
        inst:RemoveEventCallback("consumeingredients", inst.ka_onitembuild, owner)
    end

    local equippable = amulet.components.equippable
    if equippable then
        local old_onequipfn = equippable.onequipfn
        equippable.onequipfn = function(inst, owner)
            old_onequipfn(inst, owner)
            onequip_green(inst, owner)
        end

        local old_onunequipfn = equippable.onunequipfn
        equippable.onunequipfn = function(inst, owner)
            old_onunequipfn(inst, owner)
            onunequip_green(inst, owner)
        end
    end
end

-- SetupPigKingFunctions(inst)
local function SetupPigKingFunctions(inst)
    local trader = inst.components.trader
    if trader then
        local old_onaccept = trader.onaccept
        trader.onaccept = function(inst, giver, item)
            local is_event_item = IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS) and item.components.tradable.halloweencandyvalue and item.components.tradable.halloweencandyvalue > 0
            if item.components.tradable.goldvalue > 0 or is_event_item then
                if giver then
                    giver:PushEvent("ka_TradedWithPigking", {giver=giver,item=item})
                end
            elseif item.prefab == "pig_token" then
                -- Do nothing
            end
            old_onaccept(inst, giver, item)
        end
    end

    if inst.GetMinigameScore then
        local old_GetMinigameScore = inst.GetMinigameScore
        inst.GetMinigameScore = function(inst)
            local score = old_GetMinigameScore(inst)
            if score >= TUNING.KAACHIEVEMENT.ACTIVITY.PIGKING_MINIGAME_SCORE_MIN then
                BroadcastEvent(inst, TUNING.PIG_MINIGAME_ARENA_RADIUS / 2, "ka_WonPigkingMiniGame")
            end
            return score
        end
    end
end

-- SetupSmallBirdFunctions(inst)
local function SetupSmallBirdFunctions(inst)
    -- Might also use "Hatchable" components to implement this if needed.
    inst.ka_watch_for_hatch = function(inst, data)
        if data.statename == "hatch" then
            BroadcastEvent(inst, TUNING.KAACHIEVEMENT.ACTIVITY.HATCH_WITNESS_RANGE, "ka_WitnessHatch")
            inst:RemoveEventCallback("newstate", inst.ka_watch_for_hatch)
            inst.ka_watch_for_hatch = nil
        end
    end
    -- self.inst:PushEvent("newstate", {statename = statename})
    inst:ListenForEvent("newstate", inst.ka_watch_for_hatch)
end

-- SetupHoleFunctions(inst)
local function SetupHoleFunctions(inst)
    inst:ListenForEvent("doneteleporting", function(inst, obj)
        if obj:HasTag("player") then
            obj:PushEvent("ka_DoneTeleporting", {hole=inst})
        end
    end)
end

-- SetupBeefaloFunctions(inst)
local function SetupBeefaloFunctions(inst)
    -- @Todo: Make it only give trophy to the first rider?
    -- self.inst:PushEvent("domesticated", {tendencies=self.tendencies})
    inst:ListenForEvent("domesticated", function(inst, data)
        BroadcastEvent(inst, TUNING.KAACHIEVEMENT.ACTIVITY.BEEFALO_TAME_RANGE, "ka_TamedBeefalo")
    end)

    local beard = inst.components.beard
    if beard then
        local old_Shave = beard.Shave
        beard.Shave = function(who, withwhat)
            if withwhat and withwhat:HasTag("player") then
                withwhat:PushEvent("ka_ShavedBeefalo")
            end
            old_Shave(who, withwhat)
        end
    end
end

-- SetupPotatoCupFunctions(inst)
local function SetupPotatoCupFunctions(inst)
    local function OnPutInInventory(inst, owner)
        if owner and owner:HasTag("player") then
            owner:PushEvent("ka_ObtainPotatoCup")
        end
    end

    -- self.inst:PushEvent("onputininventory", owner)
    inst:ListenForEvent("onputininventory", OnPutInInventory)

    -- item:PushEvent("onownerputininventory", owner)
    inst:ListenForEvent("onownerputininventory", OnPutInInventory)
end

-- SetupPigmanFunctions(inst)
local function SetupPigmanFunctions(inst)
    -- self.inst:PushEvent("transformwere")
    inst:ListenForEvent("transformwere", function(inst)
        BroadcastEvent(inst, TUNING.KAACHIEVEMENT.ACTIVITY.WEREPIG_WITNESS_RANGE, "ka_WitnessWere")
    end)
end

-- SetupTumbleweedFunctions(inst)
local function SetupTumbleweedFunctions(inst)
    -- self.inst:PushEvent("picked", { picker = picker, loot = loot, plant = self.inst })
    inst:ListenForEvent("picked", function(inst, data)
        if data.picker and data.picker:HasTag("player") then
            data.picker:PushEvent("ka_PickedTumbleweed")
        end
    end)
end

-- SetupStatueGlommerFunctions(inst)
local function SetupStatueGlommerFunctions(inst)
    -- self.inst:PushEvent("picked", { picker = picker, loot = loot, plant = self.inst })
    inst:ListenForEvent("picked", function(inst, data)
        if data.picker and data.picker:HasTag("player") then
            data.picker:PushEvent("ka_PickedStatueGlommer")
        end
    end)
end

-- SetupBeeboxFunctions(inst)
local function SetupBeeboxFunctions(inst)
    local harvestable = inst.components.harvestable
    if harvestable then
        local old_onharvestfn = harvestable.onharvestfn
        harvestable.onharvestfn = function(inst, picker, produce)
            if old_onharvestfn ~= nil then old_onharvestfn(inst, picker, produce) end
            if produce == harvestable.maxproduce and picker and picker:HasTag("player") then
                picker:PushEvent("ka_HarvestedBeebox")
            end
        end
    end
end

-- SetupKrampusSackFunctions(inst)
local function SetupKrampusSackFunctions(inst)
    -- Dropped by krampus
    -- loot:PushEvent("on_loot_dropped", {dropper = self.inst})
    inst:ListenForEvent("on_loot_dropped", function(inst, data)
        BroadcastEvent(inst, TUNING.KAACHIEVEMENT.ACTIVITY.KRAMPUS_SACK_WITNESS_RANGE, "ka_WitnessedKrampusSack")
    end)
end

-- SetupBundleFunctions(inst)
local function SetupBundleFunctions(inst)
    -- Dropped by klaus_sack
    local unwrappable = inst.components.unwrappable
    if unwrappable then
        local old_Unwrap = unwrappable.Unwrap
        unwrappable.Unwrap = function(self, doer)
            for i,v in ipairs(unwrappable.itemdata or {}) do
                if v.prefab == "krampus_sack" then
                    if doer and doer:HasTag("player") then
                        doer:PushEvent("ka_WitnessedKrampusSack")
                    else
                        BroadcastEvent(inst, TUNING.KAACHIEVEMENT.ACTIVITY.KRAMPUS_SACK_WITNESS_RANGE, "ka_WitnessedKrampusSack")
                    end
                    break
                end
            end
            old_Unwrap(self, doer)
        end
    end
end

-- SetupPandorasChestFunctions(inst)
local function SetupPandorasChestFunctions(inst)
    -- self.inst:PushEvent("onopen", {doer = doer})
    inst:ListenForEvent("onopen", function(inst, data)
        local doer = data.doer
        if doer and doer:HasTag("player") then
            doer:PushEvent("ka_OpenedPandorasChest")
        end
    end)
end

-- SetupKrampusFunctions(inst)
local function SetupKrampusFunctions(inst)
    inst:DoTaskInTime(0.1, function(inst)
        local player = inst.spawnedforplayer
        if player then
            player:PushEvent("ka_SpawnedKrampus")
        end
    end)
end

-- SetupTeleStaffFunctions(inst)
local function SetupTeleStaffFunctions(inst)
    local spellcaster = inst.components.spellcaster
    if spellcaster then
        local old_spell = spellcaster.spell
        spellcaster.spell = function(inst, target, pos)
            local caster = inst.components.inventoryitem.owner or target
            if target == caster or target == nil then
                caster:PushEvent("ka_TeleportedOneself")
            end
            old_spell(inst, target, pos)
        end
    end
end

-- SetupMoonBaseFunctions(inst)
local function SetupMoonBaseFunctions(inst)
    local pickable = inst.components.pickable
    if pickable then
        local old_ChangeProduct = pickable.ChangeProduct
        pickable.ChangeProduct = function(self, newProduct)
            -- @Note: If the yellowstaff has skin, self.product will be changed to nil instead of "yellowstaff".
            if newProduct == "opalstaff" then
                BroadcastEvent(inst, TUNING.KAACHIEVEMENT.ACTIVITY.OPALSTAFF_WITNESS_RANGE, "ka_WitnessedOpalStaff")
            end
            old_ChangeProduct(self, newProduct)
        end
    end
end

local function SetupChesterAndHutchFunctions(inst)
    -- self.inst:PushEvent("newstate", {statename = statename})
    inst:ListenForEvent("newstate", function(inst, data)
        if data.statename == "morph" then
            if inst.prefab == "hutch" then
                local current_form = inst.components.amorphous:GetCurrentForm()
                if current_form == "MUSIC" then
                    inst:DoTaskInTime(1.5, function()
                        BroadcastEvent(inst,
                            TUNING.KAACHIEVEMENT.ACTIVITY.HUTCH_WITNESS_RANGE,
                            "ka_WitnessedHutchChester",
                            inst.prefab)
                    end)
                end
            end
        elseif data.statename == "transition" then
            if inst.prefab == "chester" then
                inst:DoTaskInTime(2, function()
                    BroadcastEvent(inst,
                        TUNING.KAACHIEVEMENT.ACTIVITY.CHESTER_WITNESS_RANGE,
                        "ka_WitnessedHutchChester",
                        inst.prefab)
                end)
            end
        end
    end)
end

local function SetupOceanFishingRodFunctions(inst)
    local oceanfishingrod = inst.components.oceanfishingrod
    if oceanfishingrod then
        local _ondonefishing = oceanfishingrod.ondonefishing
        oceanfishingrod.ondonefishing = function(inst, reason, lose_tackle, fisher, target)
            if fisher and fisher:HasTag("player") then
                fisher:PushEvent("ka_DoneFishing", {target=target,reason=reason})
            end
            if _ondonefishing ~= nil then _ondonefishing(inst, reason, lose_tackle, fisher, target) end
        end

        local _oncastfn = oceanfishingrod.oncastfn
        oceanfishingrod.oncastfn = function(inst, fisher, target)
            if fisher and fisher:HasTag("player") then
                fisher:PushEvent("ka_StartFishing", {target=target})
            end
            if _oncastfn ~= nil then _oncastfn(inst, fisher, target) end
        end
    end
end

local function SetupHalloweenPotionMoonFunctions(inst)
    local halloweenpotionmoon = inst.components.halloweenpotionmoon
    if halloweenpotionmoon then
        local _onusefn = halloweenpotionmoon.onusefn
        halloweenpotionmoon.onusefn = function(inst, doer, target, success, transformed_inst, container)
            if success and doer and doer:HasTag("player") then
                doer:PushEvent("ka_UseHalloweenPotionMoon")
            end
            if _onusefn then _onusefn(inst, doer, target, success, transformed_inst, container) end
        end
    end
end

local function SetupLivingLogFunctions(inst)
    local function livinglogScream_cb(inst)
        BroadcastEvent(inst, TUNING.KAACHIEVEMENT.ACTIVITY.BROADCAST_RANGE_HALF, "ka_HearLivinglogScream")
    end

    inst:ListenForEvent("onignite", livinglogScream_cb)

    local fuel = inst.components.fuel
    if fuel then
        local _ontaken = fuel.ontaken
        fuel.ontaken = function(inst, taker)
            if _ontaken ~= nil then _ontaken(inst, taker) end
            livinglogScream_cb(taker)
        end
    end
end

local function SetupStewerFunctions(inst)
    local stewer = inst.components.stewer

    local _ondonecooking = stewer.ondonecooking
    stewer.ondonecooking = function(inst)
        if _ondonecooking ~= nil then _ondonecooking(inst) end
        if stewer.chef_id ~= nil and stewer.product == "wetgoop" then
            local player = UserToPlayer(stewer.chef_id)
            if player then
                player:PushEvent("ka_FailedCooking")
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
    end

    -- Server only.
    if not TheNet:GetIsClient() then
        if inst:HasTag("player") then
            SetupPlayerFunctions(inst)
        elseif inst:HasTag("critter") then
            SetupCritterFunctions(inst)
        elseif inst.prefab == "hermitcrab" then
            SetupHermitCrabFunctions(inst)
        elseif inst.prefab == "orangestaff" then
            SetupOrangeStaffFunctions(inst)
        elseif inst.prefab == "greenamulet" then
            SetupGreenAmuletFunctions(inst)
        elseif inst.prefab == "pigking" then
            SetupPigKingFunctions(inst)
        elseif inst.prefab == "smallbird" then
            SetupSmallBirdFunctions(inst)
        elseif inst.prefab == "tentacle_pillar_hole" or inst.prefab == "wormhole" then
            SetupHoleFunctions(inst)
        elseif inst.prefab == "beefalo" then
            SetupBeefaloFunctions(inst)
        elseif inst.prefab == "trinket_26" then -- potatocup
            SetupPotatoCupFunctions(inst)
        elseif inst:HasTag("pig") and not inst:HasTag("manrabbit") then
            SetupPigmanFunctions(inst)
        elseif inst.prefab == "tumbleweed" then
            SetupTumbleweedFunctions(inst)
        elseif inst.prefab == "statueglommer" then
            SetupStatueGlommerFunctions(inst)
        elseif inst.prefab == "beebox" then
            SetupBeeboxFunctions(inst)
        elseif inst.prefab == "krampus_sack" then
            SetupKrampusSackFunctions(inst)
        elseif inst.prefab == "bundle" then
            SetupBundleFunctions(inst)
        elseif inst.prefab == "pandoraschest" then
            SetupPandorasChestFunctions(inst)
        elseif inst.prefab == "krampus" then
            SetupKrampusFunctions(inst)
        elseif inst.prefab == "telestaff" then
            SetupTeleStaffFunctions(inst)
        elseif inst.prefab == "moonbase" then
            SetupMoonBaseFunctions(inst)
        elseif inst.prefab == "hutch" or inst.prefab == "chester" then
            SetupChesterAndHutchFunctions(inst)
        elseif inst.prefab == "oceanfishingrod" then
            SetupOceanFishingRodFunctions(inst)
        elseif inst.prefab == "halloweenpotion_moon" then
            SetupHalloweenPotionMoonFunctions(inst)
        elseif inst.prefab == "livinglog" then
            SetupLivingLogFunctions(inst)
        end

        if inst.components.stewer ~= nil then
            SetupStewerFunctions(inst)
        end
    end
end

-- RegisterXxxxAchievementEntries(root)
local registerEntriesFuncName = string.format("Register%sAchievementEntries", categoryName)
_G[registerEntriesFuncName] = function(root)
    local function GetNumEquippedWeapons(data)
        return KaGetNumDone(weapons, function(k,v) return data["equipped_" .. k] end)
    end

    local function GetNumCookedFoods(data)
        return KaGetNumDone(allFoods, function(k,v) return data["hasCooked_" .. k] end)
    end

    local function GetNumCaughtOceanFish(data)
        return KaGetNumDone(KaAllFish, function(k,v) return data["hasCaught_" .. k] end)
    end

    local function GetNumLearnedRelics(data)
        return KaGetNumDone(relics, function(k,v) return data["hasLearned_" .. k] end)
    end

    local entries =
    {
        {
            name        = "hermitquest",
            Record      = function(data) return data and data.hasHeldPearl end,
            Check       = function(data) return data and data.hasHeldPearl or false end,
        },
        {
            name        = "cookbook",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumCookedFoods(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumCookedFoods(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumCookedFoods(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
        {
            name        = "faileddish",
            Record      = function(data) return data and data.numFailedDish end,
            Check       = function(data) return data and data.numFailedDish and data.numFailedDish >= TUNING.KAACHIEVEMENT.VALUE.AMOUNT_MEDSMALL end,
            isHidden    = true,
        },
        {
            name        = "catchfish",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumCaughtOceanFish(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumCaughtOceanFish(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumCaughtOceanFish(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
        {
            name        = "fastfish",
            Record      = function(data) return data and data.timeFastFished end,
            RecordLabel =
                function(data)
                    return data and data.timeFastFished ~= 0 and
                        data.timeFastFished > 1 and
                        STRINGS.ACCOMPLISHMENTS.ACTIVITY.FASTFISH_LABEL_PLURAL or
                        STRINGS.ACCOMPLISHMENTS.ACTIVITY.FASTFISH_LABEL
                end,
            Check       =
                function(data)
                    return data and data.timeFastFished and data.timeFastFished ~= 0 and
                        data.timeFastFished <= 30 -- MEDLARGE is now 40.
                end,
        },
        {
            name        = "allweapon",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumEquippedWeapons(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumEquippedWeapons(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumEquippedWeapons(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
        },
        {
            name        = "pigkingmg",
            Record      = function(data) return data and data.hasWonMiniGame end,
            Check       = function(data) return data and data.hasWonMiniGame or false end,
        },
        {
            name        = "critter",
            Record      = function(data) return data and data.hasAdoptedCritter end,
            Check       = function(data) return data and data.hasAdoptedCritter or false end,
        },
        {
            name        = "beecrown",
            Record      = function(data) return data and data.hasBeenBowedTo end,
            Check       = function(data) return data and data.hasBeenBowedTo or false end,
        },
        {
            name        = "bonehelm",
            Record      = function(data) return data and data.hasWornSkeletonHat end,
            Check       = function(data) return data and data.hasWornSkeletonHat or false end,
        },
        {
            name        = "eyebrella",
            Record      = function(data) return data and data.hasWornEyebrellaHat end,
            Check       = function(data) return data and data.hasWornEyebrellaHat or false end,
        },
        {
            name        = "ruinshat",
            Record      = function(data) return data and data.hasWornRuinsHat end,
            Check       = function(data) return data and data.hasWornRuinsHat or false end,
        },
        {
            name        = "foodkill",
            Record      = function(data) return data and data.numKilledByFood end,
            Check       = function(data) return data and data.numKilledByFood and data.numKilledByFood > 0 end,
        },
        {
            name        = "grimgalette",
            Record      = function(data) return data and data.hasDiedToNightmarePie end,
            Check       = function(data) return data and data.hasDiedToNightmarePie or false end,
            isHidden    = true,
        },
        {
            name        = "starvation",
            Record      = function(data) return data and data.numKilledByHunger end,
            Check       = function(data) return data and data.numKilledByHunger and data.numKilledByHunger > 0 end,
        },
        {
            name        = "winterheat",
            Record      = function(data) return data and data.numKilledByHeat end,
            Check       = function(data) return data and data.numKilledByHeat and data.numKilledByHeat > 0 end,
            isHidden    = true,
        },
        {
            name        = "summerfreeze",
            Record      = function(data) return data and data.numKilledByFreeze end,
            Check       = function(data) return data and data.numKilledByFreeze and data.numKilledByFreeze > 0 end,
            isHidden    = true,
        },
        {
            name        = "orangestaff",
            Record      = function(data) return data and data.numBlinked end,
            Check       = function(data) return data and data.numBlinked and data.numBlinked > 0 end,
        },
        {
            name        = "greenamulet",
            Record      = function(data) return data and data.numDiscountedBuild end,
            Check       = function(data) return data and data.numDiscountedBuild and data.numDiscountedBuild > 0 end,
        },
        {
            name        = "alchemy",
            Record      = function(data) return data and data.hasBuiltLab2 end,
            Check       = function(data) return data and data.hasBuiltLab2 or false end,
        },
        {
            name        = "prestihati",
            Record      = function(data) return data and data.hasBuiltLab4 end,
            Check       = function(data) return data and data.hasBuiltLab4 or false end,
        },
        {
            name        = "smanipulator",
            Record      = function(data) return data and data.hasBuiltLab3 end,
            Check       = function(data) return data and data.hasBuiltLab3 or false end,
        },
        {
            name        = "pigking",
            Record      = function(data) return data and data.numTradedWithPigKing end,
            Check       = function(data) return data and data.numTradedWithPigKing and data.numTradedWithPigKing > 0 end,
        },
        {
            name        = "plantflower",
            Record      = function(data) return data and data.numPlantedFlower end,
            Check       = function(data) return data and data.numPlantedFlower and data.numPlantedFlower > 0 end,
        },
        {
            name        = "pigfollower",
            Record      = function(data) return data and data.maxPigFollowers end,
            Check       = function(data) return data and data.maxPigFollowers and data.maxPigFollowers >= TUNING.KAACHIEVEMENT.ACTIVITY.NUM_PIG_FOLLOWERS end,
        },
        {
            name        = "bunnyfollower",
            Record      = function(data) return data and data.maxBunnyFollowers end,
            Check       = function(data) return data and data.maxBunnyFollowers and data.maxBunnyFollowers >= TUNING.KAACHIEVEMENT.ACTIVITY.NUM_BUNNY_FOLLOWERS end,
        },
        {
            name        = "lobsterfollower",
            Record      = function(data) return data and data.maxRockyFollowers end,
            Check       = function(data) return data and data.maxRockyFollowers and data.maxRockyFollowers >= TUNING.KAACHIEVEMENT.ACTIVITY.NUM_ROCKY_FOLLOWERS end,
        },
        {
            name        = "smallbird",
            Record      = function(data) return data and data.hasWitnessedHatch end,
            Check       = function(data) return data and data.hasWitnessedHatch or false end,
        },
        {
            name        = "archivespower",
            Record      = function(data) return data and data.hasActivatedArchives end,
            Check       = function(data) return data and data.hasActivatedArchives or false end,
        },
        {
            name        = "soothtree",
            Record      = function(data) return data and data.hasPacifiedForest end,
            Check       = function(data) return data and data.hasPacifiedForest or false end,
        },
        {
            name        = "bigtentacle",
            Record      = function(data) return data and data.numTeleportedBigTentacle end,
            Check       = function(data) return data and data.numTeleportedBigTentacle and data.numTeleportedBigTentacle > 0 end,
        },
        {
            name        = "wormhole",
            Record      = function(data) return data and data.numTeleportedWormhole end,
            Check       = function(data) return data and data.numTeleportedWormhole and data.numTeleportedWormhole > 0 end,
        },
        {
            name        = "turtle",
            Record      = function(data) return data and data.hasWornLikeTurtle end,
            Check       = function(data) return data and data.hasWornLikeTurtle or false end,
        },
        {
            name        = "dbeefalo",
            Record      = function(data) return data and data.hasTamedBeefalo end,
            Check       = function(data) return data and data.hasTamedBeefalo or false end,
        },
        {
            name        = "pandoraschest",
            Record      = function(data) return data and data.hasOpenedPandorasChest end,
            Check       = function(data) return data and data.hasOpenedPandorasChest or false end,
        },
        {
            name        = "potatocup",
            Record      = function(data) return data and data.hasObtainedPotatoCup end,
            Check       = function(data) return data and data.hasObtainedPotatoCup or false end,
            isHidden    = true,
        },
        {
            name        = "eyeturret",
            Record      = function(data) return data and data.hasBuiltEyeTurret end,
            Check       = function(data) return data and data.hasBuiltEyeTurret or false end,
        },
        {
            name        = "onehp",
            Record      = function(data) return data and data.hasOneHp end,
            Check       = function(data) return data and data.hasOneHp or false end,
            isHidden    = true,
        },
        {
            name        = "beebox",
            Record      = function(data) return data and data.hasHarvestedBeebox end,
            Check       = function(data) return data and data.hasHarvestedBeebox or false end,
        },
        {
            name        = "opalstaff",
            Record      = function(data) return data and data.hasWitnessedOpalStaff end,
            Check       = function(data) return data and data.hasWitnessedOpalStaff or false end,
        },
        {
            name        = "chester",
            Record      = function(data) return data and data.hasWitnessedChester end,
            Check       = function(data) return data and data.hasWitnessedChester or false end,
        },
        {
            name        = "hutch",
            Record      = function(data) return data and data.hasWitnessedHutch end,
            Check       = function(data) return data and data.hasWitnessedHutch or false end,
        },
        {
            name        = "slurper",
            Record      = function(data) return data and data.hasWornSlurperOutOfCave end,
            Check       = function(data) return data and data.hasWornSlurperOutOfCave or false end,
            isHidden    = true,
        },
        {
            name        = "sewitem",
            Record      = function(data) return data and data.hasSewnItem end,
            Check       = function(data) return data and data.hasSewnItem or false end,
        },
        {
            name        = "glommer",
            Record      = function(data) return data and data.hasPickedGlommerFlower end,
            Check       = function(data) return data and data.hasPickedGlommerFlower or false end,
        },
        {
            name        = "krampus",
            Record      = function(data) return data and data.hasSpawnedKrampus end,
            Check       = function(data) return data and data.hasSpawnedKrampus or false end,
        },
        {
            name        = "lunarpotion",
            Record      = function(data) return data and data.hasUsedHalloweenPotionMoon end,
            Check       = function(data) return data and data.hasUsedHalloweenPotionMoon or false end,
        },
        {
            name        = "purplestaff",
            Record      = function(data) return data and data.hasTeleportedOneself end,
            Check       = function(data) return data and data.hasTeleportedOneself or false end,
        },
        {
            name        = "roseflower",
            Record      = function(data) return data and data.hasPickedUpRose end,
            Check       = function(data) return data and data.hasPickedUpRose or false end,
        },
        {
            name        = "werepig",
            Record      = function(data) return data and data.hasWitnessedWere end,
            Check       = function(data) return data and data.hasWitnessedWere or false end,
        },
        {
            name        = "tumbleweed",
            Record      = function(data) return data and data.numPickedTumbleweed end,
            Check       = function(data) return data and data.numPickedTumbleweed and data.numPickedTumbleweed >= 20 end,
        },
        {
            name        = "lightning",
            Record      = function(data) return data and data.numStruckByLightning end,
            Check       = function(data) return data and data.numStruckByLightning and data.numStruckByLightning > 0 end,
            isHidden    = true,
        },
        {
            name        = "shavebeefalo",
            Record      = function(data) return data and data.hasShavedBeefalo end,
            Check       = function(data) return data and data.hasShavedBeefalo or false end,
        },
        {
            name        = "krampussack",
            Record      = function(data) return data and data.hasWitnessedKrampusSack end,
            Check       = function(data) return data and data.hasWitnessedKrampusSack or false end,
        },
        {
            name        = "livinglog",
            Record      = function(data) return data and data.hasHeardLivingLogScream end,
            Check       = function(data) return data and data.hasHeardLivingLogScream or false end,
            isHidden    = true,
        },
        {
            name        = "allrelic",
            Candidates  =
                function(data)
                    local numDone, maxNum, candidates = GetNumLearnedRelics(data)
                    return candidates
                end,
            Record      =
                function(data)
                    local numDone, maxNum = GetNumLearnedRelics(data)
                    return subfmt(STRINGS.ACCOMPLISHMENTS.UI.PROGRESS_FMT, {num=numDone, max=maxNum})
                end,
            Check       =
                function(data)
                    local numDone, maxNum = GetNumLearnedRelics(data)
                    return maxNum ~= 0 and numDone == maxNum
                end,
            isHidden    = true,
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