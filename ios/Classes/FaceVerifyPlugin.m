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

- (void)initServiceWithCompletion:(nonnull void (^)(FlutterError * _Nullable))completion {
  [MPVerifySDKService initSDKService];
  completion(NULL);
}

- (void)verifyCertifyId:(nonnull NSString *)certifyId completion:(nonnull void (^)(NSDictionary<NSString *,id> * _Nullable, FlutterError * _Nullable))completion { 
  
  UIViewController *vc = [self getViewController];
  if (vc == NULL) {
    completion(NULL, [FlutterError errorWithCode:@"-1" message:@"无法获取ViewController" details:NULL]);
    return;
  }
  
  [[MPVerifySDKService sharedInstance] verifyWith:certifyId currentCtr:vc extParams:@{} onCompletion:^(ZIMResponse *response) {
    NSMutableDictionary *result = [@{
      @"code": @(response.code),
      @"retCode": @(response.retCode),
    } mutableCopy];
    NSString *value = response.reason;
    if (value != NULL) {
      result[@"reason"] = value;
    }
    value = response.retCodeSub;
    if (value != NULL) {
      result[@"retCodeSub"] = value;
    }
    value = response.retMessageSub;
    if (value != NULL) {
      result[@"retMessageSub"] = value;
    }
    
    completion(result, NULL);
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
