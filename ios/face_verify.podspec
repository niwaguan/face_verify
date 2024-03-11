#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint face_verify.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'face_verify'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter Plugin.'
  s.description      = <<-DESC
A Flutter Plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AntVerify', '1.0.0.230802111230'
  s.platform = :ios, '12.0'

  s.xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC -ld_classic',
    'ENABLE_BITCODE' => 'NO'
  }

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
