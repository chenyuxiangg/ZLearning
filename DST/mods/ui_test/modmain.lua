local TMIIT = require "examples/template_itemimagetext"
local TMIB = require "examples/template_iconbutton"
local ZDEBUG = require("debug/debug")
local _g = GLOBAL

local function KillZscreenByKeyK(key, down)
    if not down then
        return
    end
    local curscrenn = TheFrontEnd:GetActiveScreen()
    if string.match(curscrenn.name, "Zscreen") == curscrenn.name then
        ZDEBUG:zprint("zs pop.")
        TheFrontEnd:PopScreen(curscrenn)
    end
    if _g.TheInput:IsKeyDown(_g.KEY_K) then
        ZDEBUG:zprint("K is down, zs push.")
        TMIIT()
    elseif _g.TheInput:IsKeyDown(_g.KEY_L) then
        ZDEBUG:zprint("L is down, zs push")
        TMIB()
    end
end

local function Simfn()
    _g.TheInput:AddKeyHandler(KillZscreenByKeyK)
end

AddSimPostInit(Simfn)
-- AddClassPostConstruct("screens/playerhud", fn)