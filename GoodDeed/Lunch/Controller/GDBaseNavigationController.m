//
//  GDBaseNavigationController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/26.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseNavigationController.h"

@interface GDBaseNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation GDBaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBarHidden = YES;
    self.delegate            = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    if (navigationController.viewControllers.count == 1)
    {
        navigationController.interactivePopGestureRecognizer.enabled  = NO;
    }
}
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}
- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}


//#pragma mark -- UIGestureRecognizerDelegate
////触发之后是否响应手势事件
////处理侧滑返回与UISlider的拖动手势冲突
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    //如果手势是触摸的UISlider滑块触发的，侧滑返回手势就不响应
//    if ([touch.view isKindOfClass:[UISlider class]]) {
//        
//        return NO;
//    }
//    return YES;
//}

@end
