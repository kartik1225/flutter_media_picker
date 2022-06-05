#import "MediaPickerPlugin.h"
#if __has_include(<media_picker/media_picker-Swift.h>)
#import <media_picker/media_picker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "media_picker-Swift.h"
#endif

@implementation MediaPickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMediaPickerPlugin registerWithRegistrar:registrar];
}
@end
