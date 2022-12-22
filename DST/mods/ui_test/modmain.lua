local fn = require "examples/template_votecontrol"
local ZDEBUG = require("debug/debug")
local _g = GLOBAL

local function KillZscreenByKeyK(key, down)
    if not down then
        return
    end
    if _g.TheInput:IsKeyDown(_g.KEY_K) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "screenroot" and curscreen.votewindow ~= nil then
            ZDEBUG:zprint("clear votewindow focus.")
            curscreen.votewindow:ClearFocus()
        end
    end
end

local function Simfn()
    _g.TheInput:AddKeyHandler(KillZscreenByKeyK)
end

AddSimPostInit(Simfn)
AddClassPostConstruct("screens/playerhud", fn)