import Flutter
import UIKit

public class DashShieldPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "dash_shield", binaryMessenger: registrar.messenger())
    let instance = DashShieldPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "preventScreenshots":
      // Prevent screenshots and recording for specific screen
      if let window = UIApplication.shared.keyWindow {
        window.isSecure = true
        result(nil)
      } else {
        result(FlutterError(code: "UNAVAILABLE", message: "Window not available", details: nil))
      }
    case "preventScreenshotsGlobally":
      // Prevent screenshots and recording globally for the whole app
      if let window = UIApplication.shared.keyWindow {
        window.isSecure = true
        result(nil)
      } else {
        result(FlutterError(code: "UNAVAILABLE", message: "Window not available", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
