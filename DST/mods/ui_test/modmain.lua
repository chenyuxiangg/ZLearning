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
        ZDEBUG:zprint(curscreen.name)
        if curscreen.name == "HUD" and curscreen.votewindow then
            if not curscreen.votewindow.open then
                ZDEBUG:zprint("votewindow focus.")
                curscreen:OpenVote()
            else
                curscreen.votewindow:Hide()
                curscreen.votewindow.open = false
            end
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_G) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.votewindow then
            curscreen:UpdateHeaderInfo("x", "add")
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_H) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.votewindow then
            curscreen:UpdateHeaderInfo("y", "add")
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_J) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.votewindow then
            curscreen:UpdateHeaderInfo("sx", "add")
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_L) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.votewindow then
            curscreen:UpdateHeaderInfo("sy", "add")
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_Z) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.votewindow then
            curscreen:UpdateHeaderInfo("x", "sub")
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_X) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.votewindow then
            curscreen:UpdateHeaderInfo("y", "sub")
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_C) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.votewindow then
            curscreen:UpdateHeaderInfo("sx", "sub")
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_V) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.votewindow then
            curscreen:UpdateHeaderInfo("sy", "sub")
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_B) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.votewindow then
            curscreen:GetHeaderInfo()
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