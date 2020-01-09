#import "FlutterLottieviewPlugin.h"
#import <flutter_lottieview/flutter_lottieview-Swift.h>

@implementation FlutterLottieviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterLottieviewPlugin registerWithRegistrar:registrar];
}
@end
