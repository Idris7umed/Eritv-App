import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eritv_app/services/localization_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocalizationService', () {
    late LocalizationService localizationService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      localizationService = LocalizationService();
    });

    test('has correct supported locales', () {
      expect(LocalizationService.supportedLocales.length, 3);
      expect(
        LocalizationService.supportedLocales.map((l) => l.languageCode).toList(),
        containsAll(['en', 'ti', 'ar']),
      );
    });

    test('defaults to English locale', () async {
      final locale = await localizationService.getLocale();
      expect(locale.languageCode, 'en');
    });

    test('can set and get locale', () async {
      await localizationService.setLocale(const Locale('ti'));
      final locale = await localizationService.getLocale();
      
      expect(locale.languageCode, 'ti');
    });

    test('returns correct language names', () {
      expect(localizationService.getLanguageName('en'), 'English');
      expect(localizationService.getLanguageName('ti'), 'ትግርኛ');
      expect(localizationService.getLanguageName('ar'), 'العربية');
      expect(localizationService.getLanguageName('unknown'), 'English');
    });

    test('static method returns correct language names', () {
      expect(
        LocalizationService.getLanguageNameForLocale(const Locale('en')),
        'English',
      );
      expect(
        LocalizationService.getLanguageNameForLocale(const Locale('ti')),
        'ትግርኛ',
      );
      expect(
        LocalizationService.getLanguageNameForLocale(const Locale('ar')),
        'العربية',
      );
    });
  });
}
