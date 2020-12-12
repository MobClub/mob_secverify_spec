//
//  OpenViewController.h
//  UMC
//
//  Created by LL on 16/5/26.
//  Copyright © 2016年 LL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenViewHeader : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleV;

@end

@interface OpenViewFooter : UICollectionReusableView

@end

@interface OpenViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleV;

@end

@interface OpenViewController : UIViewController

@end
