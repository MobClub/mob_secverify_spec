//
//  UniAuthViewModel.h
//

#import <UIKit/UIKit.h>
#import "UniPrivacyTermItem.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * @abstract 授权登录页面自定义视图，customAreaView为授权页面的view，如，可将三方登录添加到授权登录页面
 */
typedef void(^UniCustomUIHandler)(UIView *customAreaView);

/**
 * 授权页自定义Loading，会在点击登录按钮之后触发
 * containerView为loading的全屏蒙版view
 * 请自行在containerView添加自定义loading
 * 设置block后，默认loading将无效
 */
typedef void(^UniLoadingViewBlock)(UIView *containerView);

/**
 * 停止授权页自定义Loading，会在调用[OneLogin stopLoading]时触发
 * containerView为loading的全屏蒙版view
 */
typedef void(^UniStopLoadingViewBlock)(UIView *containerView);


typedef struct UniRect {
    /**
     控件顶部到导航栏底部的距离
     */
    CGFloat portraitTopYOffset;
    
    /**
     控件的左边缘到屏幕左边缘的距离，默认为0
     */
    CGFloat portraitLeftXOffset;
    
    /**
     控件大小，只有宽度、高度同时大于0，设置的size才会生效，否则为控件默认的size
     */
    CGSize size;
} UniRect;

@interface UniAuthViewModel : NSObject

#pragma mark - Status Bar/状态栏

/**
 状态栏样式。 默认 `UIStatusBarStyleDefault`。
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

#pragma mark - Navigation/导航

/**
 授权页导航的标题。默认为空字符串。
 */
@property (nullable, nonatomic, strong) NSAttributedString *naviTitle;

/**
 授权页导航的背景颜色。默认白色。
 */
@property (nullable, nonatomic, strong) UIColor *naviBgColor;

/**
 授权页导航左边的返回按钮的图片。默认黑色系统样式返回图片。
 */
@property (nullable, nonatomic, strong) UIImage *naviBackImage;

/**
 授权页导航右边的自定义控件。
 */
@property (nullable, nonatomic, strong) UIView *naviRightControl;

#pragma mark - Logo/图标

/**
 授权页面上展示的图标。默认为 "OneLogin" 图标。
 */
@property (nullable, nonatomic, strong) UIImage *appLogo;

/**
 Logo 位置及大小。
 */
@property (nonatomic, assign) UniRect logoRect;

/**
 Logo 图片隐藏。默认不隐藏。
 */
@property (nonatomic, assign) BOOL logoHidden;

#pragma mark - Phone Number Preview/手机号预览

/**
 号码预览文字的颜色。默认黑色。
 */
@property (nullable, nonatomic, strong) UIColor *phoneNumColor;

/**
 号码预览文字的字体。默认粗体，24pt。
 */
@property (nullable, nonatomic, strong) UIFont *phoneNumFont;

/**
 号码预览 位置及大小，电话号码不支持设置大小，大小根据电话号码文字自适应
 */
@property (nonatomic, assign) UniRect phoneNumRect;

#pragma mark - Switch Button/切换按钮

/**
 授权页切换账号按钮的文案。默认为“切换账号”。
 */
@property (nullable, nonatomic, copy) NSString *switchButtonText;

/**
 授权页切换账号按钮的颜色。默认蓝色。
 */
@property (nullable, nonatomic, strong) UIColor *switchButtonColor;

/**
 授权页切换账号的字体。默认字体，15pt。
 */
@property (nullable, nonatomic, strong) UIFont *switchButtonFont;

/**
 授权页切换账号按钮 位置及大小。
 */
@property (nonatomic, assign) UniRect switchButtonRect;

/**
 隐藏切换账号按钮。默认不隐藏。
 */
@property (nonatomic, assign) BOOL switchButtonHidden;

#pragma mark - Authorization Button/认证按钮

/**
 授权页认证按钮的背景图片, @[正常状态的背景图片, 不可用状态的背景图片, 高亮状态的背景图片]。默认正常状态为蓝色纯色, 不可用状态的背景图片时为灰色, 高亮状态为灰蓝色。
 */
@property (nullable, nonatomic, strong) NSArray<UIImage *> *authButtonImages;

/**
 授权按钮文案。默认白色的"一键登录"。
 */
@property (nullable, nonatomic, strong) NSAttributedString *authButtonTitle;

/**
 授权按钮 位置及大小。
 */
@property (nonatomic, assign) UniRect authButtonRect;

/**
 授权按钮圆角，默认为0。
 */
@property (nonatomic, assign) CGFloat authButtonCornerRadius;

#pragma mark - Slogan/口号标语

/**
 Slogan 位置及大小。
 */
@property (nonatomic, assign) UniRect sloganRect;

/**
 Slogan 文字颜色。默认灰色。
 */
@property (nonatomic, strong) UIColor *sloganTextColor;

/**
 Slogan字体。默认字体, 12pt。
 */
@property (nonatomic, strong) UIFont *sloganTextFont;

/**
 授权页面上勾选框勾选的图标。默认为蓝色图标。推荐尺寸为12x12。
 */
@property (nullable, nonatomic, strong) UIImage *checkedImage;

/**
 授权页面上勾选框未勾选的图标。默认为白色图标。推荐尺寸为12x12。
 */
@property (nullable, nonatomic, strong) UIImage *uncheckedImage;

/**
 授权页面上条款勾选框大小。
 */
@property (nonatomic, assign) CGSize checkBoxSize;

/**
 考虑兼容性问题，这里增加勾选框的精确位置定义
 */
@property (nonatomic, assign) CGFloat checkBoxTopYOffset;
@property (nonatomic, assign) CGFloat checkBoxLeftXOffset;

/**
 隐私条款文字属性。默认基础文字灰色, 条款蓝色高亮, 12pt。
 */
@property (nullable, nonatomic, strong) NSDictionary<NSAttributedStringKey, id> *privacyTermsAttributes;

/**
 额外的条款。默认为空。
 */
@property (nullable, nonatomic, strong) NSArray<UniPrivacyTermItem *> *additionalPrivacyTerms;

/**
 服务条款普通文字的颜色。默认灰色。
 */
@property (nullable, nonatomic, strong) UIColor *termTextColor;

/**
 隐私条款 位置及大小，隐私条款，宽需大于50，高需大于20，才会生效。
 */
@property (nonatomic, assign) UniRect termsRect;

/**
 除隐私条款外的其他文案，数组大小必须为4，元素依次为：条款前的文案、条款一和条款二连接符、条款二和条款三连接符，条款后的文案。
 默认为@[@"登录即同意", @"和", @"、", @"并使用本机号码登录"]
 */
@property (nullable, nonatomic, copy) NSArray<NSString *> *auxiliaryPrivacyWords;


/**
 联通服务条款是否带书名号
 */
@property (nonatomic, assign) BOOL bookTitleMark;

#pragma mark - Custom Area/自定义区域

/**
 自定义区域视图的处理block
 
 @discussion
 提供的视图容器使用NSLayoutConstraint与相关的视图进行布局约束。
 如果导航栏没有隐藏, 顶部与导航栏底部对齐, 左边与屏幕左边对齐, 右边与屏幕右边对齐, 底部与屏幕底部对齐。
 如果导航栏隐藏, 顶部与状态栏底部对齐, 左边与屏幕左边对齐, 右边与屏幕右边对齐, 底部与屏幕底部对齐。
 */
@property (nullable, nonatomic, copy) UniCustomUIHandler customUIHandler;

#pragma mark - Background Image/授权页面背景图片

/**
 授权页背景颜色。默认白色。
 */
@property (nullable, nonatomic, strong) UIColor *backgroundColor;


#pragma mark - Popup

/**
 * 是否为弹窗模式
 */
@property (nonatomic, assign) BOOL isPopup;

/**
 弹窗 位置及大小。弹窗模式时，x轴偏移只支持portraitLeftXOffset和landscapeLeftXOffset。
 */
@property (nonatomic, assign) UniRect popupRect;

/**
 弹窗圆角，默认为6。
 */
@property (nonatomic, assign) CGFloat popupCornerRadius;

/**
 当只需要设置弹窗的部分圆角时，通过popupCornerRadius设置圆角大小，通过popupRectCorners设置需要设置圆角的位置。
 popupRectCorners数组元素不超过四个，超过四个时，只取前四个。比如，要设置左上和右上为圆角，则传值：@[@(UIRectCornerTopLeft), @(UIRectCornerTopRight)]
 */
@property (nullable, nonatomic, strong) NSArray<NSNumber *> * popupRectCorners;

/**
 弹窗关闭按钮图片，弹窗关闭按钮的尺寸跟图片尺寸保持一致。
 弹窗关闭按钮位于弹窗右上角，目前只支持设置其距顶部偏移和距右边偏移。
 */
@property (nullable, nonatomic, strong) UIImage *closePopupImage;

/**
 弹窗关闭按钮距弹窗顶部偏移。
 */
@property (nullable, nonatomic, strong) NSNumber *closePopupTopOffset;

/**
 弹窗关闭按钮距弹窗右边偏移。
*/
@property (nullable, nonatomic, strong) NSNumber *closePopupRightOffset;
#pragma mark - Loading

/**
 * 授权页面，自定义加载进度条，点击登录按钮之后的回调
 *  Token流程优化后，该属性废弃！！！
 */
@property (nullable, nonatomic, copy) UniLoadingViewBlock loadingViewBlock;

/**
 * 授权页面，停止自定义加载进度条
 *  Token流程优化后，该属性废弃！！！
 */
@property (nullable, nonatomic, copy) UniStopLoadingViewBlock stopLoadingViewBlock;

#pragma mark - WebViewController Navigation/服务条款页面导航栏

/**
 服务条款页面导航的标题。默认为"服务条款"，粗体、17pt。
 */
@property (nullable, nonatomic, strong) NSAttributedString *webNaviTitle;

/**
 服务条款页面导航的背景颜色。默认白色。
 */
@property (nullable, nonatomic, strong) UIColor *webNaviBgColor;

/**
 未勾选服务条款复选框时，点击登录按钮的提示。默认为"请同意服务条款"。
 */
@property (nullable, nonatomic, copy) NSString *notCheckProtocolHint;



@property (nonatomic, assign) BOOL defaultCheckBoxState;

@property (nonatomic, assign) BOOL debugMode;

@end

NS_ASSUME_NONNULL_END
