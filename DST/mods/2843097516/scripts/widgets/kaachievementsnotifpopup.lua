local Widget = require("widgets/widget")
local Image = require("widgets/image")
local Text = require("widgets/text")
local easing = require("easing")
local TEMPLATES = require("widgets/redux/templates")

local scale = 1
local fade_pos = Vector3(0, 0)
local pop_alpha = 1.0
local fade_alpha = 0.0
local rect_w, rect_h = 429 * scale, 104 * scale
local text_extra_offset_x = -5 * scale

-- Class KaAchievementsNotifPopUp
local KaAchievementsNotifPopUp = Class(Widget, function(self, player)
    Widget._ctor(self, "KaAchievementsNotifPopUp")

    self.player = player
    self.queue = {}

    -- The root should scale with the UI proportionally
    self.root = self:AddChild(Widget("KaAchievementsNotifPopUp_ROOT"))
    self.root:SetVAnchor(ANCHOR_BOTTOM)
    self.root:SetHAnchor(ANCHOR_MIDDLE)
    self.root:SetScaleMode(SCALEMODE_PROPORTIONAL)

    -- The group is the entire group of images/buttons/rectangles, moving up and down.
    self.group = self.root:AddChild(Widget("KaAchievementsNotifPopUp_GROUP"))

    self.alpha = pop_alpha

    -- Adai: ImageButton will have a stupid clicking sound and the button-down animation.
    self.rect = self.group:AddChild(Image("images/achievementsimages/achievements_bg_black.xml", "achievements_bg_black.tex"))
    self.rect:ScaleToSize(rect_w, rect_h)
    self.rect:SetTint(0,0,0,0.8)
    self.rect:SetPosition(0,0)

    local icon_size = 60 * scale
    local icon_padding = (rect_h - icon_size)/2
    local icon_x = -rect_w/2 + icon_size/2 + icon_padding
    self.icon = self.group:AddChild(Image("images/achievementsimages/achievements_images.xml", "achievements_locked2.tex"))
    self.icon:ScaleToSize(icon_size,icon_size)
    self.icon:SetPosition(icon_x,0)

    local desc_w = rect_w - rect_h
    local desc_x = (rect_w-desc_w)/2 + text_extra_offset_x
    self.name = self.group:AddChild(Text(HEADERFONT, 23*scale, ""))
    self.name:SetColour(UICOLOURS.GOLD_FOCUS)
    self.name:SetHAlign(ANCHOR_LEFT)
    self.name.maxWidth = desc_w - icon_padding

    self.desc = self.group:AddChild(Text(CHATFONT, 23*scale, ""))
    self.desc:SetColour(UICOLOURS.HIGHLIGHT_GOLD)
    self.desc:SetRegionSize(desc_w, 33*scale)
    self.desc:SetHAlign(ANCHOR_LEFT)
    self.desc:EnableWordWrap(true)
    self.desc:SetPosition(desc_x, -14*scale)

    if false then
        self.icon_shadow = self.group:AddChild(Image("images/global.xml", "square.tex"))
        self.icon_shadow:ScaleToSize(icon_size, icon_size)
        self.icon_shadow:SetTint(1,1,0,0.5)
        self.icon_shadow:SetPosition(self.icon:GetPosition())

        self.rect_shadow = self.group:AddChild(Image("images/global.xml", "square.tex"))
        self.rect_shadow:ScaleToSize(rect_w, rect_h)
        self.rect_shadow:SetTint(0,0,1,0.2)
        self.rect_shadow:SetPosition(self.rect:GetPosition())

        self.name.shadow = self.group:AddChild(Image("images/global.xml", "square.tex"))

        self.desc_shadow = self.group:AddChild(Image("images/global.xml", "square.tex"))
        self.desc_shadow:ScaleToSize(self.desc:GetRegionSize())
        self.desc_shadow:SetTint(0,1,0,0.2)
        self.desc_shadow:SetPosition(self.desc:GetPosition())
    end

    self:Hide()
    self.update_param = {}
end)

-- function KaAchievementsNotifPopUp:KaUpdateString(...)
function KaAchievementsNotifPopUp:KaUpdateString(theString)
    self.name:SetHorizontalSqueeze(1.0)
    self.name:SetString(theString)

    local name_w, h = self.name:GetRegionSize()
    if name_w > self.name.maxWidth then
        self.name:SetHorizontalSqueeze(self.name.maxWidth / name_w)
        name_w, h = self.name:GetRegionSize()
    end
    local name_x = rect_h - (rect_w-name_w)/2 + text_extra_offset_x
    self.name:SetPosition(name_x, 11*scale)

    if self.name.shadow then
        self.name.shadow:ScaleToSize(self.name:GetRegionSize())
        self.name.shadow:SetTint(1,0,0,0.2)
        self.name.shadow:SetPosition(self.name:GetPosition())
    end

    -- We don't show the detail of the achievement here.
    -- self.desc:SetString(STRINGS.ACCOMPLISHMENTS[string.upper(data.category)][string.upper(data.name) .. "_DESC"])
    self.desc:SetString(STRINGS.ACCOMPLISHMENTS.UI.UNLOCKED)
end

-- function KaAchievementsNotifPopUp:SetData(data)
function KaAchievementsNotifPopUp:SetData(data)
    self.lastData = data
    self.icon:SetTexture("images/achievementsimages/achievements_images.xml",
                         string.format("achievements_%s_%s.tex", data.category, data.name),
                         "achievements_empty.tex")

    self:KaUpdateString(STRINGS.ACCOMPLISHMENTS[string.upper(data.category)][string.upper(data.name) .. "_TITLE"])
end

-- function KaAchievementsNotifPopUp:OnMouseButton(button, down, x, y)
function KaAchievementsNotifPopUp:OnMouseButton(button, down, x, y)
    -- Unused
end

-- function KaAchievementsNotifPopUp:OnControl(control, down)
function KaAchievementsNotifPopUp:OnControl(control, down)
    if down and control == CONTROL_ACCEPT then
        -- Single click to pin the notif box.
        self.stay = true

        -- Double click check. If double-clicked, FadeOut().
        local t1 = self.lastClickedTime
        local t2 = os.clock()

        self.lastClickedTime = t2

        if t1 ~= nil and t2 - t1 <= TUNING.KAACHIEVEMENT.DOUBLE_CLICK_TIME then
            self.lastClickedTime = nil
            self:FadeOut()
        end
    end
end

-- function KaAchievementsNotifPopUp:OnUpdate(dt)
function KaAchievementsNotifPopUp:OnUpdate(dt)
    if TheNet:IsServerPaused() then return end

    local param = self.update_param

    local start_pos    = param.start_pos
    local erode_amount = math.min(param.time / param.fade_time, 1)
    local pos          = param.pos and (type(param.pos) == "function" and param.pos(self) or param.pos) or nil

    if pos then
        self.group:SetPosition(param.ease_fn(erode_amount, start_pos.x, pos.x-start_pos.x, 1),
                              param.ease_fn(erode_amount, start_pos.y, pos.y-start_pos.y, 1))
    end

    self.alpha = param.ease_fn(erode_amount, self.alpha, param.alpha-self.alpha, 1)
    self:SetFadeAlpha(self.alpha)
    param.time = param.time + dt

    -- Delay param.sound seconds before playing the sound
    if param.sound and erode_amount >= param.sound then
        if TheFocalPoint and TheFocalPoint.SoundEmitter then
            TheFocalPoint:DoTaskInTime(0.2, function()
                TheFocalPoint.SoundEmitter:PlaySound("dontstarve/common/shrine/shrine_final")
            end)
        end
        param.sound = nil
    end

    -- At an end
    if erode_amount == 1 or self.alpha <= 0.1 then
        if param.isFadeOut then
            self:PopAndNext()
        elseif param.time >= param.fadeOutDelay and self.stay ~= true then
            param.fadeOutDelay = nil
            self:FadeOut()
        end
    end
end

-- function KaAchievementsNotifPopUp:GetTargetPosition()
function KaAchievementsNotifPopUp:GetTargetPosition()
    local offset = Vector3(0, 110 * scale)

    if self.player ~= nil then
        if IsEntityDeadOrGhost(self.player) then
            offset = Vector3(0, 200 * scale)
        elseif self.player.IsIntegratedBackpackOpen and self.player:IsIntegratedBackpackOpen() then
            offset = Vector3(0, 150 * scale)
        end
    end

    return offset
end

-- function KaAchievementsNotifPopUp:PushFake()
function KaAchievementsNotifPopUp:PushFake()
    local fake_data = self.lastData or {category="social", name="sixplayers"}
    self:PushBack(fake_data)
end

-- function KaAchievementsNotifPopUp:PushBack(data)
function KaAchievementsNotifPopUp:PushBack(data)
    table.insert(self.queue, data)

    if #self.queue == 1 then
        self:FadeIn(TUNING.KAACHIEVEMENT.RPC.POPUP_FADE_DELAY)
    end
end

-- function KaAchievementsNotifPopUp:PopAndNext()
function KaAchievementsNotifPopUp:PopAndNext()
    table.remove(self.queue, 1)

    if #self.queue == 0 then
        self:StopUpdating()
        self.stay = false
        self:Hide()
        self.rect:ClearFocus()
    else
        self:FadeIn(TUNING.KAACHIEVEMENT.RPC.POPUP_FADE_DELAY)
    end
end

-- function KaAchievementsNotifPopUp:FadeIn(...)
function KaAchievementsNotifPopUp:FadeIn(fadeOutDelay)
    if #self.queue == 0 then
        self:StopUpdating()
        self:Hide()
        self.rect:ClearFocus()
        return
    end

    self.alpha = fade_alpha
    self:SetFadeAlpha(self.alpha)
    self:SetData(self.queue[1])

    self.update_param =
    {
        time         = 0,
        sound        = 0.05,
        fade_time    = 1,
        alpha        = pop_alpha,
        start_pos    = fade_pos,
        pos          = self.GetTargetPosition,
        ease_fn      = easing.outQuad,
        isFadeOut    = false,
        fadeOutDelay = fadeOutDelay,
    }

    self:Show()
    self.rect:SetFocus()
    self:StartUpdating()
end

-- function KaAchievementsNotifPopUp:FadeOut()
function KaAchievementsNotifPopUp:FadeOut()
    self.update_param =
    {
        time       = 0,
        sound      = nil,
        fade_time  = 1,
        alpha      = fade_alpha,
        start_pos  = self.group:GetPosition(),
        pos        = nil,
        ease_fn    = easing.inQuad,
        isFadeOut  = true,
    }

    self.stay = false
    self:Show()
    self:StartUpdating()
end

return KaAchievementsNotifPopUp
