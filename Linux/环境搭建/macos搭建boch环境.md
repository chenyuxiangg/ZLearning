## 参考文档
[Mac安装bochs](https://cloud.tencent.com/developer/article/1993526?from=article.detail.1470977&areaSource=106000.13&traceId=NWIhsf2Zg3rwe3CFYDHef)
[使用bochs搭建linux-0.11环境](https://blog.51cto.com/u_15127550/3886281)
[bochs运行linux-0.11](https://www.cnblogs.com/raina/p/13212177.html)

## linux命令行快捷操作
[命令行快捷操作](https://cloud.tencent.com/developer/article/1586970?from=15425&areaSource=102001.3&traceId=7ajMIYrYbaIq_3hecnC89)
[vim函数跳转和变量跳转操作](https://segmentfault.com/a/1190000021097211)
[vim跳转操作](https://mapan1984.github.io/tool/2016/04/22/Vim-%E7%A7%BB%E5%8A%A8%E8%B7%B3%E8%BD%AC/)

## 问题
1. 参考**Mac安装bochs**配置，另外发现问题：安装了*libxrandr*后`make`时依然提示"X11/extensions/Xrandr.h not found.".解决方案如下：
    > 使用`brew list libxrandr`查看libxrandr的头文件路径，假设为"/opt/homebrew/Cellar/libxrandr/1.5.3/include/";
    > 进入"bochs-<版本号>/gui"目录，编辑**Makefile**文件，找到`LOCAL_CXXFLAGS=`(大约在43行)，末尾新增如下`-I/opt/homebrew/Cellar/libxrandr/1.5.3/include/`;
2. 参考**Mac安装bochs**配置，另外发现问题：安装了*libxrandr*后`make`时提示链接异常,提示“ld: library not found for -lXrandr”.解决方案如下：
    > 使用`brew list libxrandr`查看libxrandr的头文件路径，假设为"/opt/homebrew/Cellar/libxrandr/1.5.3/lib/";
    > 在"bochs-<版本号>"目录下编辑**Makefile**文件，找到"LIBS ="(大约在92行)，在最后一个"-L"参数后新增如下`-L/opt/homebrew/Cellar/libxrandr/1.5.3/lib/`;
3. 由于MacOS安装linux-0.11的编译环境不方便，因此将编译环境安装在ubuntu-16.04上，其中ubuntu16.04安装gcc-3.4参见[gcc-3.4安装](https://blog.csdn.net/u014069939/article/details/90726175),as86和ld86直接使用`sudo apt-get install bin86`即可安装.

4. 编译内核，参考链接[编译linux-0.11](https://vonku.github.io/2019/09/21/%E5%9C%A8ubuntu18-04%E4%B8%8A%E7%BC%96%E8%AF%91%E8%BF%90%E8%A1%8Clinux0-11/)

5. 根据第四步操作后发现在链接**tools/build**工具时会提示"crt1.o"和"ctri.o"找不到，此时可以在`/lib`目录下使用`find`命令查找，找到后将其拷贝或者链接到`/lib`目录下；提示"-lgcc_s"找不到时也是同理处理.
