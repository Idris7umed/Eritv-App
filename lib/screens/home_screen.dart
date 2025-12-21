import 'package:flutter/material.dart';
import '../models/channel.dart';
import '../services/m3u_parser.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';
import 'player_screen.dart';
import 'news_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final Locale currentLocale;
  final Function(Locale) onLocaleChange;
  final Function(ThemeMode) onThemeModeChange;

  const HomeScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChange,
    required this.onThemeModeChange,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final M3UParser _parser = M3UParser();
  final FavoritesService _favoritesService = FavoritesService();
  List<Channel>? _channels;
  Set<String> _favoriteIds = {};
  bool _isLoading = true;
  String? _error;
  int _selectedIndex = 0;
  bool _hasAutoPlayed = false;

  @override
  void initState() {
    super.initState();
    _loadChannels();
    _loadFavorites();
  }

  Future<void> _loadChannels() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final channels = await _parser.fetchChannels();
      setState(() {
        _channels = channels;
        _isLoading = false;
      });
      
      // Auto-play the first channel when app opens
      if (!_hasAutoPlayed && channels.isNotEmpty && mounted) {
        _hasAutoPlayed = true;
        // Use WidgetsBinding to ensure the first frame is built before navigating
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayerScreen(channel: channels[0]),
              ),
            );
          }
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadFavorites() async {
    final favoriteIds = await _favoritesService.getFavoriteChannelIds();
    setState(() {
      _favoriteIds = favoriteIds.toSet();
    });
  }

  Future<void> _toggleFavorite(String channelId) async {
    await _favoritesService.toggleFavoriteChannel(channelId);
    await _loadFavorites();
  }

  Widget _buildChannelsList() {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              l10n?.loadingChannels ?? 'Loading channels...',
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
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
              l10n?.errorLoadingChannels ?? 'Error loading channels',
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
              onPressed: _loadChannels,
              icon: const Icon(Icons.refresh),
              label: Text(l10n?.retry ?? 'Retry'),
            ),
          ],
        ),
      );
    }

    if (_channels == null || _channels!.isEmpty) {
      return Center(
        child: Text(
          l10n?.noChannelsAvailable ?? 'No channels available',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadChannels,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _channels!.length,
        itemBuilder: (context, index) {
          final channel = _channels![index];
          final isFavorite = _favoriteIds.contains(channel.id);
          final isDark = Theme.of(context).brightness == Brightness.dark;
          
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.live_tv,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              title: Text(
                channel.name,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                channel.id.isNotEmpty ? channel.id : 'Live TV',
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontSize: 12,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : (isDark ? Colors.white60 : Colors.black54),
                    ),
                    onPressed: () => _toggleFavorite(channel.id),
                  ),
                  const Icon(
                    Icons.play_circle_fill,
                    color: Colors.blue,
                    size: 32,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerScreen(channel: channel),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.appTitle ?? 'ERi-TV'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _selectedIndex == 0 ? _loadChannels : null,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    onLocaleChange: widget.onLocaleChange,
                    onThemeModeChange: widget.onThemeModeChange,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildChannelsList(),
          NewsScreen(currentLanguage: widget.currentLocale.languageCode),
          _channels != null
              ? FavoritesScreen(allChannels: _channels!)
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            _loadFavorites(); // Reload favorites when switching to favorites tab
          }
        },
        backgroundColor: Theme.of(context).brightness == Brightness.dark 
            ? const Color(0xFF1E1E1E)
            : Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark 
            ? Colors.white60
            : Colors.black54,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.live_tv),
            label: l10n?.liveTV ?? 'Live TV',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.article),
            label: l10n?.news ?? 'News',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: l10n?.favorites ?? 'Favorites',
          ),
        ],
      ),
    );
  }
}
