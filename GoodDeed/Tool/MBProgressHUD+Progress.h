//
//  MBProgressHUD+Progress.h
//  SaicModuleFunction
//
//  Created by yonyou on 2018/6/4.
//  Copyright © 2018年 shuaikun.cao. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Progress)

+ (void)showAutoHideMessage:(NSString *)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
//+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;//
+ (void)show:(NSString *)text image:(UIImage *)image view:(UIView *)view;
+ (MBProgressHUD *)showHUD;
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;
@end
