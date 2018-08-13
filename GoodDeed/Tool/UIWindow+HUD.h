//
//  UIWindow+HUD.h
//  GoodDeed
//
//  Created by 张涛 on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (HUD)

- (void)showHudWithString:(NSString *)text;
- (void)showHudWithString:(NSString *)text forSeconds:(NSTimeInterval)seconds;
- (void)showString:(NSString *)text forSeconds:(NSTimeInterval)seconds;
- (void)hideHud;
- (void)hideHudAfterSeconds:(NSTimeInterval)interval;
- (void)showWithString:(NSString *)text;
@end
