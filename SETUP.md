# Setup Guide

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Flutter SDK** (3.0.0 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Add Flutter to your PATH

2. **Dart SDK** (comes with Flutter)

3. **Development Tools**
   - **For Android**: Android Studio with Android SDK
   - **For iOS**: Xcode (macOS only)

4. **Git**
   - For cloning the repository

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/Idris7umed/Eritv-App.git
cd Eritv-App
```

### 2. Verify Flutter Installation

```bash
flutter doctor
```

Fix any issues reported by `flutter doctor` before proceeding.

### 3. Install Dependencies

```bash
flutter pub get
```

This will download all required packages specified in `pubspec.yaml`.

### 4. Run the App

#### On Android Emulator/Device:
```bash
flutter run
```

#### On iOS Simulator/Device (macOS only):
```bash
flutter run
```

#### On Web:
```bash
flutter run -d chrome
```

## Development Setup

### Android Setup

1. **Install Android Studio**
   - Download from: https://developer.android.com/studio

2. **Install Android SDK**
   - Open Android Studio
   - Go to Settings → Appearance & Behavior → System Settings → Android SDK
   - Install Android SDK Platform 34 (or latest)
   - Install Android SDK Build-Tools

3. **Create Android Emulator**
   - Open Android Studio
   - Go to Tools → Device Manager
   - Create a new virtual device
   - Choose a device definition and system image

4. **Run on Android**
   ```bash
   flutter run
   ```

### iOS Setup (macOS only)

1. **Install Xcode**
   - Download from Mac App Store
   - Install Xcode Command Line Tools:
     ```bash
     sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
     sudo xcodebuild -runFirstLaunch
     ```

2. **Install CocoaPods**
   ```bash
   sudo gem install cocoapods
   ```

3. **Setup iOS Dependencies**
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run on iOS**
   ```bash
   flutter run
   ```

## IDE Setup

### Visual Studio Code

1. **Install VS Code**
   - Download from: https://code.visualstudio.com/

2. **Install Flutter Extension**
   - Open VS Code
   - Go to Extensions (Ctrl+Shift+X)
   - Search for "Flutter"
   - Install Flutter extension (this will also install Dart extension)

3. **Recommended Extensions**
   - Flutter
   - Dart
   - Error Lens
   - Bracket Pair Colorizer

### Android Studio

1. **Install Flutter Plugin**
   - Open Android Studio
   - Go to Settings → Plugins
   - Search for "Flutter"
   - Install Flutter plugin (this will also install Dart plugin)

2. **Import Project**
   - Open Android Studio
   - Click "Open an Existing Project"
   - Select the Eritv-App folder

## Building for Production

### Android APK

```bash
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

The bundle will be located at: `build/app/outputs/bundle/release/app-release.aab`

### iOS (macOS only)

```bash
flutter build ios --release
```

Then open Xcode to archive and upload to App Store.

## Troubleshooting

### Common Issues

1. **"Flutter command not found"**
   - Ensure Flutter is added to your PATH
   - Run: `export PATH="$PATH:/path/to/flutter/bin"`

2. **Gradle build fails**
   - Update Gradle: `cd android && ./gradlew wrapper --gradle-version=7.5`
   - Clean build: `flutter clean && flutter pub get`

3. **CocoaPods issues (iOS)**
   - Update CocoaPods: `sudo gem install cocoapods`
   - Clean pods: `cd ios && rm -rf Pods Podfile.lock && pod install`

4. **Video player not working**
   - Ensure internet permission is set in AndroidManifest.xml
   - Check NSAppTransportSecurity in Info.plist for iOS
   - Verify the stream URL is accessible

5. **Dependencies fail to install**
   - Run: `flutter pub cache repair`
   - Delete pubspec.lock and run: `flutter pub get`

## Testing

### Run Unit Tests

```bash
flutter test
```

### Run Specific Test

```bash
flutter test test/m3u_parser_test.dart
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

## Environment Variables

No environment variables are required for basic functionality. The M3U playlist URL is hardcoded in the app.

## Network Requirements

The app requires internet connectivity to:
- Fetch the M3U playlist from GitHub
- Stream video content from ERi-TV servers

Ensure your development device has internet access and isn't behind a restrictive firewall.

## Next Steps

After successful setup:
1. Read FEATURES.md to understand the app's capabilities
2. Explore the code structure in lib/
3. Run tests to verify everything works
4. Start developing new features!

## Support

For issues or questions:
- Open an issue on GitHub
- Check existing issues for solutions
- Refer to Flutter documentation: https://flutter.dev/docs
