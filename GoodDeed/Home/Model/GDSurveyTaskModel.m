//
//  GDSurveyTaskModel.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/22.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSurveyTaskModel.h"

@implementation GDSurveyTaskModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{
             @"taskId":@"id",
             @"imgUrl":@"backgroundImageUrl",
             @"money":@"donation"
             };
}


- (BOOL)status{
    
    if (_taskStatus&&[_taskStatus isKindOfClass:[NSString class]]&&[_taskStatus isEqualToString:@"FINISHED"]) {
        return YES;
    }
    return NO;
}
@end
