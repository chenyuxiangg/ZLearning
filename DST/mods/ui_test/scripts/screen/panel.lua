local TEMPLATES = require "widgets/redux/templates"
local Screen = require "widgets/screen"

local TestPanel = Class(Screen, function(self, owner)
    Screen._ctor(self, "TestPanel")
    self.owner = owner

    function self:Destory()
        if self then
            TheFrontEnd:PopScreen(self)
        end
    end

    self.panel = self:AddChild(TEMPLATES.RectangleWindow(400, 500, "Destination", {
        {text = "Close", cb = function() self:Destory() end, offset = nil},
    }))
end)

return TestPanel