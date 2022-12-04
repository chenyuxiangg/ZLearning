local TEMPLATES = require("widgets/redux/templates")

local rectanglewindow = function(self)
    function self:ShowRectangleWindow()
        local btngroups = {
            {text = "close", cb = function() self:CloseRectangelWindow() end, offset = nil}
        }
        self.rectwindow = self:AddChild(TEMPLATES.RectangleWindow(0, 0, "z_rect_templates", btngroups, nil, "from zyzs."))

        function self.rectwindow:OnBecomeActive()
            TheSim:SetUIRoot(self.inst.entity)
            if self.last_focus and self.last_focus.inst.entity:IsValid() then
                self.last_focus:SetFocus()
            else
                self.last_focus = nil
                if self.default_focus then
                    self.default_focus:SetFocus()
                end
            end
        end

        function self.rectwindow:OnBecomeInactive()
            self.last_focus = self:GetDeepestFocus()
        end

        function self.rectwindow:OnUpdate(dt)
            return true
        end
            
        function self.rectwindow:OnDestroy()
            self:Kill()
        end

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
    self.openbtn:SetPosition(100, 100)
end

return rectanglewindow