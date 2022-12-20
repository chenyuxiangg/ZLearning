local ZS = require("screen/zscreenunit")
local TEMPLATES = require("widgets/redux/templates")

local curlywin = function()
    local win = TEMPLATES.CurlyWindow(100, 100, "win curly", nil, nil, "test")
    local zs = ZS()
    zs.right_root:AddChild(win)
    TheFrontEnd:PushScreen(zs)
    return zs
end

return curlywin