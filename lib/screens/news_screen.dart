import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';
import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  final String currentLanguage;

  const NewsScreen({super.key, this.currentLanguage = 'en'});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService _newsService = NewsService();
  final FavoritesService _favoritesService = FavoritesService();
  List<NewsArticle> _articles = [];
  Set<String> _bookmarkedIds = {};
  bool _isLoading = true;
  String? _error;
  int _selectedTab = 0; // 0 for all news, 1 for bookmarked

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  @override
  void didUpdateWidget(NewsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLanguage != widget.currentLanguage) {
      _loadNews();
    }
  }

  Future<void> _loadNews() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final articles = await _newsService.fetchNews(language: widget.currentLanguage);
      final bookmarkedIds = await _favoritesService.getBookmarkedNewsIds();
      
      setState(() {
        _articles = articles;
        _bookmarkedIds = bookmarkedIds.toSet();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleBookmark(String articleId) async {
    await _favoritesService.toggleBookmarkNews(articleId);
    final bookmarkedIds = await _favoritesService.getBookmarkedNewsIds();
    setState(() {
      _bookmarkedIds = bookmarkedIds.toSet();
    });
  }

  List<NewsArticle> _getDisplayedArticles() {
    if (_selectedTab == 0) {
      return _articles;
    } else {
      return _articles.where((article) => _bookmarkedIds.contains(article.id)).toList();
    }
  }

  Widget _buildArticleCard(NewsArticle article) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final isBookmarked = _bookmarkedIds.contains(article.id);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailScreen(article: article),
            ),
          ).then((_) => _loadNews()); // Reload to update bookmark status
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article image
            if (article.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  article.imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 180,
                      color: isDark ? Colors.grey[800] : Colors.grey[300],
                      child: Icon(
                        Icons.article,
                        size: 64,
                        color: isDark ? Colors.white24 : Colors.black12,
                      ),
                    );
                  },
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          article.title,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked ? Colors.blue : (isDark ? Colors.white60 : Colors.black54),
                        ),
                        onPressed: () => _toggleBookmark(article.id),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontSize: 14,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateFormat.format(article.publishedAt),
                        style: TextStyle(
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.source,
                        size: 14,
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        article.source,
                        style: TextStyle(
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final displayedArticles = _getDisplayedArticles();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Tab bar
        Container(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[200],
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _selectedTab = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _selectedTab == 0
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      l10n?.news ?? 'News',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _selectedTab == 0 ? (isDark ? Colors.white : Colors.black87) : (isDark ? Colors.white60 : Colors.black54),
                        fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _selectedTab = 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _selectedTab == 1
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      l10n?.bookmarked ?? 'Bookmarked',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _selectedTab == 1 ? (isDark ? Colors.white : Colors.black87) : (isDark ? Colors.white60 : Colors.black54),
                        fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Content
        Expanded(
          child: _isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        l10n?.loadingNews ?? 'Loading news...',
                        style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                      ),
                    ],
                  ),
                )
              : _error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n?.errorLoadingChannels ?? 'Error loading news',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              _error!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _loadNews,
                            icon: const Icon(Icons.refresh),
                            label: Text(l10n?.retry ?? 'Retry'),
                          ),
                        ],
                      ),
                    )
                  : displayedArticles.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _selectedTab == 0 ? Icons.article_outlined : Icons.bookmark_border,
                                size: 80,
                                color: isDark ? Colors.white24 : Colors.black12,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                _selectedTab == 0
                                    ? (l10n?.noNewsAvailable ?? 'No news available')
                                    : (l10n?.noBookmarks ?? 'No bookmarked articles yet'),
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: isDark ? Colors.white : Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              if (_selectedTab == 1) ...[
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 48),
                                  child: Text(
                                    l10n?.bookmarkDescription ?? 
                                        'Bookmark interesting articles to read later.',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: isDark ? Colors.white70 : Colors.black54,
                                          height: 1.5,
                                        ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadNews,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: displayedArticles.length,
                            itemBuilder: (context, index) {
                              return _buildArticleCard(displayedArticles[index]);
                            },
                          ),
                        ),
        ),
      ],
    );
  }
}
