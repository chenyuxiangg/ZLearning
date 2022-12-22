local ZS = require("screen/zscreenunit")

local vote = function()
    local zs = ZS()
    local v = zs.topmiddle_root:AddChild(Image("images/ui.xml", "votewindow_controller_bottom.tex"))
    v:SetPosition(0, -50, 0)
    v:SetScale(2, 1.5, 1)
    TheFrontEnd:PushScreen(zs)
    return zs
end

return vote