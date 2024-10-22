package dev.dash_shield.dash_shield

import android.app.Activity
import android.view.WindowManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** DashShieldPlugin */
class DashShieldPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  private lateinit var channel : MethodChannel
  private lateinit var activity: Activity  // To access the current activity's window

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "dash_shield")
    channel.setMethodCallHandler(this)
  }

  // Attach the activity to the plugin (to modify the window)
  override fun onAttachedToActivity(binding: FlutterPlugin.FlutterPluginBinding) {
    activity = binding.activity
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "preventScreenshots") {
      // Prevent screenshots and screen recording for specific screen
      activity.window.setFlags(
        WindowManager.LayoutParams.FLAG_SECURE,
        WindowManager.LayoutParams.FLAG_SECURE
      )
      result.success(null)
    } else if (call.method == "preventScreenshotsGlobally") {
      // Prevent screenshots and screen recording globally for the whole app
      activity.window.setFlags(
        WindowManager.LayoutParams.FLAG_SECURE,
        WindowManager.LayoutParams.FLAG_SECURE
      )
      result.success(null)
    } else {
      result.notImplemented()
    }
  }




}
