Param ($in, $out, [int]$option = 0, [switch]$help, [switch]$h, [switch]$version, [switch]$v)


# Can't use $PSScriptRoot for current directory, it is only used in PS 3 or above.
$CURRENT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition




function APKToolDecode ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================APKToolDecode start"

    Write-Output "INPUT is: $IN_PUT, and OUTPUT is: $OUT_PUT"

    Write-Output "===============================================delete $OUT_PUT start"
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================delete $OUT_PUT end"
    
    # add -k for the error "Invalid config flags detected"
    java -jar "-Duser.language=en" "-Dfile.encoding=UTF8" "$CURRENT_DIR/apktool.jar" -k d -f $IN_PUT -o $OUT_PUT
    Write-Output "===============================================APKToolDecode end"
}

function APKToolEncode ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================APKToolEncode start"

    Write-Output "INPUT is: $IN_PUT, and OUTPUT is: $OUT_PUT"

    Write-Output "===============================================delete $OUT_PUT start"
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================delete $OUT_PUT end"
    
    java -jar "-Duser.language=en" "-Dfile.encoding=UTF8" "$CURRENT_DIR/apktool.jar" b $IN_PUT -o $OUT_PUT
    Write-Output "===============================================APKToolEncode end"
}

function SevenZip ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================SevenZip start"

    Write-Output "INPUT is: $IN_PUT, and OUTPUT is: $OUT_PUT"

    Write-Output "===============================================delete $OUT_PUT start"
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================delete $OUT_PUT end"

    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    
    ."$CURRENT_DIR/7z.exe" x $IN_PUT "-o$OUT_PUT" -y
    Write-Output "===============================================SevenZip end"
}

function Dex2Jar ($IN_PUT, $OUT_PUT) {
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================dex2jar start"
    ."$CURRENT_DIR/dex2jar/d2j-dex2jar.bat" $IN_PUT -o $OUT_PUT
    Write-Output "===============================================dex2jar end"
}

function ZipAlign ($IN_PUT, $OUT_PUT) {
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================zipalign start"
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    ."$CURRENT_DIR/zipalign.exe" -f -v 4 $IN_PUT "$OUT_PUT/destination.apk"
    Write-Output "===============================================zipalign end"
}

function AXMLPrinter3 ($IN_PUT, $OUT_PUT) {
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================AXMLPrinter3 start"
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    java -jar AXMLPrinter3.jar $IN_PUT > "$OUT_PUT/AndroidManifest.xml"
    Write-Output "===============================================AXMLPrinter3 end"
}

function JDGUI ($IN_PUT) {
    Write-Output "===============================================jd-gui start"
    ."$CURRENT_DIR/jd-gui.exe" $IN_PUT
    Write-Output "===============================================jd-gui end"
}

function DexDump ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================DexDump start"

    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    ."$CURRENT_DIR/dexdump.exe" -d $IN_PUT > "$OUT_PUT/dexdump.dump"
    Write-Output "===============================================DexDump end"
}

function DeDexer ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================DeDexer start"

    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    java -jar "$CURRENT_DIR/ddx1.26.jar" -o -D -d $OUT_PUT $IN_PUT
    Write-Output "===============================================DeDexer end"
}

function SignApk ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================SignApk start"

    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    java -jar "$CURRENT_DIR/APKSign/signapk.jar" "$CURRENT_DIR/APKSign/testkey.x509.pem" "$CURRENT_DIR/APKSign/testkey.pk8"　$IN_PUT "$OUT_PUT/signed.apk"
    Write-Output "===============================================SignApk end"
}

function baksmali ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================SignApk start"

    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    java -jar "$CURRENT_DIR/baksmali-2.1.3.jar" -o "$OUT_PUT" $IN_PUT
    Write-Output "===============================================SignApk end"
}

function smali ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================SignApk start"

    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    java -jar "$CURRENT_DIR/smali-2.1.3.jar" $IN_PUT -o "$OUT_PUT/classes_new.dex"
    Write-Output "===============================================SignApk end"
}

function GetScreenShot ($OUT_PUT) {
    Write-Output "===============================================GetScreenShot start"
    adb shell /system/bin/screencap -p /sdcard/screenshot.png
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    $CURRENT_TIME = Get-Date -Format 'yyyyMMddHHmmss'
    adb pull /sdcard/screenshot.png "$OUT_PUT/screenshot_$CURRENT_TIME.png"
    Write-Output "===============================================GetScreenShot end"
}

function GetScreenShotAndOpenDirectory ($OUT_PUT) {
    Write-Output "===============================================GetScreenShot start"
    adb shell /system/bin/screencap -p /sdcard/screenshot.png
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    $CURRENT_TIME = Get-Date -Format 'yyyyMMddHHmmss'
    adb pull /sdcard/screenshot.png "$OUT_PUT/screenshot_$CURRENT_TIME.png"
    Start-Process $OUT_PUT
    Write-Output "===============================================GetScreenShot end"
}

function GetScreenRecord () {
    Write-Output "===============================================GetScreenRecord start"
    adb shell screenrecord /sdcard/screenrecord.mp4 --verbose
    Write-Output "===============================================GetScreenRecord end"
}

function PullScreenRecord ($OUT_PUT) {
    Write-Output "===============================================PullScreenRecord start"
    If (!(Test-Path $OUT_PUT)) {
        New-Item -ItemType Directory -Force -Path $OUT_PUT
    }
    $CURRENT_TIME = Get-Date -Format 'yyyyMMddHHmmss'
    adb pull /sdcard/screenrecord.mp4 "$OUT_PUT/screenrecord_$CURRENT_TIME.mp4"
    Write-Output "===============================================PullScreenRecord end"
}


if ($help -or $h) {
    Write-Output "Usage: `t .\ApkToolBox.ps1 -in input -out output -option [0, 1, 2, ...]"
    Write-Output "Comment: `t [input] is a file/directory and [output] is a directory"
    Write-Output "Author: `t Aloys, jiangxinnju@163.com"
    Write-Output "Update From: `t https://github.com/jiangxincode/APKDecompiler"
    Write-Output "Option List:"
    Write-Output "`t 0: common. [input] is a file"
    Write-Output "`t 10: decompile apk using apktool. [input] is a file"
    Write-Output "`t 11: build apk using apktool. [input] is a directory"
    Write-Output "`t 20: decompression apk using 7zip. [input] is a file"
    Write-Output "`t 30: convert dex to jar using dex2jar. [input] is a file"
    Write-Output "`t 40: open jar using jd-gui. [input] is a file"
    Write-Output "`t 50: align apk using zipalign. [input] is a file"
    Write-Output "`t 60: decode AndroidManifest.xml using AXMLPrinter3. [input] is a file"
    Write-Output "`t 70: get dump file using dexdump. [input] is a file"
    Write-Output "`t 80: reate Jasmin-like source files from DEX files using dedexer. [input] is a file"
    Write-Output "`t 90: sign the apk using signapk. [input] is a file"
    Write-Output "`t 100: decompile the dex using baksmali. [input] is a file"
    Write-Output "`t 110: compile the dex using smali. [input] is a directory"
    Write-Output "`t 200: get the screenshot"
    Write-Output "`t 201: get the screenshot and open the screenshot directory"
    Write-Output "`t 210/211: get the screenrecord"
    
    return
}

if ($version -or $v) {
    $content = Get-Content -Path "$CURRENT_DIR/versions.txt"
    Write-Output $content
    return
}

Write-Output "in is: $in"
Write-Output "out is: $out"
Write-Output "option is: $option"
Write-Output "CURRENT_DIR is: $CURRENT_DIR"

if ($in -eq $null) {
    $IN_PUT = "$CURRENT_DIR/test.apk"
}
else {
    $IN_PUT = $in
}

if ($out -eq $null) {
    $OUT_PUT = "$CURRENT_DIR/tmp"
}
else {
    $OUT_PUT = $out
}

Write-Output "INPUT is: $IN_PUT"
Write-Output "OUTPUT is: $OUT_PUT"

if (-not (Test-Path $IN_PUT)) {
    Write-Error "INPUT_FILE doesn't exist."
    return
}

if ($option -eq 0) {
    APKToolDecode $IN_PUT "$OUT_PUT/apktool"
    SevenZip $IN_PUT "$OUT_PUT/7zip"
    Dex2Jar "$OUT_PUT/7zip/classes.dex" "$OUT_PUT/dex2jar/classes.jar"
    JDGUI "$OUT_PUT/dex2jar/classes.jar"
    ZipAlign $IN_PUT "$OUT_PUT/zipalign/test_new.apk"
    AXMLPrinter3 "$OUT_PUT/7zip/AndroidManifest.xml" "$OUT_PUT/AXMLPrinter3"
    return
}
elseif ($option -eq 10) {
    APKToolDecode $IN_PUT "$OUT_PUT/apktool_d"
    return
}
elseif ($option -eq 11) {
    APKToolEncode $IN_PUT "$OUT_PUT/apktool_e/new_apk.apk"
    return
}
elseif ($option -eq 20) {
    SevenZip $IN_PUT "$OUT_PUT/7zip"
    return
}
elseif ($option -eq 30) {
    SevenZip $IN_PUT "$OUT_PUT/7zip"
    Dex2Jar "$OUT_PUT/7zip/classes.dex" "$OUT_PUT/dex2jar/classes.jar"
    return
}
elseif ($option -eq 40) {
    SevenZip $IN_PUT "$OUT_PUT/7zip"
    Dex2Jar "$OUT_PUT/7zip/classes.dex" "$OUT_PUT/dex2jar/classes.jar"
    JDGUI "$OUT_PUT/dex2jar/classes.jar"
    return
}
elseif ($option -eq 50) {
    ZipAlign $IN_PUT "$OUT_PUT/zipalign"
    return
}
elseif ($option -eq 60) {
    SevenZip $IN_PUT "$OUT_PUT/7zip"
    AXMLPrinter3 "$OUT_PUT/7zip/AndroidManifest.xml" "$OUT_PUT/AXMLPrinter3"
    return
}
elseif ($option -eq 70) {
    SevenZip $IN_PUT "$OUT_PUT/7zip"
    DexDump "$OUT_PUT/7zip/classes.dex" "$OUT_PUT/dexdump"
    return
}
elseif ($option -eq 80) {
    SevenZip $IN_PUT "$OUT_PUT/7zip"
    DeDexer "$OUT_PUT/7zip/classes.dex" "$OUT_PUT/dedexer"
    return
}
elseif ($option -eq 90) {
    SignApk $IN_PUT "$OUT_PUT/signapk"
    return
}
elseif ($option -eq 100) {
    SevenZip $IN_PUT "$OUT_PUT/7zip"
    baksmali "$OUT_PUT/7zip/classes.dex" "$OUT_PUT/baksmali"
    return
}
elseif ($option -eq 110) {
    smali $IN_PUT "$OUT_PUT/smali"
    return
}
elseif ($option -eq 200) {
    GetScreenShot "$OUT_PUT/screenshot"
    return
}
elseif ($option -eq 201) {
    GetScreenShotAndOpenDirectory "$OUT_PUT/screenshot"
    return
}
elseif ($option -eq 210) {
    GetScreenRecord
    return
}
elseif ($option -eq 211) {
    PullScreenRecord "$OUT_PUT/screenrecord"
    return
}
else {
    Write-Error "Invalid option."
}