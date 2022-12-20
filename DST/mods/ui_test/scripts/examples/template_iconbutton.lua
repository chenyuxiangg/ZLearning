local ZS = require("screen/zscreenunit")
local TEMPLATES = require("widgets/redux/templates")

local iconbutton = function()
    local iconb = TEMPLATES.IconButton("images/button_icons.xml", "player_info.tex", "test ib", false, false, function() end)
    local zs = ZS()
    zs.right_root:AddChild(iconb)
    TheFrontEnd:PushScreen(zs)
    return zs
end

return iconbutton