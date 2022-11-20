local TestPanel = Global.require("screen/panel")

local function ShowPanel()

end

local function func(hud)
    hud.openbutton = hud:AddChild(TEMPLATE.StandardButton(onclick=ShowPanel(), txt="Open", size={100, 50}))
    hud.openbutton.SetVAnchor(ANCHOR_TOP)
    hud.openbutton.SetHAnchor(ANCHOR_MIDDLE)
    hud.openbutton.SetScaleMode(SCALEMODE_PROPORTIONAL)

end

AddClassPostConstruct("screens/playerhud", func)