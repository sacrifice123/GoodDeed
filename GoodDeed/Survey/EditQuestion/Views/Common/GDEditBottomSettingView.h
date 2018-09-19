//
//  GDEditBottomSettingView.h
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDEditBottomSettingView : UIView

@property (copy, nonatomic) dispatch_block_t clickEvent;

+ (GDEditBottomSettingView *)editBottomSettingViewWithClickEvent:(dispatch_block_t)clickEvent;

@end
