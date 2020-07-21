//
//  SVSDKHelpExt.h
//  SecVerify
//
//  Created by hower on 2019/7/23.
//  Copyright © 2019 mob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SecVerifyCustomModel;
@interface SVSDKHelpExt : NSObject

//登录页面协议富文本
+ (NSMutableAttributedString *)loginProtocolAttrStr:(SecVerifyCustomModel *)customModel;

//登录页面协议size
+ (CGSize)loginProtocolSize:(SecVerifyCustomModel *)customModel maxWidth:(float)maxWidth;

@end

