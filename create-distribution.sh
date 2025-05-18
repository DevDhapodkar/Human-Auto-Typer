#!/bin/bash

# Create distribution directory
mkdir -p dist/AutoTyper

# Copy necessary files
cp target/autotyper-1.0-SNAPSHOT.jar dist/AutoTyper/autotyper-1.0-SNAPSHOT.jar
cp -r target/lib dist/AutoTyper/
cp setup.bat dist/AutoTyper/
cp README.md dist/AutoTyper/
cp LICENSE dist/AutoTyper/

# Create zip file
cd dist
zip -r AutoTyper.zip AutoTyper
cd ..

echo "Distribution package created at dist/AutoTyper.zip" 