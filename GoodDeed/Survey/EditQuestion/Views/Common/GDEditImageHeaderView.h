//
//  GDEditImageHeaderView.h
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDEditImageHeaderView : UIView

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) dispatch_block_t clickEvent;

+ (GDEditImageHeaderView *)editImageHeaderViewWithImage:(UIImage *)image clickEvent:(dispatch_block_t)clickEvent;

@end
