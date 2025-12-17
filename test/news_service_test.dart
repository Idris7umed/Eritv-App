import 'package:flutter_test/flutter_test.dart';
import 'package:eritv_app/services/news_service.dart';

void main() {
  group('NewsService', () {
    late NewsService newsService;

    setUp(() {
      newsService = NewsService();
    });

    test('fetches English news by default', () async {
      final articles = await newsService.fetchNews();
      
      expect(articles, isNotEmpty);
      expect(articles.every((article) => article.language == 'en'), isTrue);
    });

    test('fetches Tigrinya news when specified', () async {
      final articles = await newsService.fetchNews(language: 'ti');
      
      expect(articles, isNotEmpty);
      expect(articles.every((article) => article.language == 'ti'), isTrue);
    });

    test('fetches Arabic news when specified', () async {
      final articles = await newsService.fetchNews(language: 'ar');
      
      expect(articles, isNotEmpty);
      expect(articles.every((article) => article.language == 'ar'), isTrue);
    });

    test('all articles have required fields', () async {
      final articles = await newsService.fetchNews();
      
      for (var article in articles) {
        expect(article.id, isNotEmpty);
        expect(article.title, isNotEmpty);
        expect(article.description, isNotEmpty);
        expect(article.content, isNotEmpty);
        expect(article.source, isNotEmpty);
      }
    });

    test('can search news by query', () async {
      final allArticles = await newsService.fetchNews(language: 'en');
      final searchResults = await newsService.searchNews('Development', language: 'en');
      
      expect(searchResults.length, lessThanOrEqualTo(allArticles.length));
      
      if (searchResults.isNotEmpty) {
        expect(
          searchResults.every((article) =>
              article.title.toLowerCase().contains('development') ||
              article.description.toLowerCase().contains('development')),
          isTrue,
        );
      }
    });
  });
}
