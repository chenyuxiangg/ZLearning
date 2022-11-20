local TEMPLATE = require("widgets/redux/templates")

local function _ctor_(root, owner, data)
    Screen._ctor(root, "TestPanel")
    root.owner = owner
    root.panel = root:AddChild(TEMPLATE.RectangleWindow(0, 0, "Test_UI", data["bottom_buttons"]))
end

local data = {
    ["bottom_buttons"] = {
        {text = "Add", cb = function() end, offset = nil},
        {text = "Close", cb = function() end, offset = nil}
    }
}
local TestPanel = class(Screen, _ctor_(self, owner, data))
