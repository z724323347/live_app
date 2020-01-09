import UIKit
import Flutter
import Lottie

public class FlutterLottieView : NSObject, FlutterPlatformView {

    let frame : CGRect
    let viewId : Int64
    var animView = AnimationView()
//    var delegates : [ValueContainer]
//    var eventStream = FlutterStreamHandler?
    
    var registrarInstance : FlutterPluginRegistrar
    
    
    init(_ frame: CGRect, viewId: Int64, args: [String:Any], registrarInstance : FlutterPluginRegistrar) {
       self.frame = frame
       self.viewId = viewId
       self.registrarInstance = registrarInstance
//       self.delegates = []
       
       super.init()
       
       self.create(args: args)
    }
    
    func create(args: [String:Any]) {
        let channel : FlutterMethodChannel = FlutterMethodChannel.init(name: "native.view_plugin/flutter_lottie_\(args["id"])", binaryMessenger: self.registrarInstance.messenger())
        let handler : FlutterMethodCallHandler = methodCall;
        channel.setMethodCallHandler(methodCall)
        
//        let playEventChannel = FlutterEventChannel(name: "native.view_plugin/flutter_lottie_event_" + args["id"],
//            binaryMessenger: self.registrarInstance.messenger())
////        self.eventStream = FlutterStreamHandler()
//        playEventChannel.setStreamHandler(eventStream as? FlutterStreamHandler & NSObjectProtocol)
        
        
        if let argsDict = args as? Dictionary<String, Any> {
            
            /// play url
            let url = argsDict["url"] as? String ?? nil;
            if url != nil {
                self.animView = AnimationView(name: url!)
            }
            /// play filePath
            let filePath = argsDict["filePath"] as? String ?? nil;
            if filePath != nil {
                let key = self.registrarInstance.lookupKey(forAsset: filePath!)
                let path = Bundle.main.path(forResource: key, ofType: nil)
                self.animView = AnimationView(filePath: path!)
            }
            
            /// loop / reverse / autoPlay
            let loop = argsDict["loop"] as? Bool ?? false
            let reverse = argsDict["reverse"] as? Bool ?? false
            let autoPlay = argsDict["autoPlay"] as? Bool ?? false
            
            
            if loop {
                animView.loopMode = .loop
            }else{
                animView.loopMode = .autoReverse
            }
            
            
            if autoPlay {
                self.animView.play()
            }
       
        }
        
    }
    
    
    public func view() -> UIView {
        return animView
    }
    
    func methodCall(call: FlutterMethodCall, result : FlutterResult) {
        
        var params : Dictionary<String, Any> = [String: Any]()
        
        if let args = call.arguments as? Dictionary<String,Any> {
            params = args
        }
        
        /// play
        if (call.method == "play") {
            self.animView.play()
        }
        
        /// resume
        if (call.method == "resume") {
            self.animView.stop()
        }
        
        /// stop
        if (call.method == "stop") {
            self.animView.stop()
        }
        
        /// pause
        if (call.method == "pause") {
            self.animView.pause()
        }
        
        /// reverse
        if (call.method == "reverse") {
            self.animView.play(fromProgress: 1,toProgress: 0, loopMode: .playOnce,completion:nil)
        }
        
        /// isPlaying
        if (call.method == "isPlaying") {
            result(self.animView.isAnimationPlaying)
        }
        
        /// setSpeed
        if (call.method == "setSpeed") {
            let speed = params["speed"] as! CGFloat
            self.animView.animationSpeed = speed
        }
        
        /// setLoop
        if (call.method == "setLoop") {
            let loop = params["loop"] as! Bool
//            self.animView?.loopMode = loop
            if loop {
                animView.loopMode = .loop
            }else{
                animView.loopMode = .autoReverse
            }
            
        }
        
        /// setProgress
        if (call.method == "setProgress") {
            let progress = params["progress"] as! CGFloat
            self.animView.currentProgress = progress
            
        }
        
        /// setPlayWithProgress
        if (call.method == "setPlayWithProgress") {
            let toProgress = params["toProgress"] as! CGFloat
            if let fromProgress = params["fromProgress"] as? CGFloat {
                self.animView.play(fromProgress: fromProgress ,toProgress: toProgress,completion: nil)
            } else {
                self.animView.play(toProgress: toProgress,completion: nil)
            }
        }
        
        /// setPlayWithFrames
        if (call.method == "setPlayWithFrames") {
            let toFrame = params["toFrame"] as! AnimationFrameTime;
            if let formFrame = params["formFrane"] as? AnimationFrameTime {
                self.animView.play(fromFrame: formFrame, toFrame: toFrame ,completion: nil)
            } else {
                self.animView.play(toFrame: toFrame, completion: nil)
            }
        }
        
        /// setProgressWithFrame
        if (call.method == "setProgressWithFrame") {
            let frame = params["frame"] as! CGFloat
            self.animView.currentFrame = frame
            
        }
        
    }
      
    
}
