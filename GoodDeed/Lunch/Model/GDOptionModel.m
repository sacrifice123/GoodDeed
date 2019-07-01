//
//  GDOptionModel.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/12.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDOptionModel.h"

@implementation GDOptionModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{
             @"optionId":@"id"
             };
}

- (NSString *)optionId{
    
    return _order;
}

- (void)setOptionId:(NSString *)optionId{
    
    _order = optionId;
}
@end
