require("kaachievement_utils/rpc")

local modName = "KaAchievement"

-- Class KaAchievementManager
local KaAchievementManager = Class(
    nil,
    function(self, player)
        self.player    = player
        self.variables = {}
        self.initVals  = {}
        self.isDirty   = false

        for category_name,category_entries in pairs(GetKaAchievementLoader().entries) do
            for _,v in ipairs(category_entries) do
                if v.name then
                    local completedVarName = GetCompletedVarName(category_name, v.name)
                    table.insert(self.variables, completedVarName)
                    -- print(completedVarName)
                end
            end
        end
    end,
    {}
)

-- KaAchievementManager:OnSave()
function KaAchievementManager:OnSave()
    -- print(modName, "OnSave()")
    local data = {}
    for i,v in ipairs(self.variables) do
        -- print(i, v, self[v])
        data[v] = self[v]
    end
    return data
end

-- KaAchievementManager:OnLoad(...)
function KaAchievementManager:OnLoad(data)
    -- print(modName, "Onload()")
    for i,v in ipairs(self.variables) do
        -- print(i, v, data[v])
        if data[v] then
            self[v] = data[v]
        end
    end
end

-- KaAchievementManager:Reset()
function KaAchievementManager:Reset()
    -- print(modName, "Reset()")
    for i,v in ipairs(self.variables) do
        if self.initVals[v] ~= nil then
            -- print(i, v, string.format("%s is reset to %s", tostring(v), tostring(self.initVals[v])))
            self[v] = self.initVals[v]
        else
            -- print(i, v, string.format("%s does not have initial value. Set to nil.", tostring(v)))
            self[v] = nil
        end
    end
end

-- function GetAchievedTime()
local function GetAchievedTime()
    local data =
    {
        cycles = TheWorld.state.cycles, -- integer
        seg    = TheWorld.state.time,   -- value range in [0, 1)
        irl    = os.time(),
    }
    return data
end

-- KaAchievementManager:DoAchieve(...)
function KaAchievementManager:DoAchieve(trophyData, varNameList)
    for _,varName in pairs(varNameList or {}) do
        local varVal = self[varName]
        local announceMessage = string.format("%s: %s: %s", tostring(self.player and self.player.name), tostring(varName), tostring(varVal))

        print(modName, tostring(self.player), tostring(self.player and self.player.name), announceMessage)
        -- TheNet:Announce(announceMessage)
    end

    trophyData = trophyData or {}
    print(modName, "DoAchieve()", trophyData.category, trophyData.name)

    for kk,vv in pairs(GetKaAchievementLoader().entries) do
        if trophyData.category == nil or trophyData.category == kk or kk == "Mastery" then
            for _,v in ipairs(vv) do
                if trophyData.name == nil or v.name == trophyData.name or kk == "Mastery" then
                    local completedVarName = GetCompletedVarName(kk, v.name)

                    local pass = v.Check(self)

                    -- Only log when changed.
                    if kk ~= "Mastery" or ((not self[completedVarName]) ~= (not pass)) then
                        print(modName, "Check " .. tostring(v.name) .. " (before, after):", tabletodictstring(self[completedVarName]), pass)
                    end

                    -- If haven't passed ever, check if pass this time.
                    if pass then
                        if not self[completedVarName] then
                            print(modName, string.format("Passed. Set %s to true", completedVarName))
                            SendModRPCToClient(GetClientModRPC(modName, "ClientPopUp"), self.player.userid, kk, v.name)
                            self[completedVarName] = GetAchievedTime()
                            KaBroadcastAnnounceTrophy(self.player.userid, kk, v.name)
                            self.isDirty = true
                        end
                    else
                        if self[completedVarName] ~= nil then
                            print(modName, string.format("Reset %s to nil", completedVarName))
                            self[completedVarName] = nil
                            self.isDirty = true
                        end
                    end

                    if trophyData.name ~= nil and kk ~= "Mastery" then
                        -- No need to search. Break the loop.
                        break
                    end
                end
            end
        end
    end

    print(modName, "self.isDirty", self.isDirty)

    if self.isDirty == true then
        local save_now = false
        KaUnifiedClientSave(self.player, save_now)
    end

    self.isDirty = false
end

-- KaAchievementManager:GetInitVal(...)
-- ThePlayer.components.kaAchievementManager:GetInitVal("numKilledPig")
function KaAchievementManager:GetInitVal(name)
    return self.initVals[name]
end

-- KaAchievementManager:DebugReset(...)
-- ThePlayer.components.kaAchievementManager:DebugReset("numKilledPig")
function KaAchievementManager:DebugReset(name)
    self:DebugSet(name, self:GetInitVal(name))
end

-- KaAchievementManager:DebugSet(...)
-- ThePlayer.components.kaAchievementManager:DebugSet("numKilledPig", 99)
function KaAchievementManager:DebugSet(name, value)
    if self[name] ~= nil then
        self[name] = value
        print(modName, string.format("\"%s\" is set to %s.", name, tostring(value)))
    else
        print(modName, string.format("\"%s\" is not a valid variable name.", name))
    end
end

-- KaAchievementManager:RegisterVariable(...)
function KaAchievementManager:RegisterVariable(name, initVal)
    print(modName, "RegisterVariable()", name)

    table.insert(self.variables, name)
    self._[name] =
    {
        initVal,
        function(self, value)
            if self.player.kaAchievementData[name]:value() ~= value then
                self.isDirty = true
                self.player.kaAchievementData[name]:set(value)
            end
        end
    }

    -- Store the initialization mod
    self.initVals[name] = initVal
end

return KaAchievementManager
