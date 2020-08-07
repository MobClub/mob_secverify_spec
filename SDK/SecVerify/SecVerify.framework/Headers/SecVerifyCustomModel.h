//
//  SecVerifyCustomModel.h
//  SecVerify
//
//  Created by lujh on 2019/5/28.
//  Copyright © 2019 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SecVerifyCheckPrivacyLayout : NSObject

//与隐私协议顶部 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutTop;
//与隐私协议中心 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutCenterY;
//与隐私协议右边距 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutRight;
//宽 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutWidth;
//高 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutHeight;

@end

@interface SecVerifyLayout : NSObject

//view 顶部距离 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutTop;
//view 底部距离 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutBottom;
//view 左边距离 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutLeft;
//view 右边距离 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutRight;
//宽度 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutWidth;
//高度 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutHeight;
//view x 中心距离 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutCenterX;
//view y 中心距离 (例:@(10))
@property (nonatomic,strong)NSNumber * layoutCenterY;
@end

@interface SecVerifyCustomLayouts : NSObject

//logo
@property (nonatomic,strong)SecVerifyLayout * logoLayout;

//手机号
@property (nonatomic,strong)SecVerifyLayout * phoneLayout;

//其他方式登录
@property (nonatomic,strong)SecVerifyLayout * switchLayout;

//登录按钮
@property (nonatomic,strong)SecVerifyLayout * loginLayout;

//check(相对隐私协议)复选框
@property (nonatomic,strong)SecVerifyCheckPrivacyLayout * checkPrivacyLayout;

//隐私条款(切记,不可设置隐藏)
@property (nonatomic,strong)SecVerifyLayout * privacyLayout;

//运营商品牌(切记,不可设置隐藏)
@property (nonatomic,strong)SecVerifyLayout * sloganLayout;

//背景视图
@property (nonatomic,strong)SecVerifyLayout * bgViewLayout;

//左边按钮
@property (nonatomic,strong)SecVerifyLayout * leftControlLayout;

@property (nonatomic,strong)SecVerifyLayout * rightControlLayout;

@end

//动画样式
typedef NS_ENUM(NSInteger, SVDAnimateStyle) {
    //默认
    SVDAnimateStyleCoverVertical = 0,
    //翻转
    SVDAnimateStyleFlipHorizontal,
    //淡入淡出
    SVDAnimateStyleCrossDissolve,
    //中间弹窗
    SVDAnimateStyleAlert,
    //push
    SVDAnimateStylePush,
    //底部弹出
    SVDAnimateStyleSheet,
    
    //无动画
    SVDAnimateStyleNone,
};

//显示样式
typedef NS_ENUM(NSInteger, SVDShowStyle) {
    //默认
    SVDShowStyleDefault = 0,
    //弹窗
    SVDShowStyleAlert,
    //push
    SVDShowStylePush,
    //底部弹窗
    SVDShowStyleSheet,
};

@interface SecVerifyCustomModel : NSObject

#pragma mark - 当前控制器
// VC，必传
@property (nonatomic, weak) UIViewController *currentViewController;

//外部手动管理关闭界面 @(BOOL)
/*
 注意：设置为YES 时，点击(登录操作，切换其他用户操作) 回调成功或者失败时，
      一定要调用 `finishLoginVc:` 方法手动关闭登录页面
 */
@property (nonatomic,strong)NSNumber * manualDismiss;

//动画类型 0:默认 1:淡入淡出 2:翻转 3: Alert 4: Push 5:sheet
@property (nonatomic, strong) NSNumber *animateType;

//展示样式 = 动画类型 + 默认布局
@property (nonatomic, strong) NSNumber *showType;

#pragma mark - 默认自定义动画页面(只针对于Alert/Sheet视图)

//弹窗控制器的背景色
@property (nonatomic, strong) UIColor *animateBgColor;
//左边按钮样式
@property (nonatomic, strong) UIImage *leftControlImage;
//左边按钮是否显示
@property (nonatomic, strong) NSNumber *leftControlHidden;
//左边按钮样式
@property (nonatomic, strong) UIImage *rightControlImage;
//右边按钮是否显示
@property (nonatomic, strong) NSNumber *rightControlHidden;
//背景视图是否展示
@property (nonatomic, strong) NSNumber *bgViewHidden;
//背景视图的圆角
@property (nonatomic, strong) NSNumber *bgViewCorner;

//背景视图颜色
@property (nonatomic, strong) UIColor *bgViewColor;

//背景视图展示图片
@property (nonatomic, strong) UIImage *bgViewImage;

//关闭按钮显示在左边还是右边 YES:左边 NO:右边
@property (nonatomic, strong) NSNumber *closeType;

//左侧按钮自定义事件
@property (nonatomic, assign) SEL leftTouchAction;

//右侧按钮自定义事件
@property (nonatomic, assign) SEL rightTouchAction;

#pragma mark - 导航条设置
//  导航栏背景色(default is white)
@property (nonatomic, strong) UIColor  *navBarTintColor;
// 导航栏标题
@property (nonatomic, copy) NSString *navText;
// 导航返回图标
@property (nonatomic, strong) UIImage *navReturnImg;
// 隐藏导航栏尾部线条(默认显示,例:@(YES))
@property (nonatomic, strong) NSNumber *navBottomLineHidden;
// 导航栏隐藏(例:@(YES))
@property (nonatomic, strong) NSNumber *navBarHidden;
// 导航栏状态栏隐藏(例:@(YES))
@property (nonatomic, strong) NSNumber *navStatusBarHidden;
// 导航栏透明(例:@(YES))
@property (nonatomic, strong) NSNumber *navTranslucent;
// 导航栏返回按钮隐藏(例:@(YES))
@property (nonatomic, strong) NSNumber *navBackBtnHidden;
// 导航栏左边按钮
@property (nonatomic, strong) UIBarButtonItem *navLeftControl;
// 隐藏导航栏左边按钮
@property (nonatomic, strong) NSNumber *navLeftControlHidden;

// 导航栏右边按钮
@property (nonatomic, strong) UIBarButtonItem *navRightControl;
// 导航栏属性标题
@property (nonatomic, strong) NSAttributedString *navAttributesText;
//  导航栏文字颜色
@property (nonatomic, strong) UIColor  *navTintColor;
//  导航栏文字字体
@property (nonatomic, strong) UIFont  *navTextFont;
//  导航栏背景图片
@property (nonatomic, strong) UIImage  *navBackgroundImage;
//  导航栏配合背景图片设置，用来控制在不同状态下导航栏的显示(横竖屏是否显示) @(UIBarMetricsCompact)
@property (nonatomic, strong) NSNumber *navBarMetrics;
//  导航栏导航栏底部分割线（图片)
@property (nonatomic, strong) UIImage  *navShadowImage;
//  导航栏barStyle(例:@(UIBarStyleBlack))
@property (nonatomic, strong) NSNumber *navBarStyle;
//  导航栏背景透明(例:@(YES))
@property (nonatomic, strong) NSNumber *navBackgroundClear;
#pragma mark - 授权页
// 授权页背景颜色
@property (nonatomic, strong) UIColor *backgroundColor;
// 授权背景图片
@property (nonatomic,strong) UIImage *bgImg;
//单击页面实现取消操作(例:@(NO))
@property (nonatomic,strong)NSNumber * cancelBySingleClick;

//UIModalPresentationOverCurrentContext style,半透明适用 (例:@(BOOL))
@property (nonatomic, strong) NSNumber *modalPresentationStyleOCC;

//自定义present动画效果代理
@property (nonatomic,weak)id<UIViewControllerTransitioningDelegate> presentAnimationDelegate;

#pragma mark - 授权页logo
// Logo图片
@property (nonatomic, strong) UIImage *logoImg;
// Logo是否隐藏(例:@(YES))
@property (nonatomic,strong)NSNumber * logoHidden;
// Logos圆角(例:@(10))
@property (nonatomic, strong)NSNumber *logoCornerRadius;

#pragma mark - 号码设置
// 手机号码字体颜色
@property (nonatomic, strong) UIColor *numberColor;
// 字体
@property (nonatomic, strong) UIFont *numberFont;
// 手机号对其方式(例:@(NSTextAlignmentCenter))
@property (nonatomic, strong) NSNumber *numberTextAlignment;
// 手机号码背景颜色
@property (nonatomic, strong) UIColor *numberBgColor;
//手机号码是否隐藏
@property (nonatomic, strong)  NSNumber *phoneHidden;
//phone边框颜色
@property (nonatomic, strong) UIColor *phoneBorderColor;
//phone边框宽度
@property (nonatomic, strong) NSNumber *phoneBorderWidth;
//phone圆角
@property (nonatomic, strong) NSNumber *phoneCorner;


#pragma mark - 切换账号设置
// 切换账号背景颜色
@property (nonatomic, copy) UIColor *switchBgColor;
// 切换账号字体颜色
@property (nonatomic, strong) UIColor *switchColor;
// 切换账号字体
@property (nonatomic, strong) UIFont *switchFont;
// 切换账号对其方式(例:@(UIControlContentHorizontalAlignmentCenter))
@property (nonatomic, strong) NSNumber *switchTextHorizontalAlignment;
// 隐藏切换账号按钮, 默认为NO(例:@(YES))
@property (nonatomic, strong) NSNumber *switchHidden;
// 切换账号标题
@property (nonatomic, copy) NSString *switchText;

#pragma mark - 复选框
// 复选框选中时的图片
@property (nonatomic, strong) UIImage *checkedImg;
// 复选框未选中时的图片
@property (nonatomic, strong) UIImage *uncheckedImg;
// 隐私条款check框默认状态，默认为NO(例:@(YES))
@property (nonatomic, strong) NSNumber *checkDefaultState;
// 复选框尺寸 (例:[NSValue valueWithCGSize:CGSizeMake(30, 30)])
@property (nonatomic, strong) NSValue *checkSize;
// 隐私条款check框是否隐藏，默认为NO(例:@(YES))
@property (nonatomic, strong) NSNumber *checkHidden;

#pragma mark - 隐私条款设置(切记,不可隐藏)
// 隐私条款基本文字颜色
@property (nonatomic, strong) UIColor *privacyTextColor;
// 隐私条款协议文字字体
@property (nonatomic, strong) UIFont *privacyTextFont;
// 隐私条款对其方式(例:@(NSTextAlignmentCenter))
@property (nonatomic, strong) NSNumber *privacyTextAlignment;
// 隐私条款协议文字颜色
@property (nonatomic, strong) UIColor *privacyAgreementColor;
// 隐私条款协议背景颜色
@property (nonatomic, strong) UIColor *privacyAgreementBgColor;
// 隐私条款应用名称
@property (nonatomic, copy) NSString *privacyAppName;
// 协议文本前后符号@[@"前置符号",@"后置符号"]
@property (nonatomic, strong) NSArray<NSString*> *privacyProtocolMarkArr;
// 开发者隐私条款协议名称（第一组协议）@[@"名字",@"url",@"分割符"]
@property (nonatomic, strong) NSArray<NSString*> *privacyFirstTextArr;
// 开发者隐私条款协议名称（第二组协议）@[@"名字",@"url",@"分割符"]
@property (nonatomic, strong) NSArray<NSString*> *privacySecondTextArr;
// 开发者隐私条款协议名称（第三组协议）@[@"名字",@"url",@"分割符"]
@property (nonatomic, strong) NSArray<NSString*> *privacyThirdTextArr;
// 隐私条款多行时行距 CGFloat (例:@(4.0))
@property (nonatomic,strong)NSNumber* privacyLineSpacing;
//开发者隐私条款协议默认名称(不建议修改)
@property (nonatomic, copy) NSString  *privacyDefaultText;

//隐私协议下划线样式
//NSUnderlineStyleSingle NSUnderlineStyleThick
@property (nonatomic, strong) NSNumber * privacyUnderlineStyle;

/** (登录即同意)*/
@property (nonatomic, copy) NSString *privacyNormalTextFirst;

/** (并授权)*/
@property (nonatomic, copy) NSString *privacyNormalTextSecond;

/** (获取本机号码)*/
@property (nonatomic, copy) NSString *privacyNormalTextThird;


//隐私条款是否隐藏
@property (nonatomic, strong)  NSNumber *privacyHidden;


//隐私协议WEB页面标题数组
//若设置了 privacyWebTitle 则不生效
//若采用 privacytitleArray 来设置WEB页面标题 请添加一个默认标题用于在默认运营商协议WEB页面中进行展示
@property (nonatomic, strong)  NSArray<NSMutableAttributedString *> *privacytitleArray;

//运营商协议在排序在后 默认为NO(例:@(YES))
@property (nonatomic, strong)  NSNumber *isPrivacyOperatorsLast;

#pragma mark - 隐私条款 具体协议页面
// 隐私条款WEB页面返回按钮图片
@property (nonatomic, strong)UIImage *privacyWebBackBtnImage;

// 隐私条款WEB页面标题
@property (nonatomic, strong)NSAttributedString *privacyWebTitle;

// 隐私条款导航style UIBarStyle (例:@(UIBarStyleBlack))
@property (nonatomic, strong)NSNumber *privacyWebNavBarStyle;

// 隐私条款页面返回按钮 (外界不用传入返回事件)
@property (nonatomic, strong)UIButton *privacyBackButton;

//是否给webview自动添加autolayout
@property (nonatomic, strong)  NSNumber *privacyWebAutoLayout;

//隐私协议页面视图显示(viewDidLoad)
@property (nonatomic,copy) void(^privacyVCShowBlock)(UIViewController *privacyVC,UIView *webView);

//隐私协议点击事件,是否自动跳转  autoInteract（是否由sdk自动跳转隐私协议界面）
@property (nonatomic,copy) void (^privacyAutoShouldInteractWithURLBlock)(UITextView *textView,NSURL *URL,BOOL *autoInteract);
#pragma mark - 登陆按钮设置

// 登录按钮文本
@property (nonatomic, copy) NSString *loginBtnText;
// 登录按钮文本颜色
@property (nonatomic, strong) UIColor *loginBtnTextColor;
// 登录按钮背景颜色
@property (nonatomic, strong) UIColor *loginBtnBgColor;
// 登录按钮边框宽度 (例:@(1.0))
@property (nonatomic, strong) NSNumber *loginBtnBorderWidth;
// 登录按钮边框颜色
@property (nonatomic, strong) UIColor *loginBtnBorderColor;
// 登录按钮圆角  (例:@(10))
@property (nonatomic, strong) NSNumber *loginBtnCornerRadius;
// 登录按钮文字字体
@property (nonatomic, strong) UIFont *loginBtnTextFont;
// 登录按钮背景图片数组 (例:@[激活状态的图片,失效状态的图片,高亮状态的图片])
@property (nonatomic, strong) NSArray<UIImage*> *loginBtnBgImgArr;
//手机号码是否隐藏
@property (nonatomic, strong)  NSNumber *loginBtnHidden;

#pragma mark - 运营商品牌标签(切记,不可隐藏)
//运营商品牌文字字体
@property (nonatomic, strong) UIFont   *sloganTextFont;
//运营商品牌文字颜色
@property (nonatomic, strong) UIColor  *sloganTextColor;
//运营商品牌文字对齐方式 (例:@(NSTextAlignmentCenter))
@property (nonatomic,strong) NSNumber *sloganTextAlignment;
//运营商品牌背景颜色
@property (nonatomic, strong) UIColor  *sloganBgColor;
//运营商品牌文字(不建议修改)
@property (nonatomic, copy) NSString  *sloganText;
//slogan是否隐藏
@property (nonatomic, strong) NSNumber *sloganHidden;
//slogan边框颜色
@property (nonatomic, strong) UIColor *sloganBorderColor;
//slogan边框宽度
@property (nonatomic, strong) NSNumber *sloganBorderWidth;
//slogan圆角
@property (nonatomic, strong) NSNumber *sloganCorner;

#pragma mark - loading 视图
// loading 是否隐藏 (例:@(NO))
@property (nonatomic,strong) NSNumber *hiddenLoading;
//Loading 大小 (例:[NSValue valueWithCGSize:CGSizeMake(60, 60)])
@property (nonatomic,strong) NSValue *loadingSize;
//Loading 背景色
@property (nonatomic,strong) UIColor *loadingBackgroundColor;
//style (例:@(UIActivityIndicatorViewStyleWhiteLarge))
@property (nonatomic,strong) NSNumber *loadingIndicatorStyle;
//Loading 圆角 (例:@(5))
@property (nonatomic,strong) NSNumber *loadingCornerRadius;
//Loading Indicator渲染色
@property (nonatomic,strong) UIColor *loadingTintColor;

#pragma mark - 自定义loading视图
/*
 * 大小 ,背景色,style,圆角,Indicator渲染色 将失效
 * 注意特殊 login函数 的willHiddenLoading 回调 回收特殊loading
 */
@property (nonatomic,copy)void(^loadingView)(UIView * contentView);

#pragma mark - 自定义视图
//默认授权页面添加自定义控件和获取控件位置请再次block中执行
//默认全屏布局样式 customView = vc.view
@property (nonatomic,copy) void(^customViewBlock)(UIView *customView);

//自定义布局的时候，设置布局
@property (nonatomic,copy) void(^manualLayoutBlock)(UIView *containView);

//check按钮点击事件(设置后，将由app处理相关弹窗事件)
@property (nonatomic,copy) void(^hasNotSelectedCheckViewBlock)(UIView *checkView);

#pragma mark - 布局
//布局 竖布局
@property (nonatomic,strong) SecVerifyCustomLayouts *portraitLayouts;
//布局 横布局
@property (nonatomic,strong) SecVerifyCustomLayouts *landscapeLayouts;
//布局 手动自定义布局,不设置横竖布局
@property (nonatomic,strong) NSNumber *manualLayout;

#pragma mark - 横竖屏支持
//横竖屏 是否支持自动转屏 (例:@(NO))
@property (nonatomic,strong) NSNumber *shouldAutorotate;
//横竖屏 设备支持方向 (例:@(UIInterfaceOrientationMaskAll))
@property (nonatomic,strong) NSNumber *supportedInterfaceOrientations;
//横竖屏 默认方向 (例:@(UIInterfaceOrientationPortrait))
@property (nonatomic,strong) NSNumber *preferredInterfaceOrientationForPresentation;

@end


