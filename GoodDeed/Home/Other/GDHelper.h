//
//  GDHelper.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDHelper : NSObject

+ (MMDrawerController *)getRootMMDVc;
+ (void)showDrawer;
+ (void)closeDrawer;
+ (void)closeDrawerWithFull;
@end
