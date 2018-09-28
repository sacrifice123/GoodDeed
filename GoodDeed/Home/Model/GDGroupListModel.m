//
//  GDGroupListModel.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGroupListModel.h"

@implementation GDGroupListModel

//+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
//
//    return @{
//             @"groupId":@"id"
//             };
//}
//

- (NSString *)money{
    
    if (_money) {
        return [NSString stringWithFormat:@"%@",_money];
    }
    return @"0";
}
@end
