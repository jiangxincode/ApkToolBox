$CURRENT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
echo "CURRENT_DIR is: $CURRENT_DIR"
echo "===============================================delete tmp start"
Remove-Item "$CURRENT_DIR/tmp" -recurse
echo "===============================================delete tmp end"
echo "===============================================apktool start"
java -jar "-Duser.language=en" "-Dfile.encoding=UTF8" "$CURRENT_DIR/apktool.jar" d -f "$CURRENT_DIR/test.apk" -o "$CURRENT_DIR/tmp/apktool/"
echo "===============================================apktool end"
echo "===============================================7zip start"
7z.exe x "test.apk" -o"$CURRENT_DIR/tmp/7zip/" -y
echo "===============================================7zip end"
echo "===============================================dex2jar start"
dex2jar-2.1-SNAPSHOT/d2j-dex2jar.bat "$CURRENT_DIR/tmp/7zip/classes.dex" -o "$CURRENT_DIR/tmp/dex2jar/classes.jar"
echo "===============================================dex2jar end"
echo "===============================================jd-gui start"
jd-gui.exe "$CURRENT_DIR/tmp/dex2jar/classes.jar"
echo "===============================================jd-gui end"