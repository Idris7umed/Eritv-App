import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class PipService {
  static const MethodChannel _channel = MethodChannel('eritv_app/pip');

  // Singleton pattern
  static final PipService _instance = PipService._internal();
  factory PipService() => _instance;
  PipService._internal();

  /// Check if PiP is available on this device
  Future<bool> isPipAvailable() async {
    if (!Platform.isAndroid) {
      return false; // PiP is only supported on Android in this implementation
    }

    try {
      final bool? available = await _channel.invokeMethod('isPipAvailable');
      return available ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Enter picture-in-picture mode
  /// Returns true if successfully entered PiP mode
  Future<bool> enterPipMode() async {
    if (!Platform.isAndroid) {
      return false;
    }

    try {
      final bool? result = await _channel.invokeMethod('enterPipMode');
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Check if currently in PiP mode
  Future<bool> isInPipMode() async {
    if (!Platform.isAndroid) {
      return false;
    }

    try {
      final bool? result = await _channel.invokeMethod('isInPipMode');
      return result ?? false;
    } catch (e) {
      return false;
    }
  }
}
