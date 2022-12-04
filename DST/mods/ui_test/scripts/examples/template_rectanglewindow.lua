local TEMPLATES = require("widgets/redux/templates")

local rectanglewindow = function(self)
    function self:ShowRectangleWindow()
        self.rectwindow = TEMPLATES.RectangleWindow(0, 0, "z_rect_templates", nil, nil, "from zyzs.")
        self.rectwindow:SetPosition(300, 300)
        TheFrontEnd:PushScreen(self.rectwindow)
        return self.rectwindow
    end

    function self:CloseRectangelWindow()
        if self.rectwindow then
            TheFrontEnd:PopScreen(self.rectwindow)
        end
        self.rectwindow = nil
    end

    self.openbtn = self:AddChild(TEMPLATES.StandardButton(function() self:ShowRectangleWindow() end, "open", {100, 50}, nil))
    self.closebtn = self:AddChild(TEMPLATES.StandardButton(function() self:CloseRectangelWindow() end, "close", {100, 50}, nil))
    self.openbtn:SetPosition(100, 100)
    self.closebtn:SetPosition(100,150)
end

return rectanglewindow