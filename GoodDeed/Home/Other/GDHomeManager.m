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

#import <POP.h>
@implementation GDHomeManager

static CGFloat const GDAnimationDelay = 0.1;
static CGFloat const GDSpringFactor = 10;

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

+ (UIViewController *)getRootController:(BOOL)isLogin{
    
    if (isLogin) {
        return [self getHomeMainVC];
    }else{
        return [[UINavigationController alloc] initWithRootViewController:[GDLaunchViewController new]];
    }
}


+ (UIViewController *)getSuperVc:(UIView *)view{
    id object = view.nextResponder;
    while (object&&![object isKindOfClass:[UIViewController class]]) {
        object = [object nextResponder];
    }
    return object;
}

+ (void)presentToTargetControllerWith:(UIView *)view targetVc:(UIViewController *)targetVc{
    
    UIViewController *vc = [self getSuperVc:view];
    [vc presentViewController:targetVc animated:YES completion:nil];
}
@end
