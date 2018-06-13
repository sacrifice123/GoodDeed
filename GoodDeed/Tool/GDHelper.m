//
//  GDHelper.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDHelper.h"

@implementation GDHelper

+ (MMDrawerController *)getRootMMDVc{
    MMDrawerController *mmdc = (MMDrawerController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    return mmdc;
}

+ (void)showDrawer{
    
    [[self getRootMMDVc] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

+ (void)closeDrawer{
    
    [[self getRootMMDVc] closeDrawerAnimated:YES completion:nil];

}

+ (void)closeDrawerWithFull{
    
    MMDrawerController *mmdc = [self getRootMMDVc];
    [mmdc setCenterViewController:mmdc.centerViewController withFullCloseAnimation:YES completion:nil];
    
}

@end
