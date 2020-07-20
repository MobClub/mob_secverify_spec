//
//  SVDSuccessViewController.m
//  SecVerifyDemo
//
//  Created by lujh on 2019/5/31.
//  Copyright © 2019 lujh. All rights reserved.
//

#import "SVDSuccessViewController.h"

@interface SVDSuccessViewController ()

@end

@implementation SVDSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubViews];
}

- (void)verifyAgain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)setupSubViews
{
    UIImageView *imageV = [[UIImageView alloc] init];
    
    imageV.bounds = CGRectMake(0, 0, 142.0 / 375 * SVD_ScreenWidth, 142.0 / 375 * SVD_ScreenWidth);
    imageV.center = CGPointMake(SVD_ScreenWidth / 2.0, 18.0 / 603 * (SVD_ScreenHeight - SVD_StatusBarSafeBottomMargin - 44 - SVD_TabbarSafeBottomMargin) + 142.0 / 375 * SVD_ScreenWidth / 2.0 + SVD_StatusBarSafeBottomMargin + 44);
    
    imageV.image = [UIImage imageNamed:@"success"];
    
    UILabel *successLabel = [[UILabel alloc] init];
    
    successLabel.bounds = CGRectMake(0, 0, SVD_ScreenWidth, 50.0);
    successLabel.center = CGPointMake(SVD_ScreenWidth / 2.0, 180.0 / 603 * (SVD_ScreenHeight - SVD_StatusBarSafeBottomMargin - 44 - SVD_TabbarSafeBottomMargin) + 25 + SVD_StatusBarSafeBottomMargin + 44);
    
    successLabel.text = @"验证成功";
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20.f]? : [UIFont systemFontOfSize:20.f];
    successLabel.textColor = [UIColor colorWithRed:47/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    
    phoneLabel.bounds = CGRectMake(0, 0, SVD_ScreenWidth, 50.0);
    phoneLabel.center = CGPointMake(SVD_ScreenWidth / 2.0, 240.0 / 603 * (SVD_ScreenHeight - SVD_StatusBarSafeBottomMargin - 44 - SVD_TabbarSafeBottomMargin) + 25 + SVD_StatusBarSafeBottomMargin + 44);
    
    if ([self.phone isKindOfClass:[NSString class]] && self.phone.length > 0)
    {
        phoneLabel.text = self.phone;
    }
    
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20.f]? : [UIFont systemFontOfSize:20.f];
    phoneLabel.textColor = [UIColor colorWithRed:47/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    
    UIButton *successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    successBtn.bounds = CGRectMake(0, 0, SVD_ScreenWidth - 40, 46.0);
    successBtn.center = CGPointMake(SVD_ScreenWidth / 2.0, 320.0 / 603 * (SVD_ScreenHeight - SVD_StatusBarSafeBottomMargin - 44 - SVD_TabbarSafeBottomMargin) + 23 + SVD_StatusBarSafeBottomMargin + 44);
    
    [successBtn setTitle:@"再次体验" forState:0];
    
    [successBtn addTarget:self action:@selector(verifyAgain) forControlEvents:UIControlEventTouchUpInside];
    
    [successBtn setBackgroundColor:[UIColor colorWithRed:254/255.0 green:122/255.0 blue:78/255.0 alpha:1/1.0]];

    
    [self.view addSubview:imageV];
    [self.view addSubview:successLabel];
    [self.view addSubview:phoneLabel];
    [self.view addSubview:successBtn];
}

@end
