//
//  SVSDKWidgetLayout.h
//  SecVerify
//
//  Created by yoozoo on 2019/9/29.
//  Copyright © 2019 mob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVSDKWidgetLayout : NSObject

//顶部距离
@property (assign, nonatomic) CGFloat widgetTop;

//左部距离
@property (assign, nonatomic) CGFloat widgetLeft;

//右部距离
@property (assign, nonatomic) CGFloat widgetRigth;

//顶部距离
@property (assign, nonatomic) CGFloat widgetBottom;

//控件宽度
@property (assign, nonatomic) CGFloat widgetWidth;

//控件高度
@property (assign, nonatomic) CGFloat widgetHeight;

@end

NS_ASSUME_NONNULL_END
