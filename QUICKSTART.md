# Quick Start Guide

Get ERi-TV app up and running in 5 minutes!

## Prerequisites Check

```bash
# Check if Flutter is installed
flutter --version

# If not installed, visit: https://flutter.dev/docs/get-started/install
```

## Installation (3 steps)

### 1. Clone the repository
```bash
git clone https://github.com/Idris7umed/Eritv-App.git
cd Eritv-App
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Run the app
```bash
flutter run
```

That's it! The app should now be running on your connected device or emulator.

## First Time Setup

If you're new to Flutter development, follow these steps:

### For Android Development

1. **Install Android Studio**
   - Download from: https://developer.android.com/studio
   - During installation, make sure to install Android SDK

2. **Setup an Android Emulator**
   - Open Android Studio
   - Click on "Device Manager" (phone icon)
   - Click "Create Device"
   - Select a phone model (e.g., Pixel 5)
   - Download and select a system image (API 30 or higher recommended)
   - Click Finish

3. **Run the app**
   ```bash
   flutter run
   ```

### For iOS Development (macOS only)

1. **Install Xcode** from the Mac App Store

2. **Install CocoaPods**
   ```bash
   sudo gem install cocoapods
   ```

3. **Setup iOS dependencies**
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Troubleshooting

### Issue: "Flutter command not found"
**Solution:** Add Flutter to your PATH
```bash
export PATH="$PATH:/path/to/flutter/bin"
```

### Issue: "No devices found"
**Solution:** 
- For Android: Start an emulator from Android Studio
- For iOS: Open Simulator from Xcode
- Or connect a physical device with USB debugging enabled

### Issue: "Gradle build failed"
**Solution:** 
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: "CocoaPods error" (iOS)
**Solution:**
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter run
```

## What's Next?

- 📖 Read [README.md](README.md) for full feature list
- 🔧 Check [SETUP.md](SETUP.md) for detailed setup instructions
- 🌟 Explore [FEATURES.md](FEATURES.md) to see what's coming next
- 🤝 Read [CONTRIBUTING.md](CONTRIBUTING.md) to contribute

## Need Help?

- Open an issue on GitHub
- Check existing issues for solutions
- Visit Flutter documentation: https://flutter.dev/docs

## Live TV Streaming

Once the app is running:
1. You'll see the channel list on the home screen
2. Tap on any channel to start streaming
3. Use the video player controls to adjust volume, seek, or toggle fullscreen
4. Switch to "News" tab to see the upcoming news feature

Enjoy watching ERi-TV! 📺
