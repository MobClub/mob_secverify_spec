Pod::Spec.new do |s|
	s.name                = "mob_secverify_spec"
	s.version             = "3.0.2"
	s.summary             = '秒验，一键登录'
	s.license             = 'Copyright © 2019-2029 mob.com'
	s.author              = { "mob" => "mobproducts@163.com" }
	s.homepage            = 'http://www.mob.com'
	s.source              = { :http => 'http://dev.ios.mob.com/files/download/secverify/SecVerify_For_iOS_v3.0.2.zip' }
	s.platform            = :ios, '8.0'
	s.libraries           = "c++"
	s.vendored_frameworks = 'SecVerify/SecVerify.framework', 'SecVerify/PlatformSDK/Mobile/TYRZSDK.framework', 'SecVerify/PlatformSDK/Telecom/EAccountHYSDK.framework', 'SecVerify/PlatformSDK/Union/OAuth.framework', 'SecVerify/PlatformSDK/UnionWoStore/account_login_sdk_core.framework'
	s.resources 		  = 'SecVerify/SecVerify.bundle', 'SecVerify/PlatformSDK/Mobile/TYRZResource.bundle', 'SecVerify/PlatformSDK/Telecom/EAccountOpenPageResource.bundle'
	s.xcconfig  		  =  {'OTHER_LDFLAGS' => '-ObjC' }
	s.dependency 'mobfoundation_spec'
end
