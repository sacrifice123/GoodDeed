//
//  GDHelper.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDHelper.h"
#import <MBProgressHUD.h>

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

+ (CGSize)calculateRectWithFont:(CGFloat)textfont Withtext:(NSString*)text Withsize:(CGSize)size{
    NSDictionary*attr = @{NSFontAttributeName:[UIFont systemFontOfSize:textfont]};//用来计算label字体的
    CGRect titleRect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attr context:nil];
    
    return titleRect.size;
}

+ (void)showHud{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)hideHud{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
