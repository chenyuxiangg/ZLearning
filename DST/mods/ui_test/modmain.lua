local fn = require "examples/template_itemimagetext"
local ZDEBUG = require("debug/debug")
local _g = GLOBAL

local function KillZscreenByKeyK(key, down)
    if not down then
        return
    end
    if _g.TheInput:IsKeyDown(_g.KEY_K) then
        local curscrenn = TheFrontEnd:GetActiveScreen()
        if type(curscrenn) == "ZScreenUnit" then
            ZDEBUG:zprint(self.parent)
        else
            ZDEBUG:zprint(type(curscrenn))
        end
    end
end

local function Simfn()
    _g.TheInput:AddKeyHandler(KillZscreenByKeyK)
end

AddSimPostInit(sim_fn)
AddClassPostConstruct("screens/playerhud", fn)