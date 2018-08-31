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

@end
