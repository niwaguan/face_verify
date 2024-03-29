import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/face_verify.g.dart',
  dartOptions: DartOptions(),
  dartPackageName: 'cn.stormyang.flutter.face_verify',
  javaOut:
      'android/src/main/java/cn/stormyang/flutter/face_verify/face_verify/FaceVerifyGen.java',
  javaOptions:
      JavaOptions(package: "cn.stormyang.flutter.face_verify.face_verify"),
  objcHeaderOut: 'ios/Classes/FaceVerify.g.h',
  objcSourceOut: 'ios/Classes/FaceVerify.g.m',
  objcOptions: ObjcOptions(prefix: 'SY'),
))
@HostApi()
abstract class FlutterFaceVerifyHostApi {
  /// 初始化SDK
  @async
  void initService();

  /// 开始验证
  @async
  Map<String?, Object?> verify({required String certifyId});
}
