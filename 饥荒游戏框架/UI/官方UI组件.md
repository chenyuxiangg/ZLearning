# 饥荒联机版UI组件库

## 游戏中支持的UI组件

官方为游戏UI封装了一些常用的UI组件可以直接调用，具体如下。

### 屏幕

* ScreenRoot

该函数组件返回一个原始的窗口，可以将其理解为一个新的图层，大小即为显示器大小。原始窗口作为一个`Widget`对象拥有所有`Widget`类的功能。然而作为一个组件，最原始的目的就是对用户可视，因为`Widget`类拥有`Show()`、`Hide()`、`Kill()`函数，因此可以很方便的显示、隐藏和销毁窗口，但是直接使用这些函数存在一个问题：无法聚焦到这个窗口，换句话说就是你无法点击这个窗口上的任何控件，比如按钮之类的。因此正确的使用方法是通过`TheFrontEnd:PushScreen(screen)`方法来显示窗口，通过`TheFrontEnd:PopScreen(screen)`方法来销毁窗口，为了使用这些两个方法，需要为新窗口添加几个回调函数：

```lua
-- 由TheFrontEnd:PushScreen()调用
function self.screenroot:OnBecomeActive()
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

-- 由TheFrontEnd:PopScreen()调用
function self.screenroot:OnBecomeInactive()
    self.last_focus = self:GetDeepestFocus()
end

-- 由TheFrontEnd:PushScreen()调用
function self.screenroot:OnUpdate(dt)
    return true
end

-- 由TheFrontEnd:PopScreen()调用
function self.screenroot:OnDestroy()
    self:Kill()
end
```

### 背景

* LoaderBackground

* ReduxBackground

* PlainBackground

* LeftSideBarBackground

* BackgroundTint

* QuagmireAnim

* BoarriorAnim

* ClayWargBackground

* ClayWargAnim

### 菜单

* ScreenTitle

* ScreenTitle_BesideLeftSideBar

* StandardMenu

* ScreenTooltip

* MenuButton

* TwoLineMenuButton

* WardrobeButton

* WardrobeButtonMinimal

* PortraitIconMenuButton

* BackButton

* BackButton_BesideLeftSidebar

* StandardButton

* IconButton

* StandardCheckbox

* ServerDetailIcon

* ListItemBackground

* ListItemBackground_Static

* ModListItem

* ModListItem_Downloading

* DoodadCounter

* KleiPointsCounter

* BoltCounter

* StandardSingleLineTextEntry

* LabelTextbox

* LabelSpinner

* LabelNumericSpinner

* LabelButton

* OptionsLabelCheckbox

* LabelCheckbox

* StandardSpinner

* StandardNumericSpinner

* CharacterSpinner

* AnnouncementBadge

* SystemMessageBadge

* RankBadge

* FestivalNumberBadge

* UserProgress

* LargeScissorProgressBar

* WxpBar

* ItemImageText

### 框架

* CurlyWindow

* RectangleWindow

* ControllerFunctionsFromButtons

* ScrollingGrid

### 布局

* LeftColumn

* RightColumn

* ReduxForeground

* MakeUIStatusBadge

* MakeStartingInventoryWidget

## 游戏中的组件实例

* 食谱(recipe_book)
> QuagmireRecipeBookScreen  
> 该组件包含两个子组件：RecipeBookWidget(widgets/redux/quagmire_recipebook) 和 AchievementsPanel(widgets/redux/achievementspanel)，相当于两个面板。

```lua
--- 使用举例
local curscreen = TheFrontEnd:GetActiveScreen()
if curscreen.name == "HUD" and curscreen.owner ~= nil then
    TheFrontEnd:PushScreen(QuagmireRecipeBookScreen(curscreen.owner))
```