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

//计算label size
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

//model转化为字典
+ (NSDictionary *)dictionaryFromModel:(NSObject *)model {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([model class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [model valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
            
        }else if (value == nil) {
            //null
            [dic setObject:@"" forKey:name];//这行可以注释掉?????
            
        } else {
            //model
            [dic setObject:[self dictionaryFromModel:value] forKey:name];
        }
    }
    
    return [dic copy];
}

//获取view下的第一个控制器
+ (UIViewController *)getSuperVc:(UIView *)view{
    id object = view.nextResponder;
    while (object&&![object isKindOfClass:[UIViewController class]]) {
        object = [object nextResponder];
    }
    return object;
}

+ (UIView *)getTargetView:(Class)targetClass view:(UIView *)view{
    id object = view.nextResponder;
    while (object&&![object isKindOfClass:targetClass]) {
        object = [object nextResponder];
    }
    return object;
}

//获取当前时间戳  （以毫秒为单位）
+ (NSString *)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}

@end
