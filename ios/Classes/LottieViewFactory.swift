
import UIKit
import Flutter
//import Lottie

public class LottieViewFactory : NSObject, FlutterPlatformViewFactory {
    
//    var animationView: AnimationView?
    var registrarInstance : FlutterPluginRegistrar
      
    init(registrarInstance : FlutterPluginRegistrar) {
        self.registrarInstance = registrarInstance
        super.init()
    }
      
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
      
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlutterLottieView(frame, viewId: viewId, args: args as! [String : Any], registrarInstance: registrarInstance)
    }
}


