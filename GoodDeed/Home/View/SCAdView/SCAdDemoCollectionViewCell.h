//
//  SCAdDemoCollectionViewCell.h
//  SCAdViewDemo
//
//  Created by 陈世翰 on 17/2/7.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDOperationDelegate.h"
@interface SCAdDemoCollectionViewCell : UICollectionViewCell<GDOperationDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end
