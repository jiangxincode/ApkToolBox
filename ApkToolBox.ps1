# .\ApkToolBox.ps1 -FileName "D:/test.apk" -Directory "d:/test"

Param ($FileName, $Directory)

echo "FileName is: $FileName"
echo "Directory is: $Directory"

$CURRENT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
echo "CURRENT_DIR is: $CURRENT_DIR"

if ($FileName -eq $null)
{
    $INPUT_FILE = "$CURRENT_DIR/test.apk"
}
else
{
    $INPUT_FILE = $FileName
}

if ($Directory -eq $null)
{
    $OUTPUT_PATH = "$CURRENT_DIR/tmp"
}
else
{
    $OUTPUT_PATH = $Directory
}

echo "INPUT_FILE is: $INPUT_FILE"
echo "OUTPUT_PATH is: $OUTPUT_PATH"

if (-not (Test-Path $INPUT_FILE))
{
    Write-Error "INPUT_FILE doesn't exist."
    return
}

echo "===============================================delete tmp start"
if (Test-Path "$OUTPUT_PATH/apktool")
{
    Remove-Item "$OUTPUT_PATH/apktool" -recurse
}

if (Test-Path "$OUTPUT_PATH/7zip")
{
    Remove-Item "$OUTPUT_PATH/7zip" -recurse
}

if (Test-Path "$OUTPUT_PATH/dex2jar")
{
    Remove-Item "$OUTPUT_PATH/dex2jar" -recurse
}
echo "===============================================delete tmp end"
echo "===============================================apktool start"
java -jar "-Duser.language=en" "-Dfile.encoding=UTF8" "$CURRENT_DIR/apktool.jar" d -f $INPUT_FILE -o "$OUTPUT_PATH/apktool/"
echo "===============================================apktool end"
echo "===============================================7zip start"
7z.exe x $INPUT_FILE -o"$OUTPUT_PATH/7zip/" -y
echo "===============================================7zip end"
echo "===============================================dex2jar start"
dex2jar-2.1-SNAPSHOT/d2j-dex2jar.bat "$OUTPUT_PATH/7zip/classes.dex" -o "$OUTPUT_PATH/dex2jar/classes.jar"
echo "===============================================dex2jar end"
echo "===============================================jd-gui start"
jd-gui.exe "$OUTPUT_PATH/dex2jar/classes.jar"
echo "===============================================jd-gui end"