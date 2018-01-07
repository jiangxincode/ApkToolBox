# ApkToolBox

* 本项目的目标是将常用的APK反编译相关的工具进行收集、整理，提供统一的shell接口，最终实现对 Android逆向助手、APKIDE、Android Multitool等闭源工具的完全替代。
* 本项目依赖apktool、Dex2Jar、jd-gui、AXMLPrinter3等工具，版权归原工具作者所有。
* 本项目欢迎大家共同修改。

如果出现Dex2Jar报错版本不支持，可以参考<http://blog.csdn.net/jltxgcy/article/details/52599353>重新编译源码。

## Function

         0: common. [input] is a file
         10: decompile apk using apktool. [input] is a file
         11: build apk using apktool. [input] is a directory
         20: decompression apk using 7zip. [input] is a file
         30: convert dex to jar using dex2jar. [input] is a file
         40: open jar using jd-gui. [input] is a file
         50: align apk using zipalign. [input] is a file
         60: decode AndroidManifest.xml using AXMLPrinter3. [input] is a file
         70: get dump file using dexdump. [input] is a file
         80: reate Jasmin-like source files from DEX files using dedexer. [input] is a file
         90: sign the apk using signapk. [input] is a file
         100: decompile the dex using baksmali. [input] is a file
         110: compile the dex using smali. [input] is a directory
         200: get the screenshot

## Usage

```powershell
cd ~
git clone https://github.com/jiangxincode/ApkToolBox.git
cd ApkToolBox
.\ApkToolBox.ps1 -help
```

## TODO

for some version apks:

Dexdump: unsupported dex version (30 33 37 00)
DeDexer: Value read:0x37; value expected:[0x36, 0x35, 0x33]