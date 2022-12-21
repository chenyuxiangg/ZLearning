local ZS = require("screen/zscreenunit")

local header = function()
    local zs = ZS()
    local header_bg = zs.middle_root:AddChild(Image("images/avatars.xml", "avatar_bg.tex"))
    local header_icon = zs.middle_root:AddChild(Image("images/avatars/avatar_wilson.xml", "avatar_wilson.tex"))
    local header_frame = zs.middle_root:AddChild(Image("images/avatars.xml", "avatar_frame_white.tex"))
    header_frame:SetTint(.5,.5,.5,1)
    TheFrontEnd:PushScreen(zs)
    return zs
end

return header