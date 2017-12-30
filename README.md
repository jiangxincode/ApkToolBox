# APK 反编译

可以参考<http://blog.csdn.net/vipzjyno1/article/details/21039349/>，但是文中的工具版本过低，需要升级，且某些命令有所变更。如果出现Dex2Jar报错版本不支持，可以参考<http://blog.csdn.net/jltxgcy/article/details/52599353>重新编译源码。

## Apktool

<https://ibotpeaches.github.io/Apktool/>

* 反编译获取资源文件: `.\apktool.bat d -f .\test.apk -o test`
* 编译获取APK: `.\apktool.bat b .\test\`

## Dex2Jar

* <https://github.com/pxb1988/dex2jar>
* fork库，但是有最新的修改: <https://github.com/timofonic-java/dex2jar>

## jd-gui

* <http://jd.benow.ca/>
