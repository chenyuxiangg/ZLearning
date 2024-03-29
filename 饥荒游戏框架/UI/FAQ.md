**Q:Widget和Screen的相同与不同？**
> A: 游戏中所有界面元素都是`Widget`的子类，`Screen`也不例外。因此`Screen`对象拥有`Widget`的所有功能，特别的，`Screen`对象的设计目的就是为了作为一块“幕布”，在其上可以放置很多不同的UI组件，以达到最终的效果。当然并不是说只有`Screen`对象才能够显示，`Widget`类提供了一个`Show()`方法来显示自身，但是这个方法通常情况不会直接调用。

**Q:如何自定义UI界面？**
> A: 首先得了解饥荒游戏的设计，明确UI界面到底由什么组成。饥荒对UI的定义比较简单：从`Widget`派生出一个`Screen`作为承载显示的平台，其他派生类用于实现具有特定功能的组件，然后将组件作为元素放置在`Screen`上就形成了UI。生成一个UI界面的正常逻辑应该是：定义`Screen`对象->给`Screen`添加各种组件->使用`TheFrontEnd:PushScreen()`将`Screen`推送到显示队列最前边并激活。

**Q:UI界面的元素是否有顺序？如何指定？**
> A: 由于`Screen`是一个二维平面，因此在同一个位置先后放置两个不同的组件一定会有一个被覆盖，在饥荒中，被覆盖的是**先放置的元素**。何为先放置？就是字面意思，越早在代码逻辑中被`AddChild()`加入子组件的元素就越先被放置。

**Q:如何实现点击UI界面上的其他位置（非组件）退出当前UI界面？**
> A: 基于UI界面的顺序原理，可以在`Screen`上还没有任何元素的时候放置一个全屏的透明按钮作为背景，点击这个按钮时退出当前`Screen`即可。

**Q:UI中三种处理按键响应的接口**
> 1. 在`Screen`中定义`OnRawKey()`函数处理按键，这种方式可以处理任何按键；
> 2. 在`Screen`中定义`OnControl()`函数处理按键，这种方式有一定局限性，只对某些控制按键有效；
> 3. 在`TheInput:AddKeyHandler()`中注册处理函数，这种方法不局限于UI，可以在任何时候响应按键；