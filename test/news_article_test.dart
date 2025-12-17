import 'package:flutter_test/flutter_test.dart';
import 'package:eritv_app/models/news_article.dart';

void main() {
  group('NewsArticle', () {
    test('creates article from valid JSON', () {
      final json = {
        'id': '1',
        'title': 'Test Article',
        'description': 'Test description',
        'content': 'Test content',
        'imageUrl': 'https://example.com/image.jpg',
        'publishedAt': '2023-12-01T10:00:00Z',
        'source': 'ERi-TV',
        'language': 'en',
      };

      final article = NewsArticle.fromJson(json);

      expect(article.id, '1');
      expect(article.title, 'Test Article');
      expect(article.description, 'Test description');
      expect(article.content, 'Test content');
      expect(article.imageUrl, 'https://example.com/image.jpg');
      expect(article.source, 'ERi-TV');
      expect(article.language, 'en');
      expect(article.publishedAt, isA<DateTime>());
    });

    test('handles missing optional fields', () {
      final json = {
        'id': '1',
        'title': 'Test Article',
      };

      final article = NewsArticle.fromJson(json);

      expect(article.id, '1');
      expect(article.title, 'Test Article');
      expect(article.description, '');
      expect(article.content, '');
      expect(article.imageUrl, '');
      expect(article.source, 'Unknown');
      expect(article.language, 'en');
    });

    test('converts article to JSON', () {
      final article = NewsArticle(
        id: '1',
        title: 'Test Article',
        description: 'Test description',
        content: 'Test content',
        imageUrl: 'https://example.com/image.jpg',
        publishedAt: DateTime.parse('2023-12-01T10:00:00Z'),
        source: 'ERi-TV',
        language: 'en',
      );

      final json = article.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Article');
      expect(json['description'], 'Test description');
      expect(json['content'], 'Test content');
      expect(json['imageUrl'], 'https://example.com/image.jpg');
      expect(json['source'], 'ERi-TV');
      expect(json['language'], 'en');
      expect(json['publishedAt'], isA<String>());
    });

    test('toString returns formatted string', () {
      final article = NewsArticle(
        id: '1',
        title: 'Test Article',
        description: 'Test description',
        content: 'Test content',
        imageUrl: 'https://example.com/image.jpg',
        publishedAt: DateTime.parse('2023-12-01T10:00:00Z'),
        source: 'ERi-TV',
        language: 'en',
      );

      final string = article.toString();

      expect(string, contains('NewsArticle'));
      expect(string, contains('id: 1'));
      expect(string, contains('title: Test Article'));
    });
  });
}
