//
//  GDOrganModel.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDOrganModel.h"

@implementation GDOrganModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{
             @"organId":@"id",
             @"imgUrl":@"orgImageUrl",
             @"name":@"orgName"
             };
}

- (NSString *)imgUrl{
    
    return @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561438581729&di=fd8be8aa1c72c05d5e36aa27d83b10bb&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201410%2F15%2F20141015142052_aJUBr.png";
}

@end
