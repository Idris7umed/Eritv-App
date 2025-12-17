import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  static const String _languageKey = 'app_language';
  
  // Supported languages
  static const List<Locale> supportedLocales = [
    Locale('en', ''), // English
    Locale('ti', ''), // Tigrinya
    Locale('ar', ''), // Arabic
  ];

  // Singleton pattern
  static final LocalizationService _instance = LocalizationService._internal();
  factory LocalizationService() => _instance;
  LocalizationService._internal();

  Future<Locale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey);
    
    if (languageCode == null) {
      return const Locale('en', '');
    }
    
    return Locale(languageCode, '');
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, locale.languageCode);
  }

  String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'ti':
        return 'ትግርኛ'; // Tigrinya
      case 'ar':
        return 'العربية'; // Arabic
      default:
        return 'English';
    }
  }

  static String getLanguageNameForLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ti':
        return 'ትግርኛ';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }
}
