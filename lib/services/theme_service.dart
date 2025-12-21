import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _themeKey = 'app_theme_mode';
  
  // Singleton pattern
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeKey);
    
    if (themeModeString == null) {
      // Default to dark mode to maintain consistency with the original app design
      // which was built with a dark theme in mind
      return ThemeMode.dark;
    }
    
    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.dark;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String themeModeString;
    
    switch (mode) {
      case ThemeMode.light:
        themeModeString = 'light';
        break;
      case ThemeMode.dark:
        themeModeString = 'dark';
        break;
      case ThemeMode.system:
        themeModeString = 'system';
        break;
    }
    
    await prefs.setString(_themeKey, themeModeString);
  }

  String getThemeModeName(ThemeMode mode, {String? lightLabel, String? darkLabel, String? systemLabel}) {
    switch (mode) {
      case ThemeMode.light:
        return lightLabel ?? 'Light';
      case ThemeMode.dark:
        return darkLabel ?? 'Dark';
      case ThemeMode.system:
        return systemLabel ?? 'System';
    }
  }
}
