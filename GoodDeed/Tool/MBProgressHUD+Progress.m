//
//  MBProgressHUD+Progress.m
//  SaicModuleFunction
//
//  Created by yonyou on 2018/6/4.
//  Copyright © 2018年 shuaikun.cao. All rights reserved.
//

#import "MBProgressHUD+Progress.h"

@implementation MBProgressHUD (Progress)
/**
 *  =======显示信息
 *  @param text 信息内容
 *  @param image 图片
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text image:(UIImage *)image view:(UIView *)view{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:17.0];
    hud.userInteractionEnabled= NO;
    if (image) {
        hud.customView = [[UIImageView alloc] initWithImage:image];//设置图片
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
    }else{
        hud.mode = MBProgressHUDModeText;
    }
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
}

+ (void)showAutoHideMessage:(NSString *)message toView:(UIView *)view
{
    [self show:message image:nil view:view];
}

/**
 *  =======显示 提示信息
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  =======显示
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    //[self show:success icon:@"success.png" view:view];
    [self show:success image:nil view:view];
}

/**
 *  =======显示错误信息
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
   // [self show:error icon:@"error.png" view:view];
    [self show:error image:nil view:view];
}
/**
 *  显示提示 + 菊花
 *  @param message 信息内容
 *  @return 直接返回一个MBProgressHUD， 需要手动关闭(  ?
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示菊花
 *  @return 直接返回一个MBProgressHUD， 需要手动关闭(  ?
 */
+ (MBProgressHUD *)showHUD
{
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    // 隐藏时候从父控件中移除
    hud.mode = MBProgressHUDModeDeterminate;
    hud.removeFromSuperViewOnHide = YES;
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    
    return hud;

}


/**
 *  显示一些信息
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
/**
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    
    [self hideHUDForView:view animated:YES];
}

/*{
    用法一：文字提示+菊花，延迟s后消失，再出现文字提示
    [MBProgressHUD showMessage:@"正在加载..."];
    
    int64_t delayInSeconds = 2.0;      // 延迟的时间
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败，请检查网络" toView:nil];
    });
    
    用法二：只提示文字，延迟s后消失
    

    [MBProgressHUD showError:@"登录失败" toView:nil];
    
    //[MBProgressHUD showSuccess:@"成功登录"];
}*/
@end
