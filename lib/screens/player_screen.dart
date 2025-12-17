import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../models/channel.dart';
import '../services/pip_service.dart';
import '../services/chromecast_service.dart';
import '../l10n/app_localizations.dart';

class PlayerScreen extends StatefulWidget {
  final Channel channel;

  const PlayerScreen({super.key, required this.channel});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> with WidgetsBindingObserver {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  final PipService _pipService = PipService();
  final ChromecastService _chromecastService = ChromecastService();
  bool _isLoading = true;
  String? _error;
  bool _isPipAvailable = false;
  bool _isChromecastAvailable = false;
  bool _isCasting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _enableWakelock();
    _checkPipAvailability();
    _checkChromecastAvailability();
    _initializePlayer();
  }

  Future<void> _enableWakelock() async {
    await WakelockPlus.enable();
  }

  Future<void> _checkPipAvailability() async {
    final available = await _pipService.isPipAvailable();
    setState(() {
      _isPipAvailable = available;
    });
  }

  Future<void> _checkChromecastAvailability() async {
    final available = await _chromecastService.isChromecastAvailable();
    final casting = await _chromecastService.isCasting();
    setState(() {
      _isChromecastAvailable = available;
      _isCasting = casting;
    });
  }

  Future<void> _enterPipMode() async {
    final success = await _pipService.enterPipMode();
    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Picture-in-picture mode not available'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Handle app lifecycle changes for PiP
    if (state == AppLifecycleState.paused) {
      // App is in background, check if in PiP mode
      _checkIfInPipMode();
    }
  }

  Future<void> _checkIfInPipMode() async {
    final inPip = await _pipService.isInPipMode();
    if (!inPip && _videoPlayerController != null) {
      // If not in PiP mode and video is playing, pause it
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
      }
    }
  }

  Future<void> _showChromecastDialog() async {
    final l10n = AppLocalizations.of(context);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: Row(
            children: [
              const Icon(Icons.cast, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                l10n?.castToDevice ?? 'Cast to Device',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n?.chromecastInfo ?? 
                    'Chromecast functionality is available but requires Google Play Services to be fully configured.',
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n?.chromecastFuture ?? 
                    'This feature will be fully enabled in a future update.',
                style: const TextStyle(color: Colors.white60, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n?.ok ?? 'OK',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _initializePlayer() async {
    // Dispose existing controllers if any
    await _videoPlayerController?.dispose();
    _chewieController?.dispose();
    
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.channel.url),
      );

      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Theme.of(context).primaryColor,
          handleColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.white70,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorBuilder: (context, errorMessage) {
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
                  'Error loading stream',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _retryInitialization,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _retryInitialization() {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    _initializePlayer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.channel.name),
        backgroundColor: Colors.black.withOpacity(0.5),
        actions: [
          if (_isChromecastAvailable && !_isLoading && _error == null)
            IconButton(
              icon: Icon(
                _isCasting ? Icons.cast_connected : Icons.cast,
                color: _isCasting ? Colors.blue : Colors.white,
              ),
              onPressed: _showChromecastDialog,
              tooltip: 'Cast',
            ),
          if (_isPipAvailable && !_isLoading && _error == null)
            IconButton(
              icon: const Icon(Icons.picture_in_picture_alt),
              onPressed: _enterPipMode,
              tooltip: 'Picture-in-Picture',
            ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    l10n?.initializingPlayer ?? 'Initializing player...',
                    style: const TextStyle(color: Colors.white70),
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
                        l10n?.errorLoadingStream ?? 'Error loading stream',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _retryInitialization,
                        icon: const Icon(Icons.refresh),
                        label: Text(l10n?.retry ?? 'Retry'),
                      ),
                    ],
                  ),
                )
              : _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : Center(
                      child: Text(
                        l10n?.errorLoadingStream ?? 'Unable to load player',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
    );
  }
}
