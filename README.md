# ERi-TV Live Streaming App

A Flutter application for streaming Eritrean TV channels live from ERi-TV.

## Features

- 📺 **Live TV Streaming**: Watch ERi-TV live channels directly from the M3U playlist
- 🎬 **Video Player**: Full-featured video player with playback controls
- 📱 **Responsive Design**: Works seamlessly on both portrait and landscape modes
- 🌙 **Dark Theme**: Modern dark-themed UI for better viewing experience
- 📰 **News Articles**: Browse news articles and updates with bookmarking support
- 🌐 **Multi-Language Support**: Available in Tigrinya, Arabic, and English
- ⭐ **Favorites**: Save and manage your favorite channels
- 📑 **Bookmarks**: Bookmark news articles for later reading
- 🖼️ **Picture-in-Picture**: Watch videos while using other apps (Android)
- 📡 **Chromecast Ready**: Framework for casting to Chromecast devices
- 🔄 **Pull to Refresh**: Easy refresh of channel listings and news
- ⚡ **Fast Loading**: Efficient M3U parsing and streaming

## Channel Source

The app streams channels from the official M3U playlist:
https://github.com/Idris7umed/iptv/blob/master/streams/er.m3u

## Screenshots

The app features:
- Home screen with channel list
- Full-screen video player
- News section (coming soon)
- Bottom navigation for easy switching between sections

## Getting Started

### Quick Start

New to Flutter? Check out our **[Quick Start Guide](QUICKSTART.md)** for step-by-step instructions!

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Idris7umed/Eritv-App.git
cd Eritv-App
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

For detailed setup instructions, see [SETUP.md](SETUP.md)

## Dependencies

- **video_player**: Video playback functionality
- **chewie**: Enhanced video player with controls
- **http**: HTTP requests for fetching M3U playlist and news
- **flutter_spinkit**: Loading animations
- **shared_preferences**: Local storage for favorites and settings
- **flutter_localizations**: Multi-language support
- **intl**: Internationalization and date formatting
- **wakelock_plus**: Keep screen awake during video playback

## Project Structure

```
lib/
├── main.dart                      # App entry point with localization
├── models/
│   ├── channel.dart              # Channel data model
│   └── news_article.dart         # News article data model
├── services/
│   ├── m3u_parser.dart           # M3U playlist parser
│   ├── news_service.dart         # News fetching service
│   ├── favorites_service.dart    # Favorites and bookmarks management
│   ├── localization_service.dart # Language preference management
│   ├── pip_service.dart          # Picture-in-Picture support
│   └── chromecast_service.dart   # Chromecast integration
├── screens/
│   ├── home_screen.dart          # Main screen with navigation
│   ├── player_screen.dart        # Video player with PiP and Cast
│   ├── news_screen.dart          # News articles with bookmarks
│   ├── news_detail_screen.dart   # Individual article view
│   ├── favorites_screen.dart     # Favorite channels list
│   └── settings_screen.dart      # App settings and language selection
├── l10n/
│   └── app_localizations.dart    # Translations (EN, TI, AR)
└── widgets/                      # Reusable widgets
```

## Building for Release

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Completed Features

- [x] News articles and updates
- [x] Multiple language support (Tigrinya, Arabic, English)
- [x] Favorites and bookmarks
- [x] Picture-in-picture mode (Android)
- [x] Chromecast support (Framework ready)

## Future Features

- [ ] EPG (Electronic Program Guide)
- [ ] Full Google Cast SDK integration
- [ ] iOS Picture-in-Picture support
- [ ] Social media integration
- [ ] Push notifications for live events
- [ ] Download news for offline reading
- [ ] Video quality selection
- [ ] Playback speed control

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.

## Contact

For questions or suggestions, please open an issue on GitHub.

## Acknowledgments

- ERi-TV for providing the streaming service
- Flutter team for the amazing framework
- All contributors to this project