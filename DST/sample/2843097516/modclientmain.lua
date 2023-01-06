local _G                   = GLOBAL
local modName              = "KaAchievement"
local screenname           = modName

_G.TheKaAchievementLoader = nil
require("kaachievement_utils/utils")
_G.TheKaAchievementLoader = _G.GetKaAchievementLoader()

-- Mod Assets.
Assets =
{
    Asset("IMAGE", "images/achievementsimages/achievements_images.tex"),
    Asset("ATLAS", "images/achievementsimages/achievements_images.xml"),

    Asset("IMAGE", "images/achievementsimages/achievements_buttons.tex"),
    Asset("ATLAS", "images/achievementsimages/achievements_buttons.xml"),

    Asset("IMAGE", "images/achievementsimages/achievements_bg_black.tex"),
    Asset("ATLAS", "images/achievementsimages/achievements_bg_black.xml"),
}

-- AddClassPostConstruct("screens/redux/compendiumscreen", ...)
AddClassPostConstruct("screens/redux/compendiumscreen", function(self)
    local menubutton = self.subscreener:MenuButton(_G.STRINGS.ACCOMPLISHMENTS.UI.TITLE, screenname, _G.STRINGS.ACCOMPLISHMENTS.UI.DESC, self.tooltip)

    local panel = require("widgets/kaachievementsclusterpanel")()
    panel:Hide()

    self.subscreener.sub_screens[screenname] = self.panel_root:AddChild(panel)
    self.subscreener.menu:AddCustomItem(menubutton)

    -- Set as default selection.
    -- self.subscreener:OnMenuButtonSelected(screenname)
end)

_G.TheInput:AddKeyHandler(_G.KaAchievementKeyHandler)

print(modName, "Loaded modclientmain.lua")
