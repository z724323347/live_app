import Flutter
import UIKit

public class SwiftFlutterLottieviewPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let viewFactory = LottieViewFactory(registrarInstance: registrar)
    registrar.register(viewFactory, withId: "native.view_plugin/flutter_lottie")
  }
}
