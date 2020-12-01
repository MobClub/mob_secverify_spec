//
//  AppDelegate.m
//  SecVerifyDemo
//
//  Created by yoozoo on 2019/9/2.
//  Copyright © 2019 yoozoo. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>

#import "SVDVerifyViewController.h"
#import <MOBFoundation/MOBFoundation.h>
#import <MOBFoundation/MobSDK+Privacy.h>
#import "SVDVerifyNaviationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"****>>>11: %f", [NSDate date].timeIntervalSince1970);
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[SVDVerifyNaviationViewController alloc] initWithRootViewController:[SVDVerifyViewController new]];
    
    [Bugly startWithAppId:@"e21ce79e66"];
    
    // 采用plist自动注册
//    [MobSDK registerAppKey:@"moba6b6c6d6" appSecret:@"b89d2427a3bc7ad1aea1e1e8c1d36bf3"];
    
    [self.window makeKeyAndVisible];
    
    // 默认同意隐私协议
    [MobSDK uploadPrivacyPermissionStatus:YES onResult:nil];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
