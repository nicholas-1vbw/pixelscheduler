#!/bin/bash
set -e

PROJECT="PixelScheduler.xcodeproj"
SCHEME="PixelScheduler"
CONFIGURATION="Release"
BUILD_DIR="build"
ARTIFACTS_DIR="artifacts"

echo "Building $SCHEME..."

xcodebuild -project "$PROJECT" \
           -scheme "$SCHEME" \
           -configuration "$CONFIGURATION" \
           -derivedDataPath "$BUILD_DIR" \
           clean build

APP_PATH=$(find "$BUILD_DIR" -name "PixelScheduler.app" -type d | head -n 1)

if [ -z "$APP_PATH" ]; then
    echo "Error: Could not find PixelScheduler.app"
    exit 1
fi

echo "Build successful! App located at: $APP_PATH"

# Create artifacts directory
mkdir -p "$ARTIFACTS_DIR"

# Create ZIP
echo "Creating ZIP archive..."
ZIP_NAME="$ARTIFACTS_DIR/PixelScheduler.zip"
# -y preserves symlinks (important for macOS apps)
# -r is recursive
# -q is quiet
# We cd into the app's directory to avoid including the whole build path
cd "$(dirname "$APP_PATH")"
zip -ryq "$OLDPWD/$ZIP_NAME" "$(basename "$APP_PATH")"
cd "$OLDPWD"

# Create DMG
echo "Creating DMG image..."
DMG_NAME="$ARTIFACTS_DIR/PixelScheduler.dmg"
hdiutil create -volname "PixelScheduler" -srcfolder "$APP_PATH" -ov -format UDZO "$DMG_NAME" -quiet

echo "Packaging successful!"
echo "Artifacts located in: $ARTIFACTS_DIR"
ls -lh "$ARTIFACTS_DIR"
