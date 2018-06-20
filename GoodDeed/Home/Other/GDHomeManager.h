//
//  GDHomeManager.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDHomeManager : NSObject

+ (void)POPAnimationExecutionWith:(UICollectionView *)collectionView;
+ (UIViewController *)getRootController:(BOOL)isLogin;

@end
