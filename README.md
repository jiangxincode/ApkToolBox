# ApkToolBox

* 本项目的目标是将常用的APK反编译相关的工具进行收集、整理，提供统一的shell接口，最终实现对 Android逆向助手、APKIDE、Android Multitool等闭源工具的完全替代。
* 本项目依赖apktool、Dex2Jar、jd-gui、AXMLPrinter3等工具，版权归原工具作者所有。
* 本项目欢迎大家共同修改。

如果出现Dex2Jar报错版本不支持，可以参考<http://blog.csdn.net/jltxgcy/article/details/52599353>重新编译源码。

## Usage

```powershell
cd ~
git clone https://github.com/jiangxincode/ApkToolBox.git
cd ApkToolBox
.\ApkToolBox.ps1 -help
```