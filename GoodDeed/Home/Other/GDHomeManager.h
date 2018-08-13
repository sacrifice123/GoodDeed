//
//  GDHomeManager.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDHomeManager : NSObject

+ (MMDrawerController *)getRootMMDVc;
+ (void)showDrawer;
+ (void)closeDrawer;
+ (void)closeDrawerWithFull;
+ (void)POPAnimationExecutionWith:(UICollectionView *)collectionView;
+ (UIViewController *)getRootController:(BOOL)isLogin;
+ (UIViewController *)getSuperVc:(UIView *)view;
+ (void)presentToTargetControllerWith:(UIView *)view targetVc:(UIViewController *)targetVc;
@end
