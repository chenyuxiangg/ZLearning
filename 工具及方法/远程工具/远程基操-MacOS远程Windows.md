# MacOS远程windows操作系统

## 设备配置及说明

写文章时我所使用的设备配置如下：

* Macbook Air(M2 2022): 远程客户端，即用它连接安装了Windows系统的设备。
* Windows 10设备

## 方案一：使用freeRDP

[freeRDP](https://www.freerdp.com/)是一款基于Apache Lisence的开源远程桌面协议，它支持**Linux**、**Android**和**MacOS**操作系统。
在macOS上安装freeRDP需要使用**homebrew**，它的安装方式如下：

```shell
# 首次安装时间较长，如果没有使用代理，那么下载速度会相当慢，有条件的建议挂一个代理，如有需要可以关注公众号：计算机技工，留言即可。
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 通常情况下homebrew安装在/opt目录下，如下方式查看
cd /opt/homebrew/bin && ls

# 安装完成后需要将homebrew添加到环境变量中，才能直接使用，.zprofile文件如果不存在，新建即可
touch ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

homebrew安装完成后，`brew` 命令就可以使用了，因此安装freeRDP就比较简单了：

```shell
# 同样的，如果不挂代理会非常慢
brew install freerdp

# 使用brew命令安装完成后，如果想要知道应用程序存储在哪，可以使用如下命令
brew list <app_name>

# 比如
brew list freerdp

# 安装完成后也需要田间环境变量才能直接使用应用程序名直接调用,比如
echo 'export PATH="/opt/homebrew/Cellar/freerdp/2.8.1/bin:$PATH"' >> ~/.zprofile
```

安装完协议之后，就可以使用如下命令指定电脑进行远程了：

```shell
# /v - 指定被远程的电脑的IP
# /port - 指定被远程电脑的远程桌面端口号，通常是3389
# /u - 指定被远程电脑允许远程的用户名
# /p - 指定对应用户名的密码
# /f - 全屏显示
xfreerdp /v:<ip> /port:<port> /u:<user_name> /p:<password> /f
```

更详细的使用手册见[freerdp用户手册](https://github.com/awakecoding/FreeRDP-Manuals/blob/master/User/FreeRDP-User-Manual.markdown)如果在运行时应该会遇到下面的问题：

![xfreerdp_err](http://xiaoxiangge.asia/img/xfreerdp_err.png)

原因是远程电脑除了需要协议支持外，还需要一个客户端来承载，而在macOS上这个客户端就是X11（XQuartz），因此还需要安装它，方法如下：

```shell
# 同样的，如果不挂代理会非常慢
brew install xquartz --cask

# 配置环境变量
echo 'export DISPLAY=:0' >> ~/.zprofile
```

安装完成之后需要在**访达**中找到*使用工具* -> *XQuartz*，然后双击运行，运行后不会有任何反应，查看程序坞上如果有XQuartz正在运行，那么就可以使用xfreerdp进行远程了。

![XQuartz](http://xiaoxiangge.asia/img/XQuartz.png)

有一说一，xfreerdp的远程桌面效果感觉很蛋痛，总觉得是模糊不清晰的，如果有大佬知道如何调整请在**计算机技工**公众号后台留言指导，下图为xfreerdp远程桌面效果：

![xfeerdp](http://xiaoxiangge.asia/img/xfreerdp.png)

## 方案二：使用MRD

由于`freerdp + XQuartz`远程windows 10的方案费时费力效果还不怎么地，因此寻找了其他的方案 - MRD。MRD全称Microsoft Remote Desktop，是微软提供的用于远程windows桌面的解决方案。RMD在macOS上的客户端无法在中国区的app store上找到，如果要下载该客户端需要使用非中国区的apple ID，如果有需要的可以在**计算机技工**公众号后台私信我。

如果不使用非中国区的Apple ID是不是就没有办法了呢？当然不是，另外一种获取RMD的方式是去[微软官网下载](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac)，操作步骤如下：

1. 点击上面👆的链接进入微软官网，你会看到官方建议从app store中下载，但是偏不，向下看会发现箭头所指处有一个beta版入口，点击进入

![RMD](http://xiaoxiangge.asia/img/RMD.png)
2. 在App Center界面可以选择下载想要的版本

![MRD_DOWNLOAD](http://xiaoxiangge.asia/img/mrd_download.png)
3. 下载完成后通过访达进入下载文件夹，双击运行

![run](http://xiaoxiangge.asia/img/run_mrd.png)
4. 进入应用后就是熟悉的界面操作了，在界面上输入一些必要的信息：PC name即可，其他的选项可以选填

![add_pc](http://xiaoxiangge.asia/img/add_pc.png)
![add_pc_detail](http://xiaoxiangge.asia/img/add_pc_detail.png)
5. 双击刚刚所添加的远程电脑即可开始远程
![remote](http://xiaoxiangge.asia/img/remote.png)

可以明显的发现，使用RMD远程windows 10的清晰度是非常香的。

Happy Playing，我们下篇文章见。
