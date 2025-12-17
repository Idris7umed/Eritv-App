import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Translations map
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'ERi-TV',
      'live_tv': 'Live TV',
      'news': 'News',
      'favorites': 'Favorites',
      'settings': 'Settings',
      'loading_channels': 'Loading channels...',
      'error_loading_channels': 'Error loading channels',
      'retry': 'Retry',
      'no_channels_available': 'No channels available',
      'initializing_player': 'Initializing player...',
      'error_loading_stream': 'Error loading stream',
      'news_coming_soon': 'News feature coming soon!',
      'news_description': 'Stay tuned for the latest updates and news about Eritrea.',
      'coming_soon': 'Coming Soon',
      'no_favorites': 'No favorite channels yet',
      'add_favorites_description': 'Add channels to your favorites by tapping the heart icon.',
      'language': 'Language',
      'select_language': 'Select Language',
      'no_news_available': 'No news available',
      'loading_news': 'Loading news...',
      'bookmarked': 'Bookmarked',
      'no_bookmarks': 'No bookmarked articles yet',
      'bookmark_description': 'Bookmark interesting articles to read later.',
      'read_more': 'Read More',
      'share': 'Share',
      'published': 'Published',
      'source': 'Source',
      'cast_to_device': 'Cast to Device',
      'chromecast_info': 'Chromecast functionality is available but requires Google Play Services to be fully configured.',
      'chromecast_future': 'This feature will be fully enabled in a future update.',
      'ok': 'OK',
    },
    'ti': {
      'app_title': 'ERi-TV',
      'live_tv': 'ቀጥታዊ ቲቪ',
      'news': 'ዜና',
      'favorites': 'ዝሓለፍኩዎም',
      'settings': 'ምቁራጽ',
      'loading_channels': 'ቻነላት ይጽዕን ኣሎ...',
      'error_loading_channels': 'ቻነላት ኣብ ምጽዓን ጌጋ',
      'retry': 'ደጊምካ ፈትን',
      'no_channels_available': 'ዝርከቡ ቻነላት የለዉን',
      'initializing_player': 'ተጻዋቲ ይጅምር ኣሎ...',
      'error_loading_stream': 'ስትሪም ኣብ ምጽዓን ጌጋ',
      'news_coming_soon': 'ዜና ብቐረባ ይመጽእ!',
      'news_description': 'ብዛዕባ ኤርትራ ዝተሓደሱ ሓበሬታታት ንምርካብ ተጸበዩ።',
      'coming_soon': 'ብቐረባ ይመጽእ',
      'no_favorites': 'ሕሱር ዝሓለፍኩዎም ቻነላት የብልኩምን',
      'add_favorites_description': 'ቻነላት ናብ ዝሓለፍኩዎም ንምውሳኽ ልቢ ምልክት ጠውቑ።',
      'language': 'ቋንቋ',
      'select_language': 'ቋንቋ መርጽ',
      'no_news_available': 'ዝርከብ ዜና የለን',
      'loading_news': 'ዜና ይጽዕን ኣሎ...',
      'bookmarked': 'ዝተዓቀበ',
      'no_bookmarks': 'ሕሱር ዝተዓቀቡ ጽሑፋት የብልኩምን',
      'bookmark_description': 'ዘገድሱኩም ጽሑፋት ጌርኩም ንምንባብ ዓቕቡ።',
      'read_more': 'ተወሳኺ ኣንብብ',
      'share': 'ኣካፍል',
      'published': 'ዝተዓተመ',
      'source': 'ምንጪ',
      'cast_to_device': 'ናብ መሳርሒ ስደድ',
      'chromecast_info': 'Chromecast ተግባር ኣሎ ግን ጉግል ፕለይ ሰርቪስ ምምልማል የድሊ።',
      'chromecast_future': 'እዚ ባህሪ ኣብ መጻኢ ምዕባለ ምሉእ ብምሉእ ክንቀጸል እዩ።',
      'ok': 'እወ',
    },
    'ar': {
      'app_title': 'ERi-TV',
      'live_tv': 'التلفزيون المباشر',
      'news': 'الأخبار',
      'favorites': 'المفضلة',
      'settings': 'الإعدادات',
      'loading_channels': 'جارٍ تحميل القنوات...',
      'error_loading_channels': 'خطأ في تحميل القنوات',
      'retry': 'إعادة المحاولة',
      'no_channels_available': 'لا توجد قنوات متاحة',
      'initializing_player': 'جارٍ تهيئة المشغل...',
      'error_loading_stream': 'خطأ في تحميل البث',
      'news_coming_soon': 'ميزة الأخبار قريبًا!',
      'news_description': 'ترقبوا آخر التحديثات والأخبار حول إريتريا.',
      'coming_soon': 'قريباً',
      'no_favorites': 'لا توجد قنوات مفضلة بعد',
      'add_favorites_description': 'أضف القنوات إلى المفضلة بالنقر على أيقونة القلب.',
      'language': 'اللغة',
      'select_language': 'اختر اللغة',
      'no_news_available': 'لا توجد أخبار متاحة',
      'loading_news': 'جارٍ تحميل الأخبار...',
      'bookmarked': 'محفوظ',
      'no_bookmarks': 'لا توجد مقالات محفوظة بعد',
      'bookmark_description': 'احفظ المقالات المثيرة للاهتمام لقراءتها لاحقًا.',
      'read_more': 'اقرأ المزيد',
      'share': 'مشاركة',
      'published': 'تاريخ النشر',
      'source': 'المصدر',
      'cast_to_device': 'البث إلى الجهاز',
      'chromecast_info': 'وظيفة Chromecast متاحة ولكنها تتطلب تكوين خدمات Google Play بشكل كامل.',
      'chromecast_future': 'سيتم تفعيل هذه الميزة بالكامل في تحديث مستقبلي.',
      'ok': 'حسناً',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Convenience getters
  String get appTitle => translate('app_title');
  String get liveTV => translate('live_tv');
  String get news => translate('news');
  String get favorites => translate('favorites');
  String get settings => translate('settings');
  String get loadingChannels => translate('loading_channels');
  String get errorLoadingChannels => translate('error_loading_channels');
  String get retry => translate('retry');
  String get noChannelsAvailable => translate('no_channels_available');
  String get initializingPlayer => translate('initializing_player');
  String get errorLoadingStream => translate('error_loading_stream');
  String get newsComingSoon => translate('news_coming_soon');
  String get newsDescription => translate('news_description');
  String get comingSoon => translate('coming_soon');
  String get noFavorites => translate('no_favorites');
  String get addFavoritesDescription => translate('add_favorites_description');
  String get language => translate('language');
  String get selectLanguage => translate('select_language');
  String get noNewsAvailable => translate('no_news_available');
  String get loadingNews => translate('loading_news');
  String get bookmarked => translate('bookmarked');
  String get noBookmarks => translate('no_bookmarks');
  String get bookmarkDescription => translate('bookmark_description');
  String get readMore => translate('read_more');
  String get share => translate('share');
  String get published => translate('published');
  String get source => translate('source');
  String get castToDevice => translate('cast_to_device');
  String get chromecastInfo => translate('chromecast_info');
  String get chromecastFuture => translate('chromecast_future');
  String get ok => translate('ok');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ti', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
