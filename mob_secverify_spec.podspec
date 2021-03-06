Pod::Spec.new do |s|
	s.name                = "mob_secverify_spec"
	s.version             = "3.1.1"
	s.summary             = '秒验，一键登录'
	s.license             = 'Copyright © 2019-2029 mob.com'
	s.author              = { "mob" => "mobproducts@163.com" }
	s.homepage            = 'http://www.mob.com'
	s.source              = { :http => 'https://dev.ios.mob.com/files/download/secverify/secVerify_spec_For_iOS_v3.1.0.zip' }
	s.platform            = :ios, '8.0'
	s.libraries           = "c++"
	s.vendored_frameworks = 'SecVerify/SecVerify.framework', 'SecVerify/PlatformSDK/Mobile/TYRZUISDK.framework', 'SecVerify/PlatformSDK/Telecom/EAccountHYSDK.framework', 'SecVerify/PlatformSDK/Union/OAuth.framework'
	s.resources 		  = 'SecVerify/SecVerify.bundle', 'SecVerify/PlatformSDK/Telecom/EAccountOpenPageResource.bundle'
	s.xcconfig  		  =  {'OTHER_LDFLAGS' => '-ObjC' }
	s.dependency 'mobfoundation_spec'
end
