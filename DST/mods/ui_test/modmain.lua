local fn = require "examples/template_votecontrol"
local ZDEBUG = require("debug/debug")
local _g = GLOBAL

local function DealByKeyK(key, down)
    if not down then
        return
    end
    if _g.TheInput:IsKeyDown(_g.KEY_K) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        ZDEBUG:zprint(urscreen.name)
        if curscreen.name == "screenroot" and curscreen.votewindow ~= nil then
            ZDEBUG:zprint("clear votewindow focus.")
            curscreen.votewindow:ClearFocus()
        end
    end
end

local function Simfn()
    _g.TheInput:AddKeyHandler(DealByKeyK)
    _g.TheInput:AddMouseButtonHandler()
end

AddSimPostInit(Simfn)
AddClassPostConstruct("screens/playerhud", fn)