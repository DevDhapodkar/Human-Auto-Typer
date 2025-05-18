@echo off
echo AutoTyper Setup
echo ==============

REM Check for Java installation
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo Java is not installed! Please install Java 17 or later.
    echo Download from: https://adoptium.net/
    pause
    exit /b 1
)

REM Create application directory
set "APP_DIR=%LOCALAPPDATA%\AutoTyper"
if not exist "%APP_DIR%" mkdir "%APP_DIR%"

REM Copy files
echo Copying files...
copy /Y "target\autotyper-1.0-SNAPSHOT.jar" "%APP_DIR%"
copy /Y "target\lib\*" "%APP_DIR%\lib\"

REM Create desktop shortcut
echo Creating shortcuts...
set "SHORTCUT=%USERPROFILE%\Desktop\AutoTyper.lnk"
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%SHORTCUT%" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "java" >> CreateShortcut.vbs
echo oLink.Arguments = "-jar ""%APP_DIR%\autotyper-1.0-SNAPSHOT.jar""" >> CreateShortcut.vbs
echo oLink.WorkingDirectory = "%APP_DIR%" >> CreateShortcut.vbs
echo oLink.Description = "AutoTyper Application" >> CreateShortcut.vbs
echo oLink.IconLocation = "%APP_DIR%\icon.ico" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript /nologo CreateShortcut.vbs
del CreateShortcut.vbs

echo Setup complete!
echo You can now run AutoTyper from your desktop shortcut.
pause 