//
//  AppDelegate.m
//  TestUMCOpen
//
//  Created by LL on 16/7/14.
//  Copyright © 2016年 LL. All rights reserved.
//

#import "AppDelegate.h"
#import <TYRZSDK/TYRZSDK.h>
#import "IQKeyboardManager.h"

//#define APPID  @"中国移动开发者社区申请的appid"
//#define APPKEY @"中国移动开发者社区申请的appkey"

#define APPID @"300011958808"
#define APPKEY @"90303CDBBE262B349A231E7F7FD24860"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //设置键盘监听管理
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
//
    //存好APPID和APPKEY
    [[NSUserDefaults standardUserDefaults] setValue:APPID forKey:@"TYRZSDKAPPID"];
    [[NSUserDefaults standardUserDefaults] setValue:APPKEY forKey:@"TYRZSDKAPPKEY"];


    //注册SDK
    [UASDKLogin.shareLogin registerAppId:APPID AppKey:APPKEY];
    [UASDKLogin.shareLogin setValue:@"com.cmcc.enterprise-classID.onecardmultinumber.sdk" forKeyPath:@"sdkData.boundid"];

    
    //是否打印日志
    [UASDKLogin.shareLogin printConsoleEnable:YES];
    
//    __weak typeof(self) weakSelf = self;
//
//    /**注意:
//    （预取号,一键登录,本机号码校验）进行时未完成的情况下,再次调用SDK的任何方法都不会生效以及有回调
//     请自行控制好Loading的关闭时机(建议6~8秒)
//     */
//    [UASDKLogin.shareLogin setTimeoutInterval:8000];
//    [UASDKLogin.shareLogin getPhoneNumberCompletion:^(NSDictionary * _Nonnull sender) {
//        NSString *resultCode = sender[@"resultCode"];
//        NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:sender];
//        if ([resultCode isEqualToString:@"103000"]) {
//            NSLog(@"预取号成功");
//        } else {
//            NSLog(@"预取号失败");
//        }
//    }];
    
    return YES;
}

/**
 转换显示资料
 */
- (NSString *)changeShowInfo:(id)sender {
    NSString *message = @"";
    for (id key in [sender allKeys]) {
        
        id value = sender[key];
        BOOL isDict = [value isKindOfClass:NSDictionary.class];
        
        message = isDict ? [message stringByAppendingFormat:@"\n%@ = %@",key, [self changeShowInfo:value]] : [message stringByAppendingFormat:@"\n%@ = \"%@\"",key,sender[key]];
    }
    
    return message;
}

- (void)showInfo:(NSDictionary *)sender {
    NSString *message = [self changeShowInfo:sender];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:[NSString stringWithFormat:@"%@",message]
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSString *)timestamp {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *result = [formatter stringFromDate:now];
    
    return result;
}

@end
