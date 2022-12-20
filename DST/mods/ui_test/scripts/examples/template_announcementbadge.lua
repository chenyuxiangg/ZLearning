local ZS = require("screen/zscreenunit")
local TEMPLATES = require("widgets/redux/templates")

local badge = function()
    local bdg = TEMPLATES.AnnouncementBadge()
    local zs = ZS()
    zs.topmiddle_root:AddChild(bdg)
    TheFrontEnd:PushScreen(zs)
    return zs
end

return badge