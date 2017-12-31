# .\ApkToolBox.ps1 -FileName "D:/test.apk" -Directory "D:/test"

Param ($FileName, $Directory)

Write-Output "FileName is: $FileName"
Write-Output "Directory is: $Directory"

$CURRENT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
Write-Output "CURRENT_DIR is: $CURRENT_DIR"

if ($FileName -eq $null) {
    $INPUT_FILE = "$CURRENT_DIR/test.apk"
}
else {
    $INPUT_FILE = $FileName
}

if ($Directory -eq $null) {
    $OUTPUT_PATH = "$CURRENT_DIR/tmp"
}
else {
    $OUTPUT_PATH = $Directory
}

Write-Output "INPUT_FILE is: $INPUT_FILE"
Write-Output "OUTPUT_PATH is: $OUTPUT_PATH"

if (-not (Test-Path $INPUT_FILE)) {
    Write-Error "INPUT_FILE doesn't exist."
    return
}


# delete historical directories and files
Write-Output "===============================================delete tmp start"
if (Test-Path "$OUTPUT_PATH/apktool") {
    Remove-Item "$OUTPUT_PATH/apktool" -recurse
}

if (Test-Path "$OUTPUT_PATH/7zip") {
    Remove-Item "$OUTPUT_PATH/7zip" -recurse
}

if (Test-Path "$OUTPUT_PATH/dex2jar") {
    Remove-Item "$OUTPUT_PATH/dex2jar" -recurse
}

if (Test-Path "$OUTPUT_PATH/zipalign") {
    Remove-Item "$OUTPUT_PATH/zipalign" -recurse
}

if (Test-Path "$OUTPUT_PATH/AXMLPrinter3") {
    Remove-Item "$OUTPUT_PATH/AXMLPrinter3" -recurse
}
Write-Output "===============================================delete tmp end"


Write-Output "===============================================apktool start"
java -jar "-Duser.language=en" "-Dfile.encoding=UTF8" "$CURRENT_DIR/apktool.jar" d -f $INPUT_FILE -o "$OUTPUT_PATH/apktool/"
Write-Output "===============================================apktool end"


Write-Output "===============================================7zip start"
7z.exe x $INPUT_FILE -o"$OUTPUT_PATH/7zip/" -y
Write-Output "===============================================7zip end"


Write-Output "===============================================dex2jar start"
dex2jar-2.1-SNAPSHOT/d2j-dex2jar.bat "$OUTPUT_PATH/7zip/classes.dex" -o "$OUTPUT_PATH/dex2jar/classes.jar"
Write-Output "===============================================dex2jar end"


Write-Output "===============================================jd-gui start"
jd-gui.exe "$OUTPUT_PATH/dex2jar/classes.jar"
Write-Output "===============================================jd-gui end"


Write-Output "===============================================zipalign start"
If (!(Test-Path "$OUTPUT_PATH/zipalign/")) {
    New-Item -ItemType Directory -Force -Path "$OUTPUT_PATH/zipalign/"
}
zipalign.exe -f -v 4 $INPUT_FILE "$OUTPUT_PATH/zipalign/destination.apk"
Write-Output "===============================================zipalign end"

Write-Output "===============================================AXMLPrinter3 start"
If (!(Test-Path "$OUTPUT_PATH/AXMLPrinter3/")) {
    New-Item -ItemType Directory -Force -Path "$OUTPUT_PATH/AXMLPrinter3/"
}
java -jar AXMLPrinter3.jar "$OUTPUT_PATH/7zip/AndroidManifest.xml" > "$OUTPUT_PATH/AXMLPrinter3/AndroidManifest.xml"
Write-Output "===============================================AXMLPrinter3 end"