local ZS = require("screen/zscreenunit")

local vote = function()
    local zs = ZS()
    local v = zs.topmiddle_root:AddChild(Image("images/ui.xml", "votewindow_controller_bottom.tex"))
    TheFrontEnd:PushScreen(zs)
    return zs
end

return vote