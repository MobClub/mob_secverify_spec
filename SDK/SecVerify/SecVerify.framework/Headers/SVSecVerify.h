//
//  SVSecVerify.h
//  Secverify
//
//  Created by TanXiang on 2020/9/27.
//  Copyright © 2020 mobTech. All rights reserved.
//

#import <Foundation/Foundation.h>

//SDK版本号
#define KSVSDKVersion @"3.0.6"
//产品标识
#define KSVIdentifier @"SECVERIFY"


typedef void(^SecVerifyResultHander)(NSDictionary * _Nullable resultDic, NSError * _Nullable error);


@interface SVSecVerify : NSObject

#pragma mark - 一键登录
/**
 * 预登录
 *
 * 此调用将有助于提高拉起授权页的速度和成功率
 * 不建议频繁多次调用和拉起授权页后调用
 * 预登录方法回调为dispatch_get_global_queue(0, 0)，非主线程，UI操作请手动切换到主线程
 * 建议在一键登录前提前调用此方法，比如调一键登录的vc的viewdidload中
 * 以 if (error == nil) 为判断成功的依据，而非返回码
 * 预登录成功后，脱敏手机号相关信息在回调的resultDic中获取
 *
 * 成功返回示例:
 * resultDic:
 * {
     operator = CUCC;
     securityPhone = "131****0605";
     uiElement =     {
         privacyName = "联通统一认证服务条款";
         privacyUrl = "https://www.example.com/sdk/agreement";
         slogan = "中国联通提供认证服务";
     };
 }
 * 返回字段说明：
 * securityPhone：脱敏手机号（必须在授权页显示此脱敏手机号）
 * operator：预取号时的当前运营商类型，CTCC：电信、CMCC：移动、CUCC：联通
 * uiElement->privacyName：运营商协议名称（必须在授权页显示此运营商协议，且可查看协议详情）
 * uiElement->privacyUrl：运营商协议链接（用于查看运营商协议web页详情，配合protocolName使用）
 * uiElement->slogan：运营商取号能力标识（建议在授权页显示此标识，否则可能影响一键登录取号能力）

*/
+ (void)preLogin:(nullable SecVerifyResultHander)handler;



/**
 * 获取Token
 *
 * 同时返回预登陆信息和token
 * 该方法回调为dispatch_get_global_queue(0, 0)，非主线程，UI操作请手动切换到主线程
 * 以 if (error == nil) 为判断成功的依据，而非返回码
 * ⚠️❗️根据合规性要求，必须显示授权页显示必要信息，并经过用户同意并授权隐私与服务协议后方可使用token
 *
 * 成功返回示例:
 * resultDic:
 {
     opToken = 7b19d948f1e9f18bb20dc66b4c08d68c953005d6c04841319918273113288705;
     operator = CUCC;
     securityPhone = "131****0605";
     token = "0:AAAAhQAAAIEAD261gzCYXMWXTL8rrAlRf9120a4LLQJHUw6LbV6S74dLCHHczDt54iTE3UziKY6MdKO9LONwgAseaPB+5HrPQZOsJXBvgIDSH5wtF6IiEbVmvwlzyRajVJY3KvAXSDSybH1Mch8XuuBG3zHXxpYs0IltgXAoOsc9/oB4aakwmPUAAACgbzY1oX1Ir9+DyU4R5PdpeWdQw+0IHYcfdKvpVXnXOXZ5ak0nqPNuR1FqCh1RMrPmHXu4K6IwYGOYnXFRtABIE7I7h7EU+2imu4vY9pY3z2OYjHvMFkrHLHCoeh0srZvhMPJscPP6Ue3NPV38sd/4hPH1bp4cH4IjFPpPB5AwWFkIn2N7U8fBX02SbPAxy4ejqCvr9yoxJq2c0dONsn/22Q==";
     uiElement =     {
         privacyName = "联通统一认证服务条款";
         privacyUrl = "https://e.189.cn/sdk/agreement";
         slogan = "中国联通提供认证服务";
     };
 }
 * 返回字段说明：
 * securityPhone：脱敏手机号（必须在授权页显示此脱敏手机号）
 * operator：预取号时的当前运营商类型，CTCC：电信、CMCC：移动、CUCC：联通
 * uiElement->privacyName：运营商协议名称（必须在授权页显示此运营商协议，且可查看协议详情）
 * uiElement->privacyUrl：运营商协议链接（用于查看运营商协议web页详情，配合protocolName使用）
 * uiElement->slogan：运营商取号能力标识（建议在授权页显示此标识，否则可能影响一键登录取号能力）
 *
 * opToken、token用于置换手机号，一次有效，有效期1min
*/
+(void)loginAuth:(nullable SecVerifyResultHander)handler;




#pragma mark - 设置超时
/**
 设置预取号超时 单位:s
 大于0有效
 建议4s左右，默认4s
 */
+ (void)setPreGetPhonenumberTimeOut:(NSTimeInterval)preGetPhoneTimeOut;
/**
 设置获取token超时 单位:s
 大于0有效
 建议4s左右，默认4s
 */
+ (void)setLoginAuthTimeOut:(NSTimeInterval)loginAuthTimeOut;

#pragma mark - 开启DEBUG
/**
开启debug模式

@param enable 是否开启debug模式
*/
+ (void)setDebug:(BOOL)enable;

/**
 获取当前流量卡运营商（结果仅供参考）
 return @"CMCC" @"CUCC" @"CTCC" @"UNKNOW"
 */
+ (NSString *_Nullable)getCurrentOperatorType;

/**
 清空sdk内部预取号缓存
 */
+ (void)clearPhoneScripCache;

@end

