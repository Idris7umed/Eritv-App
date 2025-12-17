import 'package:flutter_test/flutter_test.dart';
import 'package:eritv_app/services/favorites_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FavoritesService', () {
    late FavoritesService favoritesService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      favoritesService = FavoritesService();
    });

    test('initially has no favorite channels', () async {
      final favorites = await favoritesService.getFavoriteChannelIds();
      expect(favorites, isEmpty);
    });

    test('can add favorite channel', () async {
      await favoritesService.addFavoriteChannel('channel_1');
      final favorites = await favoritesService.getFavoriteChannelIds();
      
      expect(favorites, contains('channel_1'));
      expect(favorites.length, 1);
    });

    test('can check if channel is favorite', () async {
      await favoritesService.addFavoriteChannel('channel_1');
      
      final isFavorite = await favoritesService.isFavoriteChannel('channel_1');
      final isNotFavorite = await favoritesService.isFavoriteChannel('channel_2');
      
      expect(isFavorite, isTrue);
      expect(isNotFavorite, isFalse);
    });

    test('can remove favorite channel', () async {
      await favoritesService.addFavoriteChannel('channel_1');
      await favoritesService.removeFavoriteChannel('channel_1');
      
      final favorites = await favoritesService.getFavoriteChannelIds();
      expect(favorites, isEmpty);
    });

    test('can toggle favorite channel', () async {
      // Toggle to add
      await favoritesService.toggleFavoriteChannel('channel_1');
      var favorites = await favoritesService.getFavoriteChannelIds();
      expect(favorites, contains('channel_1'));
      
      // Toggle to remove
      await favoritesService.toggleFavoriteChannel('channel_1');
      favorites = await favoritesService.getFavoriteChannelIds();
      expect(favorites, isEmpty);
    });

    test('initially has no bookmarked news', () async {
      final bookmarks = await favoritesService.getBookmarkedNewsIds();
      expect(bookmarks, isEmpty);
    });

    test('can add bookmarked news', () async {
      await favoritesService.addBookmarkNews('news_1');
      final bookmarks = await favoritesService.getBookmarkedNewsIds();
      
      expect(bookmarks, contains('news_1'));
      expect(bookmarks.length, 1);
    });

    test('can toggle bookmark news', () async {
      // Toggle to add
      await favoritesService.toggleBookmarkNews('news_1');
      var bookmarks = await favoritesService.getBookmarkedNewsIds();
      expect(bookmarks, contains('news_1'));
      
      // Toggle to remove
      await favoritesService.toggleBookmarkNews('news_1');
      bookmarks = await favoritesService.getBookmarkedNewsIds();
      expect(bookmarks, isEmpty);
    });
  });
}
