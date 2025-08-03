import UIKit
import Flutter
import Firebase
import Clarity

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    FirebaseApp.configure()
    
    let clarityConfig = ClarityConfig(projectId: "sorjsvxn1f")
    ClaritySDK.initialize(config: clarityConfig)  // <- Düzeltildi
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func application(
    _ application: UIApplication,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void
  ) {
    // Handle quick action - the quick_actions plugin will handle this automatically
    completionHandler(true)
  }
}
