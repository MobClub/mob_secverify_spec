//
//  SVSDKDefine.h
//  SecVerify
//
//  Created by lujh on 2019/5/17.
//  Copyright © 2019 lujh. All rights reserved.
//

#ifndef SVSDKDefine_h
#define SVSDKDefine_h

/**
 SecVerify 结果的回调

 @param resultDic 结果的字典
 @param error 错误信息
 */
typedef void(^SecVerifyResultHander)(NSDictionary * _Nullable resultDic, NSError * _Nullable error);

typedef void(^SecVerifyCommonHander)(void);

/**
 *  @brief 短信验证码结果回调
 *  @param error 当error为空时表示成功
 */
typedef void (^SecVerifySMSCodeHandler) (NSString * _Nullable smsToken, NSError * _Nullable error);

/**
 *   @brief 本机认证结果回调
 *   @param result 认证结果
 *   @param error 当error为空时表示成功
 */
typedef void (^SecVerifyMAResultHandler) (BOOL result, NSError * _Nullable error);

#endif /* SVSDKDefine_h */
