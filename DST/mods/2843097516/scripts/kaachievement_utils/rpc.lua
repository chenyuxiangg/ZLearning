require("kaachievement_utils/utils")

local modName = "KaAchievement"
local saving = false

_G.KA_DEBUG_RPC = false

local function DebugRpcPrint(...)
    if _G.KA_DEBUG_RPC then
        print(unpack({...}))
    end
end

-- AddClientModRPCHandler(modName, "Say", ...)
-- Server side call: SendModRPCToClient(GetClientModRPC(modName, "Say"), _player.userid, _player, _player.name)
AddClientModRPCHandler(modName, "Say", function(player, message)
    if _G.KA_DEBUG_RPC then
        print(modName, 'Say::', player, message)
        -- if player and name then
        --     player.components.talker:Say(name.." Saved!!")
        -- end
    end
end)

-- KaSaveInClient()
local function KaSaveInClient(save_now)
    if ThePlayer == nil then
        print(modName, "KaSaveInClient()", "ThePlayer == nil. Skipped saving.")
        return
    end

    -- @Todo: Check if we can just delay the save, and only save when there is no new save call in 3 seconds.

    -- Found another saving task. Skip this one.
    if saving then return end
    saving = true

    local function _KaSaveInClient()
        saving = false

        -- Before we save in client. We need to load
        local clientData = GetKaAchievementLoader():LoadFromClient() or {}
        local masterSessionId = TheWorld.net.components.shardstate:GetMasterSessionId()
        if clientData[masterSessionId] and clientData[masterSessionId].mark_deleted == true then
            SendModRPCToServer(GetModRPC(modName, "ResetServerData"), ThePlayer.userid)
        end

        SendModRPCToServer(GetModRPC(modName, "RequestServerData"), ThePlayer.userid)

        local data = {}
        local giveup_time  = 5
        local retry_period = 0.1
        ThePlayer.ka_load_task = ThePlayer:DoPeriodicTask(retry_period, function()
            -- Poll data from loader
            ThePlayer.ka_load_task_counter = (ThePlayer.ka_load_task_counter or 0) + 1
            if GetKaAchievementLoader().data ~= nil then
                local dataFromServer = GetKaAchievementLoader().data
                local dataFromClient = clientData

                -- Merge with the old client save before we store them back
                for k,v in pairs(dataFromServer or {}) do
                    dataFromClient[k] = v
                end

                local compress = true
                TheSim:SetPersistentString(modName, json.encode(dataFromClient), compress)
                ThePlayer.ka_load_task:Cancel()
                ThePlayer.ka_load_task = nil
            elseif ThePlayer.ka_load_task_counter > (giveup_time / retry_period) then
                -- assert(false and "Cannot save client data. Failed to request from server.")
                print(modName, "[Error] Cannot save client data. Failed to request from server.")
            end
        end)
    end

    local delay = TUNING.KAACHIEVEMENT.RPC.SAVE_DELAY
    if save_now or delay == 0 then
        print(modName, "KaSaveInClient()", "Save now.")
        _KaSaveInClient()
    else
        print(modName, "KaSaveInClient()", "Save in 3 seconds.")
        ThePlayer:DoTaskInTime(delay, _KaSaveInClient)
    end
end

-- AddClientModRPCHandler(modName, "SaveInClient", ...)
-- Server side call: SendModRPCToClient(GetClientModRPC(modName, "SaveInClient"), _player.userid, save_now)
AddClientModRPCHandler(modName, "SaveInClient", function(save_now)
    KaSaveInClient(save_now)
end)

-- KaCallClientSave(player)
--
-- Unified function for both server/client to save client data.
-- The function will detect wheather it's server or client and do the corresponding works.
--
-- @param player (optional) the specific client to send RPC to.
function KaUnifiedClientSave(player, save_now)
    if TheNet:GetIsClient() then
        KaSaveInClient(save_now)
    else
        for i, _player in ipairs(AllPlayers) do
            if player == nil or player.userid == _player.userid then
                SendModRPCToClient(GetClientModRPC(modName, "Say"), _player.userid, _player, _player.name)
                SendModRPCToClient(GetClientModRPC(modName, "SaveInClient"), _player.userid, save_now)
            end
        end
    end
end

-- AddClientModRPCHandler(modName, "ClientPopUp", ...)
-- Server side call: SendModRPCToClient(GetClientModRPC(modName, "ClientPopUp"), _player.userid, category, name)
AddClientModRPCHandler(modName, "ClientPopUp", function(category, name)
    local data =
    {
        category = category,
        name     = name,
    }

    local popupWidget = GetKaAchievementPopupWidget(TheFrontEnd and TheFrontEnd:GetActiveScreen())
    if popupWidget then
        popupWidget:PushBack(data)
    else
        print(modName, "ClientPopUp: popupWidget is nil")
        print(debugstack())
    end
end)

-- AddClientModRPCHandler(modName, "ClientAnnounceTrophy", ...)
-- Server side call: SendModRPCToClient(GetClientModRPC(modName, "ClientAnnounceTrophy"), _player.userid, userid, category_name, trophy_name)
AddClientModRPCHandler(modName, "ClientAnnounceTrophy", function(userid, category_name, trophy_name)
    local player = UserToPlayer(userid)
    local player_name = player and player.name or ""
    local trophy_packet_json = json.encode({userid=userid, category_name=category_name, trophy_name=trophy_name})
    DebugRpcPrint("RPC: ClientAnnounceTrophy:", player_name, trophy_packet_json)

    if player then
        if GetKaAchievementSettings().announceTrophy then
            local player_colour = player and player.playercolour or GOLD
            local sender_userid = userid
            local sender_netid = TheNet:GetNetIdForUser(userid)
            KaTrophyAnnounce(player_name, player_colour, trophy_packet_json, sender_userid, sender_netid)
        else
            print("RPC: ClientAnnounceTrophy:", "announceTrophy is OFF, skip announcement.", trophy_packet_json)
        end
    else
        print("RPC: ClientAnnounceTrophy:", "player == nil", trophy_packet_json)
    end
end)

local function GetDataToSend(player)
    assert(player ~= nil)

    local manager = player.components.kaAchievementManager

    local dataToSend =
    {
        servername   = TheNet:GetServerName(),
        serverdesc   = tostring(TheNet:GetServerDescription()),
        userid       = player.userid,
        name         = player.name,
        prefab       = player.prefab,
        data         = {},
        last_updated = os.time(),
    }

    -- Save the player's KaAchievementManager data
    for i,v in ipairs(manager.variables) do
        dataToSend.data[v] = manager[v]
    end

    -- Save the player icon related data
    for _,client in ipairs(TheNet:GetClientTable() or {}) do
        if player.userid == client.userid and ((client.performance == nil) or TheNet:GetServerIsClientHosted()) then
            dataToSend.client =
            {
                prefab      = client.prefab,
                userflags   = client.userflags,
                base_skin   = client.base_skin,
                name        = client.name,
                colour      = client.colour
            }
            break
        end
    end

    local masterSessionId = TheWorld.net.components.shardstate:GetMasterSessionId()
    dataToSend = {[masterSessionId] = dataToSend}

    -- dumptable(dataToSend, 1, 1)

    return dataToSend
end

-- AddModRPCHandler(modName, "ResetServerData", ...)
-- Client side call: SendModRPCToServer(GetModRPC(modName, "ResetServerData"), requested_id)
AddModRPCHandler(modName, "ResetServerData", function(requester_player, requested_id)
    DebugRpcPrint("RPC: ResetServerData()", "requester_player", requester_player)
    DebugRpcPrint("RPC: ResetServerData()", "requested_id", requested_id)

    assert(requester_player.userid == requested_id)

    requester_player.components.kaAchievementManager:Reset()
    DebugRpcPrint("RPC: ResetServerData()", string.format("Player (%s) is reset.", tostring(requested_id)))
end)

-- AddModRPCHandler(modName, "RequestServerData", ...)
-- Client side call: SendModRPCToServer(GetModRPC(modName, "RequestServerData"), requested_id)
AddModRPCHandler(modName, "RequestServerData", function(requester_player, requested_id)
    DebugRpcPrint("RPC: RequestServerData()", "requester_player", requester_player)
    DebugRpcPrint("RPC: RequestServerData()", "requested_id", requested_id)

    local player = UserToPlayer(requested_id)
    if player then
        DebugRpcPrint("RPC: RequestServerData()", string.format("Player (%s) is found. Return directly.", tostring(requested_id)))
        local dataToSend = GetDataToSend(player)
        SendModRPCToClient(GetClientModRPC(modName, "RespondServerData"), requester_player.userid, json.encode(dataToSend))
    else
        DebugRpcPrint("RPC: RequestServerData()", string.format("Player (%s) is not found. Broadcast the request to all shards.", tostring(requested_id)))
        SendModRPCToShard(GetShardModRPC(modName, "RequestServerDataBroadcast"), nil, requester_player.userid, requested_id)
    end
end)

-- AddShardModRPCHandler(modName, "RequestServerDataBroadcast", ...)
-- Broadcast server call: SendModRPCToShard(GetShardModRPC(modName, "RequestServerDataBroadcast"), sender_list, requester_id, requested_id)
AddShardModRPCHandler(modName, "RequestServerDataBroadcast", function(sender, requester_id, requested_id)
    DebugRpcPrint("RPC: RequestServerDataBroadcast()", "sender", sender)
    DebugRpcPrint("RPC: RequestServerDataBroadcast()", "requester_id", requester_id)
    DebugRpcPrint("RPC: RequestServerDataBroadcast()", "requested_id", requested_id)

    local player  = UserToPlayer(requested_id)

    if player then
        DebugRpcPrint("RPC: RequestServerDataBroadcast()", string.format("Player (%s) is found in shard (%s). Respond to the requester shard (%s).", tostring(requested_id), tostring(TheShard:GetShardId()), tostring(sender)))
        local dataToSend = GetDataToSend(player)
        SendModRPCToShard(GetShardModRPC(modName, "RespondServerDataBroadcast"), sender, requester_id, json.encode(dataToSend))
    else
        DebugRpcPrint("RPC: RequestServerDataBroadcast()", string.format("Player (%s) is not found in shard (%s). Drop in this shard.", tostring(requested_id), tostring(TheShard:GetShardId())))
    end
end)

-- AddShardModRPCHandler(modName, "RespondServerDataBroadcast", ...)
-- Responder server call: SendModRPCToShard(GetShardModRPC(modName, "RespondServerDataBroadcast"), sender, requester_id, data_str)
-- @Note: Specifying "sender" because we only need to respond to the sender shard where the requester is in. There is no need to broadcast to all.
AddShardModRPCHandler(modName, "RespondServerDataBroadcast", function(sender, requester_id, data_str)
    DebugRpcPrint("RPC: RespondServerDataBroadcast()", "sender", sender)
    DebugRpcPrint("RPC: RespondServerDataBroadcast()", "requester_id", requester_id)
    SendModRPCToClient(GetClientModRPC(modName, "RespondServerData"), requester_id, data_str)
end)

-- AddClientModRPCHandler(modName, "RespondServerData", ...)
-- Server side call: SendModRPCToClient(GetClientModRPC(modName, "RespondServerData"), _player.userid, data_str)
AddClientModRPCHandler(modName, "RespondServerData", function(data_str)
    DebugRpcPrint("RPC: RespondServerData()", "data_str")
    -- DebugRpcPrint("RPC: RespondServerData()", "data_str", string.sub(data_str, 0, 100))
    GetKaAchievementLoader().data = json.decode(data_str)
    -- dumptable(GetKaAchievementLoader().data, 1, 1)
end)


--[[
Senario: Player A client asks for the stats of Player B who is in the other shard:

1. Player A client -> Shard #0: RequestServerData()
2. Shard #0 checks Player B is not available, broadcast the request.
3. Shard #0 -> All Shards: RequestServerDataBroadcast()
4. Shard #X drops the request since the player is not available.
5. Shard #1 generates packet.
6. Shard #1 -> Shard #0: RespondServerDataBroadcast()
7. Shard #0 -> Player A client: RespondServerData()

                          Player A
                             | ^
        RequestServerData()  | | RespondServerData()
                             | |
                             v |        RequestServerDataBroadcast()
                         Shard #0  ----------------------------------->  Shard #X (Drop it since the player is not available.)
                             | ^
                             | |
RequestServerDataBroadcast() | |  RespondServerDataBroadcast()
                             | |
                             v |
                         Shard #1 (where Player B is)

--]]