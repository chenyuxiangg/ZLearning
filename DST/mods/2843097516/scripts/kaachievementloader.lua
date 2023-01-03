require("kaachievement_utils/utils")

local modName = "KaAchievement"

-- Class KaAchievementLoader
KaAchievementLoader = Class(function(self)
    self.data = nil
    self.entries = {}

    -- Register all entries into loader
    for i,categoryName in ipairs(KAACHIEVEMENT.CATEGORIES) do
        print(modName, string.format("Trying to load category \"%s\"", categoryName))

        -- require("achievements/achievements_xxxx")
        require("achievements/achievements_" .. string.lower(categoryName))

        self:ImportEntries(categoryName)
    end
end)

function KaAchievementLoader:ImportEntries(categoryName)
    -- _G.RegisterFoodAchievementEntries(self.entries)
    _G["Register" .. FirstToUpper(string.lower(categoryName)) .. "AchievementEntries"](self.entries)
end

function KaAchievementLoader:LoadFromClient()
    print("KaAchievementLoader:LoadFromClient()")

    local filename = modName
    local dataToReturn = nil

    -- Read client persistent data and store in the class.
    TheSim:GetPersistentString(filename, function(load_success, data)
        if load_success and data then
            local status, data = pcall(function() return json.decode(data) end)

            -- Create an empty data if the client data does not exist or is not valid
            if not data or type(data) ~= "table" then
                data = {}
            end

            dataToReturn = data

            -- print(modName, 'KaAchievementLoader:Load()', 'client data:', json.encode(data))
        else
            print('Failed to load persistent data', filename)
        end
    end)

    return dataToReturn
end

-- KaAchievementLoader:Load()
-- @return TRUE if data is loaded from server.
function KaAchievementLoader:Load(userid)
    self.data = nil

    print("KaAchievementLoader:Load()", "userid", userid)

    local clientData = self:LoadFromClient() or {}

    if TheWorld and MOD_RPC[modName] then
        local masterSessionId = TheWorld.net.components.shardstate:GetMasterSessionId()

        if clientData[masterSessionId] and clientData[masterSessionId].mark_deleted == true then
            SendModRPCToServer(GetModRPC(modName, "ResetServerData"), userid)
        end

        print("KaAchievementLoader:Load() from server")
        SendModRPCToServer(GetModRPC(modName, "RequestServerData"), userid)
        return true
    else
        self.data = clientData
    end
end

-- KaAchievementLoader:GetData(session_identifier, userid)
-- @param  session_identifier (optional) the identifier of the cluster
-- @return data filtered with session_identifier
function KaAchievementLoader:GetData(session_identifier, userid)
    local loadedFromServer = false

    if self:Load(userid) then
        loadedFromServer = true
    end

    local data = nil

    if not loadedFromServer then
        assert(self.data ~= nil)
        -- dumptable(self.data)
        data = {}

        for k,v in pairs(self.data) do
            if session_identifier == nil or k == session_identifier then
                data[k] = deepcopy(self.data[k])
            end
        end
    end

    return data, loadedFromServer
end

return KaAchievementLoader