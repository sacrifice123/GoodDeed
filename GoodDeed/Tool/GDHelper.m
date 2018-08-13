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

//计算label字体的
+ (CGSize)calculateRectWithFont:(CGFloat)textfont Withtext:(NSString*)text Withsize:(CGSize)size{
    NSDictionary*attr = @{NSFontAttributeName:[UIFont systemFontOfSize:textfont]};
    CGRect titleRect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attr context:nil];
    
    return titleRect.size;
}

+ (void)showHud{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)showHudWith:(NSString *)text{
    [GDWindow showHudWithString:text];
}

+ (void)hideHud{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
