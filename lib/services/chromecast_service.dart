import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class ChromecastService {
  static const MethodChannel _channel = MethodChannel('eritv_app/chromecast');

  // Singleton pattern
  static final ChromecastService _instance = ChromecastService._internal();
  factory ChromecastService() => _instance;
  ChromecastService._internal();

  /// Check if Chromecast is available on this device
  Future<bool> isChromecastAvailable() async {
    if (!Platform.isAndroid) {
      return false; // Chromecast is only supported on Android in this implementation
    }

    try {
      final bool? available = await _channel.invokeMethod('isChromecastAvailable');
      return available ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Show Chromecast device picker
  Future<bool> showDevicePicker() async {
    if (!Platform.isAndroid) {
      return false;
    }

    try {
      final bool? result = await _channel.invokeMethod('showDevicePicker');
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Cast video URL to selected Chromecast device
  Future<bool> castVideo({
    required String url,
    required String title,
    String? subtitle,
    String? imageUrl,
  }) async {
    if (!Platform.isAndroid) {
      return false;
    }

    try {
      final bool? result = await _channel.invokeMethod('castVideo', {
        'url': url,
        'title': title,
        'subtitle': subtitle,
        'imageUrl': imageUrl,
      });
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Stop casting
  Future<bool> stopCasting() async {
    if (!Platform.isAndroid) {
      return false;
    }

    try {
      final bool? result = await _channel.invokeMethod('stopCasting');
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Check if currently casting
  Future<bool> isCasting() async {
    if (!Platform.isAndroid) {
      return false;
    }

    try {
      final bool? result = await _channel.invokeMethod('isCasting');
      return result ?? false;
    } catch (e) {
      return false;
    }
  }
}
