// Autogenerated from Pigeon (v17.1.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "FaceVerify.g.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}

static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

NSObject<FlutterMessageCodec> *SYFlutterFaceVerifyHostApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  sSharedObject = [FlutterStandardMessageCodec sharedInstance];
  return sSharedObject;
}

void SetUpSYFlutterFaceVerifyHostApi(id<FlutterBinaryMessenger> binaryMessenger, NSObject<SYFlutterFaceVerifyHostApi> *api) {
  /// 初始化SDK
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.cn.stormyang.flutter.face_verify.FlutterFaceVerifyHostApi.initService"
        binaryMessenger:binaryMessenger
        codec:SYFlutterFaceVerifyHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(initServiceWithError:)], @"SYFlutterFaceVerifyHostApi api (%@) doesn't respond to @selector(initServiceWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api initServiceWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// 开始验证
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.cn.stormyang.flutter.face_verify.FlutterFaceVerifyHostApi.verify"
        binaryMessenger:binaryMessenger
        codec:SYFlutterFaceVerifyHostApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(verifyCertifyId:completion:)], @"SYFlutterFaceVerifyHostApi api (%@) doesn't respond to @selector(verifyCertifyId:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_certifyId = GetNullableObjectAtIndex(args, 0);
        [api verifyCertifyId:arg_certifyId completion:^(NSDictionary *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
