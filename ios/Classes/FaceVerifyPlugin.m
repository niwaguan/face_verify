#import "FaceVerifyPlugin.h"
#import "FaceVerify.g.h"
#import <AlipayVerifySDK/MPVerifySDKService.h>

@interface FaceVerifyPluginApi : NSObject<SYFlutterFaceVerifyHostApi>
@end


@implementation FaceVerifyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  SetUpSYFlutterFaceVerifyHostApi([registrar messenger], [[FaceVerifyPluginApi alloc] init]);
}

@end

@implementation FaceVerifyPluginApi



- (void)initServiceWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
  [MPVerifySDKService initSDKService];
}

- (void)verifyCertifyId:(nonnull NSString *)certifyId completion:(nonnull void (^)(NSDictionary * _Nullable, FlutterError * _Nullable))completion {
  UIViewController *vc = [self getViewController];
  if (vc == NULL) {
    completion(NULL, [FlutterError errorWithCode:@"-1" message:@"无法获取ViewController" details:NULL]);
    return;
  }
  
  [[MPVerifySDKService sharedInstance] verifyWith:certifyId currentCtr:vc extParams:@{} onCompletion:^(ZIMResponse *response) {
      NSString *result = [NSString stringWithFormat:@"结果：code: %@, reason: %@, retCodeSub = %lu, retMessageSub = %@", @(response.code), response.reason, (unsigned long)response.retCode, response.retMessageSub];
  }];
}

- (UIViewController *)getViewController {
  if (@available(iOS 15.0, *)) {
    NSSet<UIScene *> *scenes = [[UIApplication sharedApplication] connectedScenes];
    UIWindow * window = NULL;
    for (UIScene *obj in scenes) {
      if ([obj isKindOfClass:UIWindowScene.class]) {
        UIWindowScene *s = (UIWindowScene *)obj;
        if (s.activationState == UISceneActivationStateForegroundActive) {
          window = s.keyWindow;
          break;
        }
      }
    }
    return window.rootViewController;
  } else if (@available(iOS 13.0, *)) {
    NSSet<UIScene *> *scenes = [[UIApplication sharedApplication] connectedScenes];
    NSArray<UIWindow * > *windows = NULL;
    for (UIScene *obj in scenes) {
      if ([obj isKindOfClass:UIWindowScene.class]) {
        UIWindowScene *s = (UIWindowScene *)obj;
        if (s.activationState == UISceneActivationStateForegroundActive) {
          windows = s.windows;
          break;
        }
      }
    }
    for (UIWindow *window in windows) {
      if (window.isKeyWindow) {
        return window.rootViewController;
      }
    }
    return NULL;
  }
  
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end
