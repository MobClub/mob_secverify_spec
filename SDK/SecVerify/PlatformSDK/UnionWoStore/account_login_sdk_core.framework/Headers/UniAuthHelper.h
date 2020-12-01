//
//  UniAuthHelper.h
//  联通单网免密登录SDK
//
//  Created by zhuof on 2018/3/8.
//  Copyright © 2018年 xiaowo. All rights reserved.
//
//  4.4.0IR00B0715 使用GCDSocket方案，预取号流程修改，增加idfa读取，减少打点频率。
//  4.4.0IR00B0825 1.增加修改授权页面背景颜色的能力
//                 2.协议条款页 webview扩展到底部横条下面，如果未指定协议条款页面的标题，默认使用条款名称作为标题
//                 3.授权页协议条款格式调整
//                 4.添加运营商协议书名号添加能力
//                 5.授权页服务条款termRect从checkbox左侧开始算（老版本不包含checkbox）
// 4.5.0IR00B1020  1. 关闭读取idfa的能力
//                 2. 关闭打点请求

#import "UniAuthViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^UniResultListener)(NSDictionary *data);

@protocol UniAuthHelperDelegate;

@interface UniAuthHelper : NSObject

+ (UniAuthHelper *)getInstance;

/**
 初始化，禁止多次调用，禁止更换不同appid尝试初始化。
 */
- (void)initWithAppId:(NSString*) appId appSecret:(NSString*) appSecret;

/**
 获取号码认证用的code
 */
- (void)mobileAuth:(UniResultListener) listener;

/**
 免密登录预取号
 */
- (void)getAccessCode:(UniResultListener) listener;

/**
 免密登录预取号
 */
- (void)getAccessCodeWithParam:(NSString*)param listener:(UniResultListener) listener;

/**
 拉起授权登录页面
 */
- (void)doLogin:(UIViewController *)viewController
                             viewModel:(nullable UniAuthViewModel *)viewModel
                            listener:(UniResultListener) listener;

/**
 是否正确执行预取号并且accessCode在有效期内，建议在doLogin方法执行前调用。
 */
- (BOOL)isPreGettedTokenValidate;

/**
 设置代理对象，处理用户点击切换账号，点击返回关闭按钮事件。
 */
- (void)setDelegate:(nullable id<UniAuthHelperDelegate>)delegate;

/**
 设置网络请求超时时间（单位s）
 */
- (void)setRequestTimeout:(NSTimeInterval)timeout;

/**
 关闭当前的授权页面
 */
- (void)dismissAuthViewController:(BOOL)animated completion:(void (^ __nullable)(void))completion;

/**
 关闭当前的授权页面
 */
- (void)dismissAuthViewController:(void (^ __nullable)(void))completion;

/**
 废弃20200320（点击登录按钮后，直接返回了code，无任何网络请求，无需loading）
 停止点击授权页面登录按钮之后的加载进度条
 */
- (void)stopLoading;

@end

@protocol UniAuthHelperDelegate <NSObject>

@optional

/**
 用户点击了授权页面的返回按钮
 */
- (void)userDidDismissAuthViewController;

/**
 用户点击了授权页面的"切换账户"按钮
 */
- (void)userDidSwitchAccount;

@end

NS_ASSUME_NONNULL_END
