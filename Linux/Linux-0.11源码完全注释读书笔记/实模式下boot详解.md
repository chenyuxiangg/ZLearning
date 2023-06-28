# 实模式下boot总结

## 编译

linux-0.11的boot目录下有三个汇编文件:bootsect.s、setup.s、head.s，其中前两个运行于实模式下，最后一个运行于保护模式下。由于在1991年时刚发布linux时GNU的GCC还不支持生成实模式的代码(16位)，所以linus选择使用as86和ld86，而1995年以后GNU对16位进行了支持，详情可参考[使用GCC和GNU Binutils编写能在x86实模式运行的16位代码](https://linux.cn/article-3873-1.html).

bootsect.s和setup.s被分别编译为16位的bootsect和setup可执行程序。

## 功能

### 80x86体系结构CPU启动过程

1. 系统上电，首先需要对系统关键参数进行检查以及初始化中断向量(通常这部分逻辑放在ROM-BIOS中实现，地址一般为0xFFFF0)，ROM-BIOS将BIOS中断向量表放置在0x0地址；
2. 将可启动设备的第一个扇区读入内存地址0x7c00处，并跳转到这个地方。

### bootsect



### setup

## 实现