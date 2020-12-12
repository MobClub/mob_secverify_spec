//
//  OpenViewController.m
//  UMC
//
//  Created by LL on 16/5/26.
//  Copyright © 2016年 LL. All rights reserved.
//

#import "OpenViewController.h"
#import <TYRZSDK/TYRZSDK.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCrypto.h>
//#import <ifaddrs.h>
//#import <netdb.h>
//#import <sys/sysctl.h>
//#import <net/if.h>
//#import <net/if_dl.h>
//#import <netinet/in.h>
//#import <objc/runtime.h>

//在appdelegate设置
#define APPID  [[NSUserDefaults standardUserDefaults]objectForKey:@"TYRZSDKAPPID"]
#define APPKEY [[NSUserDefaults standardUserDefaults]objectForKey:@"TYRZSDKAPPKEY"]

#define SUCCESSCODE @"103000"

UIColor *hexColor(long hex) {
    
    long red = (hex & 0xff0000) >> 16;
    long green = (hex & 0x00ff00) >> 8;
    long blue = (hex & 0x0000ff) >> 0;
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    
};


#pragma mark ----- OpenViewTextFieldCell

typedef void(^textFieldBlock)(NSString *textFStr);

@interface OpenViewTextFieldCell : UICollectionViewCell<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UILabel *textFieldTitle;
@property (nonatomic,copy) textFieldBlock textFieldBlock;

@end

@implementation OpenViewTextFieldCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 0,90, self.frame.size.height)];
    label.text = @"超时时间设置:";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    self.textFieldTitle = label;
    [self addSubview:label];

    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 10, 0, self.frame.size.width - 60 - 90 - 10, self.frame.size.height)];
    self.textField.delegate = self;
    self.textField.layer.cornerRadius = 4.0;
    self.textField.layer.masksToBounds = YES;
    self.textField.layer.borderWidth = 1.0;
    self.textField.layer.borderColor = [[UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0] CGColor];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.placeholder = @"请输入";
    self.textField.layer.borderColor = hexColor(0x2372b1).CGColor;
    [self addSubview:self.textField];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.textFieldBlock) {
        self.textFieldBlock(textField.text);
    }
}

@end



#pragma mark ----- 开关Cell  swtichCell

typedef void(^SwtichBlock)(BOOL on);

@interface OpenViewSwtichCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *swtichLabel;
@property (nonatomic,strong) UISwitch *swtich;
@property (nonatomic,copy) SwtichBlock SwtichBlock;

@end

@implementation OpenViewSwtichCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    self.swtichLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, fminf(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)/3*2 - 30, self.frame.size.height)];
    self.swtichLabel.layer.cornerRadius = 4.0;
    self.swtichLabel.layer.masksToBounds = YES;
    self.swtichLabel.layer.borderWidth = 1.0;
    self.swtichLabel.layer.borderColor = [[UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0] CGColor];
    self.swtichLabel.textAlignment = NSTextAlignmentCenter;
    self.swtichLabel.backgroundColor = [UIColor whiteColor];
    self.swtichLabel.text = @"";
    self.swtichLabel.font = [UIFont systemFontOfSize:14];
    
    self.swtich = [[UISwitch alloc]initWithFrame:CGRectMake(30 + UIScreen.mainScreen.bounds.size.width/3*2, 5, self.frame.size.width/3 - 30, self.frame.size.height)];
    [self.swtich addTarget:self action:@selector(switchAction:) forControlEvents:(UIControlEventValueChanged)];
    self.swtich.on = NO;
    
    [self addSubview:self.swtichLabel];
    [self addSubview:self.swtich];
}

- (void)switchAction:(UISwitch *)sender {
    if (self.SwtichBlock) {
        if (sender.on) {
            self.SwtichBlock(YES);
        }else{
            self.SwtichBlock(NO);
        }
    }
    
}

@end

@interface OpenViewController ()<UIActionSheetDelegate,UITextFieldDelegate,UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *waitBGV;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitAV;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (copy,nonatomic) NSDictionary *loginInfo;
@property (copy,nonatomic) NSString *token;
@property (nonatomic,strong) NSArray<NSDictionary *> *testItems;
@property (nonatomic,copy) NSString *phoneTextStr;
@property (nonatomic,copy) NSString *validateTime;

@property (nonatomic,strong)UIDocumentInteractionController *documentController;

@property (nonatomic,assign) BOOL isDimiss;
@property (nonatomic,assign) BOOL SMSOn;
@property (nonatomic,assign) BOOL authWindow;
@property (nonatomic,assign) BOOL edgeWindow;
@property (nonatomic,assign) BOOL landscapeleft;
@property (nonatomic,assign) BOOL shouldAuthorVCStatusBarWhite;

@end

@implementation OpenViewHeader


@end

@implementation OpenViewFooter


@end

@implementation OpenViewCell

- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.titleV.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0];
    }else {
        self.titleV.backgroundColor = [UIColor whiteColor];
    }
}

@end

@interface OpenViewController ()<UIActionSheetDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *listCV;

@end

@implementation OpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.listCV registerClass:[OpenViewTextFieldCell class] forCellWithReuseIdentifier:NSStringFromClass([OpenViewTextFieldCell class])];
    [self.listCV registerClass:[OpenViewSwtichCell class] forCellWithReuseIdentifier:NSStringFromClass([OpenViewSwtichCell class])];

//    //监听键盘出现和消失
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
//    [TYRZUILogin initializeWithAppId:APPID appKey:APPKEY];
    
    NSString *uiFilePath = [NSBundle.mainBundle pathForResource:@"ui" ofType:@"json"];
    NSString *uiJSONStr = [NSString stringWithContentsOfFile:uiFilePath encoding:NSUTF8StringEncoding error:nil];
    if (uiJSONStr.length > 0) {
        self.testItems = [NSJSONSerialization JSONObjectWithData:[uiJSONStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    }

    self.label.text = [[[NSString stringWithFormat:@"版本:%@",UASDKVERSION]stringByAppendingString:@"_"]stringByAppendingString:[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]];
//
//    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didInputPhoneNum:) name:UITextFieldTextDidChangeNotification object:nil];
    [self setTimeOut];
   
}

- (void)setTimeOut{
    [UASDKLogin.shareLogin setTimeoutInterval:self.validateTime.length>0? [self.validateTime doubleValue] : 8000];
    
}

- (void)customShareButtonsWithView:(UIView *)view {
    
    NSArray<NSString *> *shareIcons = @[@"(friend_quan)_SFont.CN.png",@"(QQ)_SFont.CN.png",@"(WeChat)_SFont.CN.png",@"(weibo)_SFont.CN.png"];
    
    CGFloat marginH = 40, sideLen = (view.frame.size.width - 5*marginH)/shareIcons.count, __block nextX = marginH, iconY = (view.frame.size.height - sideLen)/2;
    [shareIcons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [shareButton setImage:({
            
            NSString *path = [NSBundle.mainBundle pathForResource:obj ofType:nil];
            [UIImage imageWithContentsOfFile:path];
            
        }) forState:UIControlStateNormal];
        
        shareButton.frame = (CGRect){nextX,iconY,sideLen,sideLen};
        [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
        nextX = CGRectGetMaxX(shareButton.frame) + marginH;
        
        [view addSubview:shareButton];
        
    }];
    
}

- (void)shareAction:(UIButton *)sender{
    
}

- (void)setToken:(NSString *)token {
    
    _token = [token copy];
//    _textField.enabled = _token.length > 0;
    
}

//- (void)didInputPhoneNum:(NSNotification *)sender {
//
//    UITextField *textField = sender.object;
//    self.text = textField.text;
//
//}


- (void)rightButtonAciton:(id)sender{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        //TODO....
    }];
}

#pragma mark - Show
/**
 转换成显示的信息
 */
- (NSString *)changeShowMessage:(id)sender {
    NSString *message = @"";
    id resultcode = sender[@"resultcode"];
    if ([resultcode isEqual:@"000"]) {
        //
        id desc = sender[@"desc"];;
        message = [message stringByAppendingFormat:@"\n描述:%@",desc];
        //
        id passid = sender[@"passid"];;
        message = [message stringByAppendingFormat:@"\n通行证号:%@",passid];
        //
        id uniqueid = sender[@"uniqueid"];;
        message = [message stringByAppendingFormat:@"\n用户身份标识:%@",uniqueid];
        //
        id accesstoken = sender[@"accesstoken"];;
        message = [message stringByAppendingFormat:@"\naccesstoken:%@",accesstoken];
    }else {
        //
        message = [message stringByAppendingFormat:@"\n错误码:%@",resultcode];
        //
        id desc = sender[@"desc"];;
        message = [message stringByAppendingFormat:@"\n错误描述:%@",desc];
    }
    return message;
}
 //支持旋转
//-(BOOL)shouldAutorotate{
//    return NO;
//}

////支持的方向
// - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;
//}

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

#pragma mark --------------预取号------------------

- (void)showImplicitLogin {
    self.waitBGV.hidden = NO;
    [self.waitAV startAnimating];
    __weak typeof(self) weakSelf = self;
    [self setTimeOut];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [UASDKLogin.shareLogin getPhoneNumberCompletion:^(NSDictionary * _Nonnull sender) {
            weakSelf.waitBGV.hidden = YES;
            [weakSelf.waitAV stopAnimating];
            NSString *resultCode = sender[@"resultCode"];
            NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:sender];
            if ([resultCode isEqualToString:@"103000"]) {
                NSLog(@"预取号成功");
            } else {
                NSLog(@"预取号失败");
            }
            [weakSelf showInfo:result];
        }];
//    });
}

#pragma mark --------------隐式获取token------------------

- (void)getTokenImp {
    
    self.waitBGV.hidden = NO;
    [self.waitAV startAnimating];
    [self setTimeOut];
    __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [UASDKLogin.shareLogin mobileAuthCompletion:^(NSDictionary * _Nonnull sender) {
        weakSelf.waitBGV.hidden = YES;
        [weakSelf.waitAV stopAnimating];
        NSString *resultCode = sender[@"resultCode"];
        NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:sender];
        if ([resultCode isEqualToString:SUCCESSCODE]) {
            
            NSLog(@"隐式登录成功");
            weakSelf.token = result[@"token"];
        } else {
            NSLog(@"隐式登录失败");
        }
        [weakSelf showInfo:result];
    }];
//    });
}

- (void)sssssdismiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark --------------显示获取token------------------

- (void)getTokenExp {
    self.waitBGV.hidden = NO;
    [self.waitAV startAnimating];
    [self setTimeOut];
    __weak typeof(self) weakSelf = self;
/*注意事项:********************************model测试专用******************************************************************
     UACustomModel的 currentVC 必须要传*/
    UACustomModel *model = [[UACustomModel alloc]init];
    //1、当前VC 必传 不传会提示调用失败
    model.currentVC = self;
    model.statusBarStyle = self.shouldAuthorVCStatusBarWhite ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
    model.authViewBlock = ^(UIView *customView, CGRect numberFrame , CGRect loginBtnFrame,CGRect checkBoxFrame, CGRect privacyFrame) {
        
        CGFloat status = self.authWindow ? 10 : [[UIApplication sharedApplication]statusBarFrame].size.height;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20,  status  + (44-30)/2, 20, 20)];
        [btn setImage:[UIImage imageNamed:@"windowclose"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sssssdismiss) forControlEvents:(UIControlEventTouchUpInside)];
        [customView addSubview:btn];
        
        
//        [self setThirdViewWithCustom:customView isSmall:isSmallScreen frame:loginBtnFrame];
        
    };
    model.privacyState = NO;
    //此处判断是否打开强制横屏开关，或者当前设备已处于横屏状态，则弹窗也横屏弹出。
    if (self.landscapeleft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight ) {
        model.faceOrientation = UIInterfaceOrientationLandscapeRight;
    }else if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft){
        model.faceOrientation = UIInterfaceOrientationLandscapeLeft;
    }else{
        model.faceOrientation = UIInterfaceOrientationPortrait;
    }
#pragma mark--是否开启自定义属性设置
#if 0 //0 为默认界面 ，1为以下设置界面
    
    #pragma mark 自定义控件
    //2、授权界面自定义控件View的Block
    model.authViewBlock = ^(UIView *customView, CGRect numberFrame, CGRect loginBtnFrame, CGRect checkBoxFrame, CGRect privacyFrame) {
        CGFloat status = [[UIApplication sharedApplication]statusBarFrame].size.height;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, status + (44-30)/2, 20, 20)];
        [btn setImage:[UIImage imageNamed:@"windowclose"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sssssdismiss) forControlEvents:(UIControlEventTouchUpInside)];
        [customView addSubview:btn];
    };
    //3、授权页面推出的动画效果
    model.presentType = 3;
    //4、设置授权界面背景图片
//    model.authPageBackgroundImage = [UIImage imageNamed:@"timg"];
    //5、loading
    model.authLoadingViewBlock = ^(UIView *loadingView) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [arr addObject:[UIImage imageNamed:@"微博1"]];
        [arr addObject:[UIImage imageNamed:@"微信1"]];
        [arr addObject:[UIImage imageNamed:@"中国移动"]];
        [arr addObject:[UIImage imageNamed:@"checkOn"]];
        [arr addObject:[UIImage imageNamed:@"iconlogo_iqiyi"]];
        [arr addObject:[UIImage imageNamed:@"Logo"]];
        [arr addObject:[UIImage imageNamed:@"windowclose"]];
        [arr addObject:[UIImage imageNamed:@"timg"]];
        [arr addObject:[UIImage imageNamed:@"WechatIMG16"]];

        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 90, 200, 400)];
        imageView.backgroundColor = [UIColor redColor];
        imageView.animationImages = arr;
        imageView.animationDuration = 3;
        
        [loadingView addSubview:imageView];
        [imageView startAnimating];
    };
    //6、登录按钮修改
    #pragma mark 登录按钮
    model.logBtnText = [[NSAttributedString alloc]initWithString:@"自定义登录按钮" attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    //7、按钮偏移量Y
    model.logBtnOffsetY = @150;
    //8、按钮左右边距
    model.logBtnOriginLR = @[@200,@100];
    //9、登录按钮的高h
    model.logBtnHeight = 80;
    //10、授权界面登录按钮三种状态
    UIImage *norMal = [UIImage imageNamed:@"timg"];
    UIImage *invalied = [UIImage imageNamed:@"WechatIMG16"];
    UIImage *highted = [UIImage imageNamed:@"checkOn"];
    model.logBtnImgs = @[norMal,invalied,highted];
    /**11、登录按钮高距离底部的高度*/
//    model.logBtnOffsetY_B = @10;
    #pragma mark 号码框设置
    //12、号码栏字体大小
    model.numberText = [[NSAttributedString alloc]initWithString:@"sfdsfd" attributes:@{NSForegroundColorAttributeName:UIColor.orangeColor,NSFontAttributeName:[UIFont systemFontOfSize:30]}];
    //13、号码栏X偏移量
    model.numberOffsetX = @70;
    //14、号码栏Y偏移量
    model.numberOffsetY = @300;
    //15、切换按钮隐藏开关
//    model.numberOffsetY_B = @30;
    //16、隐私条款uncheckedImg选中图片
    #pragma mark 隐私条款
    model.uncheckedImg = [UIImage imageNamed:@"checkOn"];
    //17、隐私条款chexBox选中图片
    model.checkedImg = [UIImage imageNamed:@"timg.jpg"];
    //18、复选框大小（只能正方形）必须大于12*/
    model.checkboxWH = @30;
    //*19、隐私条款（包括check框）的左右边距*/
    model.appPrivacyOriginLR = @[@100,@122];
    //20、隐私的内容模板
    model.appPrivacyDemo = [[NSAttributedString alloc]initWithString:@"登录&&默认&&本界面并同意授权hdhhhhdhddh腾讯协议和百度协议、进行本机号码登录" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Marion" size:17],NSForegroundColorAttributeName:UIColor.orangeColor}];
    NSAttributedString *str1 = [[NSAttributedString alloc]initWithString:@"腾讯协议" attributes:@{NSLinkAttributeName:@"https://www.qq.com"}];
    NSAttributedString *str2 = [[NSAttributedString alloc]initWithString:@"百度协议" attributes:@{NSLinkAttributeName:@"https://www.baidu.com"}];
    //21、隐私条款默认协议是否开启书名号
    model.privacySymbol = YES;
    //22、隐私条款文字内容的方向:默认是居左
    model.appPrivacyAlignment = NSTextAlignmentLeft;
    //23、隐私条款:数组对象
    model.appPrivacy = @[str1,str2];
    //24、隐私条款名称颜色（协议）
    model.privacyColor = [UIColor blackColor];
    //25、隐私条款偏移量
    model.privacyOffsetY = [NSNumber numberWithFloat:(100/2)];
    //26、隐私条款check框默认状态
    model.privacyState = NO;
    //27、隐私条款Y偏移量(注:此属性为与屏幕底部的距离)
//    model.privacyOffsetY_B = @33;
    //28、web协议界面导航返回图标(尺寸根据图片大小)
    model.webNavReturnImg = [UIImage imageNamed:@"title_back"];
    //29、web协议界面导航标题栏
    model.webNavText = [[NSAttributedString alloc]initWithString:@"我是协议界面" attributes:@{NSForegroundColorAttributeName:[UIColor yellowColor]}];
    //30、web协议界面导航标题栏颜色
    model.webNavColor = [UIColor redColor];

#endif

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 90, 200, 400)];
#pragma mark ----------------------弹窗竖屏:(温馨提示:由于受屏幕影响，小屏幕（5S,5E,5）需要改动字体和另自适应和布局)--------------------
    if (self.authWindow && self.landscapeleft) {
        //⑴居中弹窗 特殊方式 -----务必在设置控件位置时，自行查看各个机型是否正常
        
        //要匹配更多屏幕,此处为控件大小控制设置（建议只更改Logo大小）
        //31、弹窗退出动画
        model.authWindow = YES;
        //32、居中弹窗开关
        //UIModalTransitionStyleCoverVertical, 下推 0
        //UIModalTransitionStyleFlipHorizontal,翻转 1
        //UIModalTransitionStyleCrossDissolve, 淡出 2
        model.modalTransitionStyle = 0;
        //33、自定义窗口弧度
        model.cornerRadius = 15;
        //34、自定义窗口宽-缩放系数(屏幕宽乘以系数) 默认是0.8 其它比例自行配置
        model.scaleW = 0.8;
        //35、自定义窗口高-缩放系数(屏幕高乘以系数) 默认是0.5 其它比例自行配置
        model.scaleH = 0.5;
        model.privacyOffsetY_B = @10;
        model.appPrivacyAlignment = 1;
        //在5、5s、5e下,需要改字体才能适配
        BOOL isSmallScreen = UIScreen.mainScreen.bounds.size.height < 667.0f;
        if (isSmallScreen) {
            model.numberOffsetY = @90;
            model.scaleW = 0.7;
            model.privacyOffsetY = @5;
            
        }
       
    }
#pragma mark ----------------------弹窗横屏:(温馨提示:由于受屏幕影响，小屏幕（5S,5E,5）需要改动字体和另自适应和布局)--------------------
    else if(self.authWindow &&!self.landscapeleft){
        CGFloat overallScaleH = UIScreen.mainScreen.bounds.size.height/ 375.f;
        CGFloat overallScaleW = UIScreen.mainScreen.bounds.size.width/ 667.f;
        model.authWindow = YES;
        model.cornerRadius = 10;
        model.modalTransitionStyle = 1;
        BOOL isSmallScreen = UIScreen.mainScreen.bounds.size.height < 375.f;
        model.scaleH = 0.7;
        model.scaleW = 0.7;

        model.numberOffsetX = @(-155 * overallScaleW);
        model.logBtnOffsetY = @(110 * overallScaleH);
        model.numberOffsetY = @((110 + (40 - 23.86)/2) * overallScaleH);
        model.privacyOffsetY_B = @(55 * overallScaleH);
        model.authViewBlock = ^(UIView *customView, CGRect numberFrame , CGRect loginBtnFrame,CGRect checkBoxFrame, CGRect privacyFrame) {
            
       
            
            CGFloat subViewH = isSmallScreen ? 45 : 55;
            UIImage *imageS = [UIImage imageNamed:@"中国移动.png"];
            CGFloat imageH = isSmallScreen ? 30 : 40;
            CGFloat widthI = imageS.size.width / imageS.size.height * imageH;
            UIImageView *imageV = [[UIImageView alloc]initWithImage:imageS];
            imageV.frame = CGRectMake(10, 10, widthI, imageH);
            [customView addSubview:imageV];
            
            
//            CGFloat status = [[UIApplication sharedApplication]statusBarFrame].size.height;
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(customView.frame.size.width - 20 - 10, (imageH-20)/2 + 10, 20, 20)];
            [btn setImage:[UIImage imageNamed:@"windowclose"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(sssssdismiss) forControlEvents:(UIControlEventTouchUpInside)];
            [customView addSubview:btn];
            
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
            line.frame = CGRectMake(0, subViewH, customView.frame.size.width,1);
            [customView addSubview:line];
            
            UIView *thirdView = [[UIView alloc]init];
            thirdView.frame = CGRectMake(0, customView.frame.size.height - subViewH, customView.frame.size.width, subViewH);
            thirdView.backgroundColor = [UIColor colorWithRed:233/255.f green:234/255.f blue:254/255.f alpha:1];
            
            [customView addSubview:thirdView];
            
            //自定义------控件（仅供参考）
            //        CGFloat screenh = customView.frame.size.height;
            UIButton *btnWeChat = [self setBtnWith:@"微信1"];
            UIButton *btnQQ = [self setBtnWith:@"qq1"];
            UIButton *btnWebo = [self setBtnWith:@"微博1"];
            [btnWeChat setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [btnQQ setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [btnWebo setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            
            UILabel *label = [[UILabel alloc]init];
            label.text = @"其它登录方式:";
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:isSmallScreen ? 12 :15];
            label.textAlignment = NSTextAlignmentLeft;
            CGSize sizeLabel = [label.text sizeWithAttributes:@{NSForegroundColorAttributeName:label.textColor,NSFontAttributeName:label.font}];
            CGRect labelFrame =  label.frame;
            labelFrame.size = sizeLabel;
            label.frame = labelFrame;
            label.frame = CGRectMake(0, 0, thirdView.frame.size.width, label.frame.size.height);
            [thirdView addSubview:label];
            
            CGFloat btnW = subViewH - label.frame.size.height;
            CGFloat margin = 40;
            
            btnWeChat.frame = CGRectMake((thirdView.frame.size.width - 3 *btnW - 2 *margin)/2, CGRectGetMaxY(label.frame),btnW , btnW);
            btnQQ.frame = CGRectMake(CGRectGetMaxX(btnWeChat.frame) + margin, CGRectGetMaxY(label.frame), btnW, btnW);
            btnWebo.frame = CGRectMake(CGRectGetMaxX(btnQQ.frame) + margin, CGRectGetMaxY(label.frame), btnW, btnW);
            [thirdView addSubview:btnWeChat];
            [thirdView addSubview:btnQQ];
            [thirdView addSubview:btnWebo];
            
        };
        
    }
    
#pragma mark ----------------------边缘弹窗:(温馨提示:authWindow必须为NO,由于受屏幕影响，小屏幕（5S,5E,5）需要改动字体和另自适应和布局)--------------------
    else if(!self.authWindow && !self.landscapeleft && self.edgeWindow){
        CGFloat overallScaleH = UIScreen.mainScreen.bounds.size.height/ 667.f;
//        CGFloat overallScaleW = UIScreen.mainScreen.bounds.size.width/ 375.f;
        //推出动画由model中的presentType来决定
        model.presentType = 0;
        //36、边缘弹窗方式中的VC尺寸
        model.controllerSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height/2);
        model.numberOffsetY = @(70 * overallScaleH);
        model.privacyOffsetY = @((UIScreen.mainScreen.bounds.size.height)/2 - 35);
        
        model.authViewBlock = ^(UIView *customView, CGRect numberFrame , CGRect loginBtnFrame,CGRect checkBoxFrame, CGRect privacyFrame) {
            
            CGFloat status = 10;
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40,  status  + (44-30)/2, 20, 20)];
            [btn setImage:[UIImage imageNamed:@"windowclose"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(sssssdismiss) forControlEvents:(UIControlEventTouchUpInside)];
            [customView addSubview:btn];
            
            
            //        [self setThirdViewWithCustom:customView isSmall:isSmallScreen frame:loginBtnFrame];
        };
        
    }
    
    
    
//******************************************************************************************************************
    [UASDKLogin.shareLogin getAuthorizationWithModel:model complete:^(id  _Nonnull sender) {
        weakSelf.waitBGV.hidden = YES;
        [weakSelf.waitAV stopAnimating];
        NSString *resultCode = sender[@"resultCode"];
        NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:sender];
        NSLog(@"self=%@",weakSelf);
        if ([resultCode isEqualToString:SUCCESSCODE]) {
            [imageView stopAnimating];
            if (weakSelf.isDimiss) {
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
            result[@"result"] = @"获取token成功";
            weakSelf.token = sender[@"token"];
        } else if(![resultCode isEqualToString:@"200087"]){
            result[@"result"] = @"获取token失败";
        }else{
            [imageView stopAnimating];
        }
        [weakSelf showInfo:result];

    }];
//    });
}

- (void)setThirdViewWithCustom:(UIView *)customView isSmall:(BOOL)isSmallScreen frame:(CGRect)frame{
    
    //自定义------控件（仅供参考）
    CGFloat screenW = customView.frame.size.width;
    //        CGFloat screenh = customView.frame.size.height;
    UIView *v = [[UIView alloc]init];
    v.frame = CGRectMake(frame.origin.x, CGRectGetMaxY(frame) + 10 , screenW - frame.origin.x * 2, (screenW - frame.origin.x * 2)/3);
    UIButton *btnWeChat = [self setBtnWith:@"微信1"];
    UIButton *btnQQ = [self setBtnWith:@"qq1"];
    UIButton *btnWebo = [self setBtnWith:@"微博1"];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"其它登录方式";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:isSmallScreen ? 12 :15];
    label.textAlignment = NSTextAlignmentCenter;
    CGSize sizeLabel = [label.text sizeWithAttributes:@{NSForegroundColorAttributeName:label.textColor,NSFontAttributeName:label.font}];
    CGRect labelFrame =  label.frame;
    labelFrame.size = sizeLabel;
    label.frame = labelFrame;
    label.frame = CGRectMake(0, 0, v.frame.size.width, label.frame.size.height);
    [v addSubview:label];
    
    CGFloat btnW = (v.frame.size.width - label.frame.size.height)/3;
    
    btnWeChat.frame = CGRectMake(0, CGRectGetMaxY(label.frame),btnW , btnW);
    btnQQ.frame = CGRectMake(btnW, CGRectGetMaxY(label.frame), btnW, btnW);
    btnWebo.frame = CGRectMake(btnW * 2, CGRectGetMaxY(label.frame), btnW, btnW);
    [v addSubview:btnWeChat];
    [v addSubview:btnQQ];
    [v addSubview:btnWebo];
    [customView addSubview:v];
}

- (UIButton *)setBtnWith:(NSString *)imageName{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];

    return btn;
}

- (void)rightButtonItemAction {
    self.waitBGV.hidden = YES;
    [self.waitAV stopAnimating];
    [UASDKLogin.shareLogin delectScrip];
    [self showInfo:@{@"导航右键":@"我点击了"}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UITextField *phoneTF = [alertView textFieldAtIndex:0];
    [phoneTF resignFirstResponder];
    //
    if (buttonIndex == 1) {
        if (phoneTF.text.length > 0) {
            self.waitBGV.hidden = NO;
            [self.waitAV startAnimating];
        }
    }
}

#pragma mark --------------获取用户手机信息------------------
- (void)loginTokenValidate {
    if (self.token.length <= 0) {
        [self showInfo:@{@"desc":@"当前token为空，请先进行一次登录操作"}];
        return;
    }
    
    //一键登录token
    NSString *loginTokenURL = @"https://www.cmpassport.com/unisdk/rsapi/loginTokenValidate";
    
    //版本号
    NSString *version = @"2.0";
    
    //strictcheck
    NSString *strictcheck = @"1";
    
    //appid
    NSString *appid = APPID;
    
    //appkey
    NSString *appkey = APPKEY;
    
    //systemtime
    NSString *systemtime = [self.class timestamp];
    
    //msgid
    NSString *msgid = [self.class uuid];
    
    //sign
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",appid,version,msgid,systemtime,strictcheck,self.token,appkey];
    sign = [self.class md5:sign];
    NSDictionary *loginTokenParams = @{@"token":self.token,
                                       @"strictcheck":strictcheck,
                                       @"version":version,
                                       @"msgid":msgid,
                                       @"appid":appid,
                                       @"systemtime":systemtime,
                                       @"sign":sign
                                       };
    __weak typeof(self)weakSelf = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginTokenURL]];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:loginTokenParams options:NSJSONWritingPrettyPrinted error:nil];
    
    self.waitBGV.hidden = NO;
    [self.waitAV startAnimating];
    [[NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            weakSelf.waitBGV.hidden = YES;
            [weakSelf.waitAV stopAnimating];
            self.token = @"";
            if (data.length > 0) {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSMutableDictionary *dataDict = [self.class covertToDic:dataString].mutableCopy;
            dataDict[@"result"] = [dataDict[@"resultCode"] isEqualToString:@"103000"] ? @"使用token登录成功" : @"使用token登录失败";
                
                if ([dataDict[@"resultCode"] isEqualToString:@"103000"]) {
                    self.phoneTextStr = dataDict[@"msisdn"];
                    [self.listCV reloadData];
                }
                [self showInfo:dataDict];
        }
        }];
            
        
    }] resume];
    
}

/**
 MD5加密

 @param src 加密字符串
 @return 加密结果
 */
+ (NSString *)md5:(NSString *)src {
    
    const char *source = [src UTF8String];
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5(source, (uint32_t)strlen(source), md5);
    
    NSMutableString *retString = [NSMutableString stringWithCapacity:40];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        NSString *strValue = [NSString stringWithFormat:@"%02X", md5[i]];
        if ([strValue length] == 0) {
            strValue = @"";
        }
        
        [retString appendString:strValue];
    }
    
    if ([retString length] == 0) {
        return @"";
    }
    
    return [retString lowercaseString];
    
}

/**
 系统当前日期，精确到毫秒，共17位
 */
+ (NSString *)timestamp {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *result = [formatter stringFromDate:now];
    
    return result;
}

+ (NSString *)uuid {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    
    return [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (NSDictionary *)covertToDic:(NSString *)str {
    if (![str isKindOfClass:[NSString class]]||str.length == 0) {
        return [NSDictionary dictionary];
    }
    
    NSError *error;
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        return [NSDictionary dictionary];
    }
    return dic;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.testItems.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.testItems[section][@"items"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self)weakSelf = self;
    NSString *typeCell = self.testItems[indexPath.section][@"items"][indexPath.item][@"type"];
    if ([typeCell isEqualToString:@"field"]) {
        OpenViewTextFieldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OpenViewTextFieldCell class]) forIndexPath:indexPath];
        cell.textFieldTitle.text = self.testItems[indexPath.section][@"items"][indexPath.item][@"label"];
        cell.textFieldBlock = ^(NSString *textFStr) {
            if (indexPath.section==2&&indexPath.item == 1) {
                self.phoneTextStr = textFStr;
            }
            if (indexPath.section==1&&indexPath.item == 0) {
                self.validateTime = textFStr;
            }
//            if (indexPath.item == 3) self.phoneTextStr = textFStr;
        };
    //防止cell重用
    cell.textField.placeholder = self.testItems[indexPath.section][@"items"][indexPath.item][@"title"];
        if (indexPath.section==2&&indexPath.item == 1) {
            cell.textField.text = self.phoneTextStr;
        }
        if (indexPath.section==1&&indexPath.item == 0) {
            cell.textField.text = self.validateTime;
        }
//    if (indexPath.item == 3)  cell.textField.text = self.phoneTextStr;
    return cell;
    
    
    }else if ([typeCell isEqualToString:@"switch"]){
        OpenViewSwtichCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OpenViewSwtichCell class]) forIndexPath:indexPath];
        cell.swtichLabel.text = self.testItems[indexPath.section][@"items"][indexPath.item][@"title"];
        if (indexPath.section==1 && indexPath.item == 5) {
            cell.swtich.on = self.isDimiss;
            cell.SwtichBlock = ^(BOOL on) {
                weakSelf.isDimiss = on;
            };
        }
        if (indexPath.section==1 && indexPath.item == 6) {
            cell.swtich.on = self.landscapeleft;
            cell.SwtichBlock = ^(BOOL on) {
                self.landscapeleft = on;
            };
        }
        if (indexPath.section==1 && indexPath.item == 7) {
            cell.swtich.on = self.SMSOn;
            cell.SwtichBlock = ^(BOOL on) {
                weakSelf.SMSOn = on;
            };
        }
        if (indexPath.section==1 && indexPath.item == 8) {
            cell.swtich.on = self.authWindow;
            cell.SwtichBlock = ^(BOOL on) {
                weakSelf.authWindow = on;
            };
        }
        if (indexPath.section==1 && indexPath.item == 9) {
            cell.swtich.on = self.edgeWindow;
            cell.SwtichBlock = ^(BOOL on) {
                weakSelf.edgeWindow = on;
            };
        }
        if (indexPath.section==1 && indexPath.item == 10) {
            cell.swtich.on = self.shouldAuthorVCStatusBarWhite;
            cell.SwtichBlock = ^(BOOL on) {
                weakSelf.shouldAuthorVCStatusBarWhite = on;
            };
        }
    
        return cell;
        
    }else{
        static NSString *const Identifier = @"Cell";
        OpenViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
        cell.titleV.layer.cornerRadius = 4.0;
        cell.titleV.layer.masksToBounds = YES;
        cell.titleV.layer.borderWidth = 1.0;
        cell.titleV.layer.borderColor = [[UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0] CGColor];
        cell.titleV.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        cell.titleV.text = self.testItems[indexPath.section][@"items"][indexPath.item][@"title"];
        return cell;
    
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        OpenViewHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        header.titleV.textColor = hexColor(0x2372b1);
        header.titleV.text = self.testItems[indexPath.section][@"title"];
        
        return header;
    }else {
        OpenViewFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        return footer;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    switch (indexPath.section) {
        case 0: //获取网络类型
        {
            [self showInfo:[UASDKLogin.shareLogin networkInfo]];
        }
            break;
        case 1: //客户端取号
        {
            switch (indexPath.item) {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    [self showImplicitLogin];
                    break;
                }
                case 2:
                {
                    [self getTokenExp];
                }
                    break;
                case 3:
                {
                    [self getTokenImp];
                }
                    break;
                case 4:
                {
                    [self deletePhoneScript];
                }
                    break;
                default:
                    break;
            }
            break;
        case 2: // 服务端校验
            {
                switch (indexPath.item) {
                    case 0:
                    {
                        [self loginTokenValidate];
                        break;
                    }
                    case 1:
                    {
                        break;
                    }
                    case 2:
                    {
                        [self checkPhoneNumber];
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            
        }
            break;
        default:
            break;
    }
}


#pragma mark --------------本机号码校验------------------

- (void)checkPhoneNumber {
    if (self.token.length == 0) {
        [self showInfo:@{@"desc":@"当前token为空，请先进行一次登录操作"}];
        return;
    }
    
    // 该url仅供测试模拟,正式接入时，请遵照文档要求
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://121.15.167.251:30030/UmcOpenPlatform/tokenValidate"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://121.15.167.251:30030/UmcOpenPlatform/tokenValidate"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    //     设置boby
    NSMutableDictionary *header = @{}.mutableCopy;
    header[@"version"] = @"1.0";
    NSString *msgid = [[self class] uuid];
    header[@"msgId"] = msgid;
    
    NSString *systemtime = [[self class] timestamp];
    header[@"timestamp"] = systemtime;
    header[@"appId"] = APPID;
    NSMutableDictionary *body = @{}.mutableCopy;
    body[@"token"] = self.token;
    body[@"openType"] = @"1";
    body[@"requesterType"] = @"0";
    
    NSString *phoneNum = [self.class SHA256WithSource:[NSString stringWithFormat:@"%@%@%@",self.phoneTextStr,APPKEY,systemtime]].uppercaseString;
    body[@"phoneNum"] = phoneNum;
    
    NSString *sortedSign = [NSString stringWithFormat:@"%@%@%@%@%@%@",APPID,msgid,phoneNum,systemtime,self.token,@"1.0"];
    NSString *sign =[self.class HMACSHA256:sortedSign withKey:APPKEY];
    body[@"sign"] = sign.uppercaseString;
    NSDictionary *httpBody = @{@"header":header,@"body":body};
    
    NSData *httpBodyData = [NSJSONSerialization dataWithJSONObject:httpBody options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = httpBodyData;
    request.timeoutInterval = 10;
    
    self.waitBGV.hidden = NO;
    [self.waitAV startAnimating];
    __weak typeof(self) weakSelf = self;
    
    [[NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.token = @"";
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[[self class] covertToDic:dataStr]];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.waitBGV.hidden = YES;
            [weakSelf.waitAV stopAnimating];
            if (error) {
                [self showInfo:@{@"code":@(error.code),@"desc":error.localizedDescription}];
            }else{
                [self showInfo:result];
            }
        });
    }] resume];
    
}

+ (NSString *)HMACSHA256:(NSString *)plaintext withKey:(NSString *)key {
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    for (int i = 0; i < HMACData.length; ++i){
        [HMAC appendFormat:@"%02x", buffer[i]];
    }
    
    return HMAC;
}

+ (NSString *)SHA256WithSource:(NSString *)src {
    
    const char *cSrc = [src UTF8String];
    NSMutableString *outPut = @"".mutableCopy;
    unsigned char sha256[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(cSrc, (CC_LONG)strlen(cSrc), sha256);
    for (int i=0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [outPut appendFormat:@"%02x",sha256[i]];
    }
    return outPut;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(width, 40.0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    if (section < 2) {
//        CGFloat width = [UIScreen mainScreen].bounds.size.width;
//        return CGSizeMake(width, 35.0);
//    }else {
//        return CGSizeZero;
//    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(width, 35.0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        CGFloat width = [UIScreen mainScreen].bounds.size.width;
//        return CGSizeMake(width, 5.0);
//    }else if (section == 1) {
//        CGFloat width = [UIScreen mainScreen].bounds.size.width;
//        return CGSizeMake(width, 20.0);
//    }else {
//        CGFloat width = [UIScreen mainScreen].bounds.size.width;
//        return CGSizeMake(width, 10.0);
//    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if (section == [self.testItems count] - 1) {
        return CGSizeMake(width, 15);
    }
    return CGSizeMake(width, 0);

}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark 键盘出现
//- (void)keyboardWillShow:(NSNotification *)note {
//    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    self.listCV.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - keyBoardRect.size.height);
//}
//#pragma mark 键盘消失
//-(void)keyboardWillHide:(NSNotification *)note
//{
//    self.listCV.frame = CGRectMake(0, 64 + 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 64);
//}

- (void)deletePhoneScript {
    
    if ([UASDKLogin.shareLogin delectScrip]) {
        [self showInfo:@{@"dec":@"删除成功"}];
    }else{
        [self showInfo:@{@"dec":@"没有缓存不用清除"}];
    }
    
}


@end
