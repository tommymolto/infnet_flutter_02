#import "InfnetPlugin.h"
#if __has_include(<infnet_plugin/infnet_plugin-Swift.h>)
#import <infnet_plugin/infnet_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "infnet_plugin-Swift.h"
#endif

@implementation InfnetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInfnetPlugin registerWithRegistrar:registrar];
}
@end
