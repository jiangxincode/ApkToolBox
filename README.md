# ApkToolBox

* 本项目的目标是将常用的APK反编译相关的工具进行收集、整理，提供统一的shell接口，最终实现对 Android逆向助手、APKIDE、Android Multitool等闭源工具的完全替代。
* 本项目依赖apktool、Dex2Jar、jd-gui、AXMLPrinter3等工具，版权归原工具作者所有。
* 本项目欢迎大家共同修改。


可以参考<http://blog.csdn.net/vipzjyno1/article/details/21039349/>，但是文中的工具版本过低，需要升级，且某些命令有所变更。如果出现Dex2Jar报错版本不支持，可以参考<http://blog.csdn.net/jltxgcy/article/details/52599353>重新编译源码。


## APKSign

有了这个软件，可以自己修改美化APK文件。用WINRAR打开APK文件，将自己的图片图标放进替换原有的，然后用本软件制作签名，然后安装进Android.或者下载别人制作好的ROM，自己精简删除，或者添加APK文件，用本软件给ROM制作数字签名，然后刷机。

`java -jar signapk.jar testkey.x509.pem testkey.pk8　test.apk test1.apk`

## smali/baksmali

* <https://github.com/JesusFreke/smali>

`java -jar .\baksmali-2.1.3.jar -o classout/ classes.dex`

`java -jar smali-2.1.3.jar classout/ -o classes1.dex`

## dedexer

* https://sourceforge.net/projects/dedexer/

`java -jar .\ddx1.26.jar -o -D -d test classes.dex`

## dexdump

`dexdump.exe -d classes.dex > spk.txt`