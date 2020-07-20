//
//  EAccountOpenPageSDK.h
//  EAccountOpenPageSDK
//
//  Created by 陈永怀 on 2019/4/15.
//  Copyright © 2019年 21CN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EAccountOpenPageConfig.h"

/**
 SDK v3.7.0 20191112
 */
/**
 声明一个block
 @param resultDic 网络返回的data的解析结果
 */
typedef   void (^successHandler) ( NSDictionary * _Nonnull resultDic);

/**
 声明一个block
 @param error 网络返回的错误或者其它错误
 */
typedef   void (^failureHandler) (NSError * _Nonnull error);

/**
 声明一个block
 @param senderTag 被点击控件的tag
 */
typedef   void (^clickEventHandler) (NSString * _Nonnull senderTag);

@interface EAccountOpenPageSDK : NSObject


/**
 初始化SDK钱调用。默认为正式环境的bundleId,需要使用测试环境的bundleId（一般是为了方便企业证书重签名之后测试），请添加这个方法，在发布APP的时候请确保没有使用该方法。
 */

+(void)setTestBundleId;


/**
 初始化SDK
 @param appId 接入方在账号平台领取的appId
 @param appSecrect 接入方在账号平台领取的appSecrect
 */
+ (void)initWithAppId:(NSString * _Nonnull)appId
              appSecret:(NSString * _Nonnull)appSecrect;

/**
 预登录

 @param timeoutInterval 接口超时时间
 */
+ (void)requestPreLogin:(NSTimeInterval)timeoutInterval
           completion:(nonnull successHandler)completion
              failure:(nonnull failureHandler)fail;



/**
 控制台日志输出控制（默认关闭）
 @param enable 开关参数
 */
+ (void)printConsoleEnable:(BOOL)enable;

/**
 打开登录页面，用户点击登录按钮的时候会返回相应的结果
 @param  config 登录界面相关动态配置
 @param  clickHandler 合作方新增按钮的点击回调
 @param  completion 成功回调
 @param  fail  失败回调
 */
+ (void)openAtuhVC:(EAccountOpenPageConfig * _Nonnull)config
      clickHandler:(nonnull clickEventHandler)clickHandler
        completion:(nonnull successHandler)completion
           failure:(nonnull failureHandler)fail;

/**
 打开登录页面，用户点击登录按钮的时候会返回相应的结果
 @param  clickHandler 合作方新增按钮的点击回调
 @param  completion 成功回调
 @param  fail  失败回调
 */
+ (void)openAtuhVC:(nonnull clickEventHandler)clickHandler
        completion:(nonnull successHandler)completion
           failure:(nonnull failureHandler)fail;

/**
 主动关闭授权页面
 */
+ (void)closeOpenAuthVC;

@end
