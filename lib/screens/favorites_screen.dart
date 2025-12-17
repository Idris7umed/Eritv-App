import 'package:flutter/material.dart';
import '../models/channel.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';
import 'player_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Channel> allChannels;

  const FavoritesScreen({super.key, required this.allChannels});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService();
  List<Channel> _favoriteChannels = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _isLoading = true;
    });

    final favoriteIds = await _favoritesService.getFavoriteChannelIds();
    final favorites = widget.allChannels
        .where((channel) => favoriteIds.contains(channel.id))
        .toList();

    setState(() {
      _favoriteChannels = favorites;
      _isLoading = false;
    });
  }

  Future<void> _removeFavorite(String channelId) async {
    await _favoritesService.removeFavoriteChannel(channelId);
    await _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_favoriteChannels.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.white24,
            ),
            const SizedBox(height: 24),
            Text(
              l10n?.noFavorites ?? 'No favorite channels yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                l10n?.addFavoritesDescription ?? 
                    'Add channels to your favorites by tapping the heart icon.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                      height: 1.5,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _favoriteChannels.length,
      itemBuilder: (context, index) {
        final channel = _favoriteChannels[index];
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
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              channel.id.isNotEmpty ? channel.id : 'Live TV',
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () => _removeFavorite(channel.id),
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
    );
  }
}
