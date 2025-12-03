# ERi-TV Live Streaming App

A Flutter application for streaming Eritrean TV channels live from ERi-TV.

## Features

- 📺 **Live TV Streaming**: Watch ERi-TV live channels directly from the M3U playlist
- 🎬 **Video Player**: Full-featured video player with playback controls
- 📱 **Responsive Design**: Works seamlessly on both portrait and landscape modes
- 🌙 **Dark Theme**: Modern dark-themed UI for better viewing experience
- 📰 **News Section**: Placeholder for upcoming news feature
- 🔄 **Pull to Refresh**: Easy refresh of channel listings
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

## Dependencies

- **video_player**: Video playback functionality
- **chewie**: Enhanced video player with controls
- **http**: HTTP requests for fetching M3U playlist
- **flutter_spinkit**: Loading animations

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── channel.dart         # Channel data model
├── services/
│   └── m3u_parser.dart      # M3U playlist parser
├── screens/
│   ├── home_screen.dart     # Main screen with channel list
│   ├── player_screen.dart   # Video player screen
│   └── news_screen.dart     # News section (coming soon)
└── widgets/                 # Reusable widgets (if needed)
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

## Future Features

- [ ] News articles and updates
- [ ] Multiple language support (Tigrinya, Arabic, English)
- [ ] EPG (Electronic Program Guide)
- [ ] Favorites and bookmarks
- [ ] Picture-in-picture mode
- [ ] Chromecast support
- [ ] Social media integration
- [ ] Push notifications for live events

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