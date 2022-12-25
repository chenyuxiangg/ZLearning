local fn = require "examples/template_votecontrol"
local ZDEBUG = require("debug/debug")
local _g = GLOBAL

local Widget = require("widgets/widget")

local function DealByKeyK(key, down)
    if not down then
        return
    end
    if _g.TheInput:IsKeyDown(_g.KEY_K) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        ZDEBUG:zprint(urscreen.name)
        if curscreen.name == "screenroot" and ~curscreen.votewindow.open then
            ZDEBUG:zprint("votewindow focus.")
            curscreen:OpenVote()
        else 
            curscreen.votewindow:Hide()
            curscreen.votewindow.open = false
        end
    end
end

local function DealByMouseButton(button, down, x, y)
    -- sim_x,sim_y = TheSim:GetPosition()
    -- screen_pos = _g.TheInput:GetScreenPosition()
    -- world_pos = _g.TheInput:GetWorldPosition()
    -- target = _g.TheInput:GetWorldEntityUnderMouse()
    target = TheSim:GetEntitiesAtScreenPoint(TheSim:GetPosition())
    if target then
        ZDEBUG:zprint("cyx: ")
        for k,v in pairs(target) do
            ZDEBUG:zprint(v)
        end
    end
end

local function Simfn()
    _g.TheInput:AddKeyHandler(DealByKeyK)
    _g.TheInput:AddMouseButtonHandler(DealByMouseButton)
end

AddSimPostInit(Simfn)
AddClassPostConstruct("screens/playerhud", fn)