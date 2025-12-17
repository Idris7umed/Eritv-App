package com.example.eritv_app

import android.app.PictureInPictureParams
import android.content.pm.PackageManager
import android.os.Build
import android.util.Rational
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val PIP_CHANNEL = "eritv_app/pip"
    private val CAST_CHANNEL = "eritv_app/chromecast"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // PiP Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PIP_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isPipAvailable" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        result.success(packageManager.hasSystemFeature(PackageManager.FEATURE_PICTURE_IN_PICTURE))
                    } else {
                        result.success(false)
                    }
                }
                "enterPipMode" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        try {
                            val params = PictureInPictureParams.Builder()
                                .setAspectRatio(Rational(16, 9))
                                .build()
                            val success = enterPictureInPictureMode(params)
                            result.success(success)
                        } catch (e: Exception) {
                            result.success(false)
                        }
                    } else {
                        result.success(false)
                    }
                }
                "isInPipMode" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        result.success(isInPictureInPictureMode)
                    } else {
                        result.success(false)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        
        // Chromecast Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CAST_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isChromecastAvailable" -> {
                    // Chromecast requires Google Play Services and Cast SDK
                    // Return false until fully implemented
                    result.success(false)
                }
                "showDevicePicker" -> {
                    // This would require implementing the Google Cast SDK
                    // For now, return false as it's not fully implemented
                    result.success(false)
                }
                "castVideo" -> {
                    // This would require implementing the Google Cast SDK
                    // For now, return false as it's not fully implemented
                    result.success(false)
                }
                "stopCasting" -> {
                    result.success(false)
                }
                "isCasting" -> {
                    result.success(false)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
