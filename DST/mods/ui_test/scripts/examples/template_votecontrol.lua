local ZS = require("screen/zscreenunit")

local vote = function()
    local zs = ZS()
    local v = zs.topmiddle_root:AddChild(Image("images/ui.xml", "votewindow_controller_bottom.tex"))
    v:SetPosition(0, -200, 0)
    TheFrontEnd:PushScreen(zs)
    return zs
end

return vote