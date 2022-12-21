local ZS = require("screen/zscreenunit")
local GetAvatar = require("widgets/bantab").GetAvatar
local GetAvatarAtlas = require("widgets/bantab").GetAvatarAtlas

local header = function()
    local zs = ZS()
    local header_bg = zs.middle_root:AddChild(Image("images/avatars.xml", "avatar_bg.tex"))
    local header_icon = zs.middle_root:AddChild(Image(GetAvatarAtlas("wilson", false), GetAvatar("wilson", false)))
    local header_frame = zs.middle_root:AddChild(Image("images/avatars.xml", "avatar_frame_white.tex"))
    header_frame:SetTint(.5,.5,.5,1)
    TheFrontEnd:PushScreen(zs)
    return zs
end

return header