//
//  SecVerify.h
//  SecVerify
//
//  Created by lujh on 2019/5/16.
//  Copyright © 2019 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SecVerifyCustomModel.h"
#import "SVSDKDefine.h"
#import <SecVerify/SVSDKHelpExt.h>
#import <SecVerify/SVSDKLoginManager.h>
#import <Secverify/SVSDKWidgetLayout.h>

@interface SecVerify : NSObject

/**
判断当前网络环境是否可以发起认证

@return YES - 可以认证, NO - 不能认证
*/
+ (BOOL)isVerifyEnable;

/**
 设置预登陆超时时间

 @param timeout 超时时间(默认5s)
 */
+ (void)setTimeoutInterval:(NSTimeInterval)timeout;

/**
 预登录

 @param handler 返回字典和error , 字典中包含运营商类型. error为nil即为成功.
 */
+ (void)preLogin:(nullable SecVerifyResultHander)handler;

/**
 登录

 @param model 需要配置的model属性（控制器必传）
 @param completion 回调. error为nil即为成功. 成功则得到token、operatorToken、operatorType，之后向Mob服务器请求获取完整手机号
 */
+ (void)loginWithModel:(nonnull SecVerifyCustomModel *)model completion:(nullable SecVerifyResultHander)completion;


/**
 登录
 
 @param model 需要配置的model属性（控制器必传）
 @param showLoginVcHandler 授权页面显示 回调
 @param loginBtnClickedHandler 授权页面登录按钮点击显示 回调
 @param willHiddenLoadingHandler 即将隐藏loading视图回调(自定义loading时，回收视图)
 @param completion 回调. error为nil即为成功. 成功则得到token、operatorToken、operatorType，之后向Mob服务器请求获取完整手机号
 */
+ (void)loginWithModel:(nonnull SecVerifyCustomModel *)model
           showLoginVc:(nullable SecVerifyCommonHander)showLoginVcHandler
       loginBtnClicked:(nullable SecVerifyCommonHander)loginBtnClickedHandler
     willHiddenLoading:(nullable SecVerifyCommonHander)willHiddenLoadingHandler
            completion:(nullable SecVerifyResultHander)completion;


/**
 当前sdk版本号

 @return 版本号
 */
+ (nonnull NSString *)sdkVersion;

/**
 关闭登录页面
 适用于需要手动关闭登录界面的场景 (如：model manualDismiss= YES,自定义视图按钮事件,左右导航事件)
 自动关闭登录界面，有自定义事件需要手动关闭
 */
+ (void)finishLoginVc: (void (^ __nullable)(void))completion;

/**
开启debug模式

@param enable 是否开启debug模式
*/
+ (void)setDebug:(BOOL)enable;

@end
