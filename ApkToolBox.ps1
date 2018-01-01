Param ($in, $out, [int]$option=0, [switch]$help, [switch]$version)


function APKToolDecode ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================APKToolDecode start"

    Write-Output "INPUT is: $IN_PUT, and OUTPUT is: $OUT_PUT"

    Write-Output "===============================================delete $OUT_PUT start"
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================delete $OUT_PUT end"
    
    java -jar "-Duser.language=en" "-Dfile.encoding=UTF8" "$CURRENT_DIR/apktool.jar" d -f $IN_PUT -o $OUT_PUT
    Write-Output "===============================================APKToolDecode end"
}

function APKToolEncode ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================APKToolDecode start"

    Write-Output "INPUT is: $IN_PUT, and OUTPUT is: $OUT_PUT"

    Write-Output "===============================================delete $OUT_PUT start"
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================delete $OUT_PUT end"
    
    java -jar "-Duser.language=en" "-Dfile.encoding=UTF8" "$CURRENT_DIR/apktool.jar" b $IN_PUT -o $OUT_PUT
    Write-Output "===============================================APKToolDecode end"
}

function 7Zip ($IN_PUT, $OUT_PUT) {
    Write-Output "===============================================7Zip start"

    Write-Output "INPUT is: $IN_PUT, and OUTPUT is: $OUT_PUT"

    Write-Output "===============================================delete $OUT_PUT start"
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================delete $OUT_PUT end"
    
    7z.exe x $IN_PUT -o"$OUT_PUT" -y
    Write-Output "===============================================7Zip end"
}

function Dex2Jar ($IN_PUT, $OUT_PUT) {
    if (Test-Path $OUT_PUT) {
        Remove-Item $OUT_PUT -recurse
    }
    Write-Output "===============================================dex2jar start"
    dex2jar/d2j-dex2jar.bat $IN_PUT -o $OUT_PUT
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
    zipalign.exe -f -v 4 $IN_PUT "$OUT_PUT/destination.apk"
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
    jd-gui.exe $IN_PUT
    Write-Output "===============================================jd-gui end"
}



if ($help) {
    Write-Output "Usage: `t .\ApkToolBox.ps1 -in input -out output -option [0, 1, 2, ...]"
    Write-Output "Comment: `t [input] is a file and [output] is a directory"
    Write-Output "Author: `t Aloys, jiangxinnju@163.com"
    Write-Output "Update From: `t https://github.com/jiangxincode/APKDecompiler"
    Write-Output "Option List:"
    Write-Output "`t 0: common. [input] is a file and [output] is a directory"
    Write-Output "`t 10: decompile apk using apktool. [input] is a file and [output] is a directory"
    Write-Output "`t 11: build apk using apktool. [input] is a directory and [output] is a file"
    Write-Output "`t 20: decompression apk using 7zip. [input] is a file and [output] is a directory"
    Write-Output "`t 30: convert dex to jar using dex2jar. [input] is a file and [output] is a directory"
    Write-Output "`t 40: open jar using jd-gui. [input] is a file and [output] is a directory"
    Write-Output "`t 50: align apk using zipalign. [input] is a file and [output] is a directory"
    Write-Output "`t 60: decode AndroidManifest.xml using AXMLPrinter3. [input] is a file and [output] is a directory"
    return
}

$CURRENT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

if ($version) {
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
    7Zip $IN_PUT "$OUT_PUT/7zip"
    Dex2Jar "$OUT_PUT/7zip/classes.dex" "$OUT_PUT/dex2jar/classes.jar"
    JDGUI "$OUT_PUT/dex2jar/classes.jar"
    ZipAlign $IN_PUT "$OUT_PUT/zipalign/test_new.apk"
    AXMLPrinter3 "$OUT_PUT/7zip/AndroidManifest.xml" "$OUT_PUT/AXMLPrinter3"
    return
}
elseif ($option -eq 10) {
    APKToolDecode $IN_PUT "$OUT_PUT/apktool"
    return
}
elseif ($option -eq 11) {
    APKToolEncode $IN_PUT "$OUT_PUT"
    return
}
elseif ($option -eq 20) {
    7Zip $IN_PUT "$OUT_PUT/7zip"
    return
}
elseif ($option -eq 30) {
    7Zip $IN_PUT "$OUT_PUT/7zip"
    Dex2Jar "$OUT_PUT/7zip/classes.dex" "$OUT_PUT/dex2jar/classes.jar"
    return
}
elseif ($option -eq 40) {
    7Zip $IN_PUT "$OUT_PUT/7zip"
    Dex2Jar "$OUT_PUT/7zip/classes.dex" "$OUT_PUT/dex2jar/classes.jar"
    JDGUI "$OUT_PUT/dex2jar/classes.jar"
    return
}
elseif ($option -eq 50) {
    ZipAlign $IN_PUT "$OUT_PUT/zipalign"
    return
}
elseif ($option -eq 60) {
    7Zip $IN_PUT "$OUT_PUT/7zip"
    AXMLPrinter3 "$OUT_PUT/7zip/AndroidManifest.xml" "$OUT_PUT/AXMLPrinter3"
    return
}
else {
    Write-Error "Invalid option."
}