#!/bin/bash

# Create a temporary directory for the app bundle
mkdir -p dist/mac/AutoTyper.app/Contents/{MacOS,Resources,Java}

# Copy the JAR file and its dependencies
cp target/autotyper-1.0-SNAPSHOT.jar dist/mac/AutoTyper.app/Contents/Java/
cp -r target/lib/* dist/mac/AutoTyper.app/Contents/Java/

# Create the Info.plist file
cat > dist/mac/AutoTyper.app/Contents/Info.plist << EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>JavaAppLauncher</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>CFBundleIdentifier</key>
    <string>com.autotyper</string>
    <key>CFBundleName</key>
    <string>AutoTyper</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>JVMMainClassName</key>
    <string>com.autotyper.Main</string>
    <key>JVMOptions</key>
    <array>
        <string>-Djavafx.verbose=true</string>
    </array>
</dict>
</plist>
EOL

# Create the launcher script
cat > dist/mac/AutoTyper.app/Contents/MacOS/JavaAppLauncher << EOL
#!/bin/bash
DIR="\$( cd "\$( dirname "\${BASH_SOURCE[0]}" )" && pwd )"
java -jar "\$DIR/../Java/autotyper-1.0-SNAPSHOT.jar"
EOL

# Make the launcher executable
chmod +x dist/mac/AutoTyper.app/Contents/MacOS/JavaAppLauncher

# Copy the icon
cp src/main/resources/images/icon.png dist/mac/AutoTyper.app/Contents/Resources/AppIcon.icns

# Create the DMG
hdiutil create -volname "AutoTyper" -srcfolder dist/mac/AutoTyper.app -ov -format UDZO dist/mac/AutoTyper.dmg

echo "DMG file created at dist/mac/AutoTyper.dmg" 