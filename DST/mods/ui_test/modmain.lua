local ZDEBUG = require("debug/debug")
local Zthoughtpanel = require("screen/zthoughtpanel")
local WIDGET = require("widgets/widget")
local fn = require("examples/template_votecontrol")
local _g = GLOBAL

-- local fn = function(self)
--     self.ztopmiddle_root = self:AddChild(WIDGET("ZTopMiddleRoot"))
--     self.ztopmiddle_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
--     self.ztopmiddle_root:SetHAnchor(ANCHOR_MIDDLE)
--     self.ztopmiddle_root:SetVAnchor(ANCHOR_TOP)
--     self.ztopmiddle_root:SetMaxPropUpscale(MAX_HUD_SCALE)
--     self.ztopmiddle_root = self.ztopmiddle_root:AddChild(WIDGET("real_ZTopMiddleRoot"))

--     self.zthoughtpanel = self.ztopmiddle_root:AddChild(Zthoughtpanel(self))
--     local testStr = "这是一个文本测试,来自于Z.测试时间:2022年12月25日,星期天.hahahahahahahahahahahha,小赤佬,我是小帅翔,帅翔帅翔帅翔."
--     self.zthoughtpanel:setText(testStr)
    
--     return self.zthoughtpanel
-- end

local function DealByKeyK(key, down)
    if not down then
        return
    end
    if _g.TheInput:IsKeyDown(_g.KEY_K) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.zthoughtpanel then
            if not curscreen.zthoughtpanel.open then
                curscreen.zthoughtpanel:slideOut()
            else
                curscreen.zthoughtpanel:slideIn()
            end
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_G) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.zthoughtpanel then
            if curscreen.zthoughtpanel.open then
                curscreen.zthoughtpanel:updatePos("l")
            end
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_H) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.zthoughtpanel then
            if curscreen.zthoughtpanel.open then
                curscreen.zthoughtpanel:updatePos("r")
            end
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_Z) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.zthoughtpanel then
            if curscreen.zthoughtpanel.open then
                curscreen.zthoughtpanel:updateFontSize("+")
            end
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_X) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.zthoughtpanel then
            if curscreen.zthoughtpanel.open then
                curscreen.zthoughtpanel:updateFontSize("-")
            end
        end
    elseif _g.TheInput:IsKeyDown(_g.KEY_B) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        if curscreen.name == "HUD" and curscreen.zthoughtpanel then
            if curscreen.zthoughtpanel.open then
                curscreen.zthoughtpanel:getInfo()
            end
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