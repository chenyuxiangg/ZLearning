local fn = require "examples/template_votecontrol"
local ZDEBUG = require("debug/debug")
local _g = GLOBAL

require("widgets/widget")

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

local function OnMouseButton(self, button, down, x, y)
    if self.name ~= nil then
        ZDEBUG:zprint("cyx: " .. self.name)
    end
    if not self.focus then return false end

    for k,v in pairs (self.children) do
        if v.focus and v:OnMouseButton(button, down, x, y) then return true end
    end
end

local function Simfn()
    _g.TheInput:AddKeyHandler(DealByKeyK)
    _g.TheInput:AddMouseButtonHandler()
    Widget:OnMouseButton = OnMouseButton
end

AddSimPostInit(Simfn)
AddClassPostConstruct("screens/playerhud", fn)