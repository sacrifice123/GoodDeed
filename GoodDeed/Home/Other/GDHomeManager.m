//
//  GDHomeManager.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDHomeManager.h"
#import "GDHomeViewController.h"
#import "GDLeftViewController.h"
#import "GDLaunchViewController.h"
#import "GDLunchManager.h"
#import <POP.h>
@implementation GDHomeManager

static CGFloat const GDAnimationDelay = 0.1;
static CGFloat const GDSpringFactor = 10;


+ (MMDrawerController *)getRootMMDVc{
    MMDrawerController *mmdc = (MMDrawerController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    return mmdc;
}

+ (void)showDrawer{
    
    [[self getRootMMDVc] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

//抽屉直接退出
+ (void)closeDrawer{
    
    [[self getRootMMDVc] closeDrawerAnimated:YES completion:nil];
    
}

//抽屉推向全屏后退出
+ (void)closeDrawerWithFull{
    
    MMDrawerController *mmdc = [self getRootMMDVc];
    [mmdc setCenterViewController:mmdc.centerViewController withFullCloseAnimation:YES completion:nil];
    
}

//POP动画
+ (void)POPAnimationExecutionWith:(UICollectionView *)collectionView {
    
    NSMutableArray *items = [NSMutableArray arrayWithArray:collectionView.visibleCells];
    [items sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSIndexPath *idx1 = [collectionView indexPathForCell:obj1];
        NSIndexPath *idx2 = [collectionView indexPathForCell:obj2];
        return idx1>idx2;
        
    }];
    for (int i = 0; i<items.count; i++) {
        UICollectionViewCell *item = items[i];
        CGFloat itemEndX = item.x;
        CGFloat itemBeginX = itemEndX + 100;
        CGFloat itemEndY = item.y;
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(itemBeginX, itemEndY, item.width, item.width)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(itemEndX, itemEndY, item.width, item.width)];
        anim.springBounciness = GDSpringFactor*0.5;
        anim.springSpeed = GDSpringFactor*0.5;
        anim.beginTime = CACurrentMediaTime() + GDAnimationDelay *(items.count-i)*0.1;
        [item pop_addAnimation:anim forKey:nil];
    }

}

+ (MMDrawerController *)getHomeMainVC{
    
    GDHomeViewController *home = [[GDHomeViewController alloc] init];
    GDLeftViewController *leftVC = [[GDLeftViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:leftVC];
    MMDrawerController *mmdc = [[MMDrawerController alloc] initWithCenterViewController:homeNav leftDrawerViewController:leftNav];
    [mmdc setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmdc setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    return mmdc;

}

//isLogin:是否登录（登录状态直接跳到首页）
+ (UIViewController *)getRootController:(BOOL)isLogin{
    
    if (isLogin) {
        return [self getHomeMainVC];
    }else{
        return [[GDBaseNavigationController alloc] initWithRootViewController:[GDLaunchViewController new]];
    }
}


+ (void)presentToTargetControllerWith:(UIView *)view targetVc:(UIViewController *)targetVc{
    
    UIViewController *vc = [GDHelper getSuperVc:view];
    [vc presentViewController:targetVc animated:YES completion:nil];
}
@end
