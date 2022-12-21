local ZS = require("screen/zscreenunit")
local TEMPLATES = require("widgets/redux/templates")

local curlywin = function()
    local zs = ZS()
    local win = zs.middle_root:AddChild(TEMPLATES.CurlyWindow(100, 100, "win curly", nil, nil, "test"))
    win.fill = zs.middle_root:AddChild(Image("images/fepanel_fills.xml", "panel_fill_tiny.tex"))
    win.fill:SetScale(1.1, .9)
    win.fill:SetPosition(8, 12)
    TheFrontEnd:PushScreen(zs)
    return zs
end

return curlywin