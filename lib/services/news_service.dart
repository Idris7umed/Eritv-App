import '../models/news_article.dart';

class NewsService {
  // Singleton pattern
  static final NewsService _instance = NewsService._internal();
  factory NewsService() => _instance;
  NewsService._internal();

  // Sample news data - in a real app, this would fetch from an API
  Future<List<NewsArticle>> fetchNews({String language = 'en'}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return sample news articles based on language
    return _getSampleNews(language);
  }

  List<NewsArticle> _getSampleNews(String language) {
    final now = DateTime.now();
    
    if (language == 'ti') {
      // Tigrinya news
      return [
        NewsArticle(
          id: 'ti_1',
          title: 'ኣብ ኤርትራ ዝርከቡ ሓድሽ መደባት ልምዓት',
          description: 'ኣብ መላእ ሃገር ሓድሽ መደባት ልምዓት ይካየዱ ኣለዉ።',
          content: 'ኣብ መላእ ሃገር ሓድሽ መደባት ልምዓት ዝርዝር ይካየዱ ኣለዉ። እዚ መደባት እዚ ኣብ ዝተፈላለዩ ዓውድታት ዝግበር እዩ።',
          imageUrl: 'https://via.placeholder.com/400x200',
          publishedAt: now.subtract(const Duration(hours: 2)),
          source: 'ERi-TV',
          language: 'ti',
        ),
        NewsArticle(
          id: 'ti_2',
          title: 'ባህላዊ በዓል ናጽነት ዓመታዊ',
          description: 'ናይ ናጽነት ዓመታዊ በዓል ብድምቀት ተኻይዱ።',
          content: 'ናይ ናጽነት ዓመታዊ በዓል ብዓቢ ድምቀት ተኻይዱ። ኣብዚ በዓል እዚ ብዙሓት ዜጋታት ተሳቲፎም።',
          imageUrl: 'https://via.placeholder.com/400x200',
          publishedAt: now.subtract(const Duration(hours: 5)),
          source: 'ERi-TV',
          language: 'ti',
        ),
      ];
    } else if (language == 'ar') {
      // Arabic news
      return [
        NewsArticle(
          id: 'ar_1',
          title: 'مشاريع تنموية جديدة في إريتريا',
          description: 'يتم تنفيذ مشاريع تنموية جديدة في جميع أنحاء البلاد.',
          content: 'يتم تنفيذ مشاريع تنموية جديدة في جميع أنحاء البلاد. تشمل هذه المشاريع مختلف القطاعات.',
          imageUrl: 'https://via.placeholder.com/400x200',
          publishedAt: now.subtract(const Duration(hours: 2)),
          source: 'ERi-TV',
          language: 'ar',
        ),
        NewsArticle(
          id: 'ar_2',
          title: 'الاحتفال السنوي بعيد الاستقلال',
          description: 'تم الاحتفال بعيد الاستقلال السنوي بمراسم مهيبة.',
          content: 'تم الاحتفال بعيد الاستقلال السنوي بمراسم مهيبة. شارك في هذا الاحتفال العديد من المواطنين.',
          imageUrl: 'https://via.placeholder.com/400x200',
          publishedAt: now.subtract(const Duration(hours: 5)),
          source: 'ERi-TV',
          language: 'ar',
        ),
      ];
    } else {
      // English news (default)
      return [
        NewsArticle(
          id: 'en_1',
          title: 'New Development Projects in Eritrea',
          description: 'New development projects are being implemented across the country.',
          content: 'New development projects are being implemented across the country. These projects cover various sectors including infrastructure, agriculture, and education. The government has announced significant investment in these initiatives.',
          imageUrl: 'https://via.placeholder.com/400x200',
          publishedAt: now.subtract(const Duration(hours: 2)),
          source: 'ERi-TV',
          language: 'en',
        ),
        NewsArticle(
          id: 'en_2',
          title: 'Annual Independence Day Celebration',
          description: 'The annual Independence Day was celebrated with grand ceremonies.',
          content: 'The annual Independence Day was celebrated with grand ceremonies across the nation. Citizens participated in various cultural activities and festivities marking the historic occasion.',
          imageUrl: 'https://via.placeholder.com/400x200',
          publishedAt: now.subtract(const Duration(hours: 5)),
          source: 'ERi-TV',
          language: 'en',
        ),
        NewsArticle(
          id: 'en_3',
          title: 'Education Sector Improvements',
          description: 'Government announces new initiatives to improve education quality.',
          content: 'The Ministry of Education has announced several new initiatives aimed at improving the quality of education throughout the country. These include teacher training programs and infrastructure development.',
          imageUrl: 'https://via.placeholder.com/400x200',
          publishedAt: now.subtract(const Duration(hours: 8)),
          source: 'ERi-TV',
          language: 'en',
        ),
        NewsArticle(
          id: 'en_4',
          title: 'Agricultural Achievements Highlighted',
          description: 'Recent agricultural initiatives show promising results.',
          content: 'Recent agricultural initiatives have shown promising results with increased crop yields and improved farming techniques. Local farmers report positive outcomes from new irrigation systems.',
          imageUrl: 'https://via.placeholder.com/400x200',
          publishedAt: now.subtract(const Duration(days: 1)),
          source: 'ERi-TV',
          language: 'en',
        ),
      ];
    }
  }

  Future<List<NewsArticle>> searchNews(String query, {String language = 'en'}) async {
    final allNews = await fetchNews(language: language);
    return allNews.where((article) {
      return article.title.toLowerCase().contains(query.toLowerCase()) ||
             article.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
