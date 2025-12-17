import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/channel.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_channels';
  static const String _bookmarkedNewsKey = 'bookmarked_news';

  // Singleton pattern
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  // Channel favorites
  Future<List<String>> getFavoriteChannelIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString(_favoritesKey);
    if (favoritesJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(favoritesJson);
    return decoded.cast<String>();
  }

  Future<bool> isFavoriteChannel(String channelId) async {
    final favorites = await getFavoriteChannelIds();
    return favorites.contains(channelId);
  }

  Future<void> toggleFavoriteChannel(String channelId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteChannelIds();
    
    if (favorites.contains(channelId)) {
      favorites.remove(channelId);
    } else {
      favorites.add(channelId);
    }
    
    await prefs.setString(_favoritesKey, jsonEncode(favorites));
  }

  Future<void> addFavoriteChannel(String channelId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteChannelIds();
    
    if (!favorites.contains(channelId)) {
      favorites.add(channelId);
      await prefs.setString(_favoritesKey, jsonEncode(favorites));
    }
  }

  Future<void> removeFavoriteChannel(String channelId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteChannelIds();
    
    favorites.remove(channelId);
    await prefs.setString(_favoritesKey, jsonEncode(favorites));
  }

  // News bookmarks
  Future<List<String>> getBookmarkedNewsIds() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getString(_bookmarkedNewsKey);
    if (bookmarksJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(bookmarksJson);
    return decoded.cast<String>();
  }

  Future<bool> isBookmarkedNews(String newsId) async {
    final bookmarks = await getBookmarkedNewsIds();
    return bookmarks.contains(newsId);
  }

  Future<void> toggleBookmarkNews(String newsId) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarkedNewsIds();
    
    if (bookmarks.contains(newsId)) {
      bookmarks.remove(newsId);
    } else {
      bookmarks.add(newsId);
    }
    
    await prefs.setString(_bookmarkedNewsKey, jsonEncode(bookmarks));
  }

  Future<void> addBookmarkNews(String newsId) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarkedNewsIds();
    
    if (!bookmarks.contains(newsId)) {
      bookmarks.add(newsId);
      await prefs.setString(_bookmarkedNewsKey, jsonEncode(bookmarks));
    }
  }

  Future<void> removeBookmarkNews(String newsId) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarkedNewsIds();
    
    bookmarks.remove(newsId);
    await prefs.setString(_bookmarkedNewsKey, jsonEncode(bookmarks));
  }
}
