//
//  GDEditBottomView.h
//  GoodDeed
//
//  Created by HK on 2018/8/15.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDEditBottomView : UIView

@property (copy, nonatomic) dispatch_block_t saveEvent;
@property (copy, nonatomic) dispatch_block_t nextEvent;
@property (copy, nonatomic) dispatch_block_t manageEvent;


+ (GDEditBottomView *)editBottomView;

@end
