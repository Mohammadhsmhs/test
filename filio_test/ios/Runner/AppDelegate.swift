import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    DatabaseHelper.shared.getDB()
    let channel = FlutterMethodChannel(name: "increment_counter", binaryMessenger: self.window!.rootViewController!.platformMessenger)
    channel.setMethodCallHandler { call, result in
      if call.method == "increment" {
        DatabaseHelper.shared.incrementCounter()
        result(true)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}