//
//  GDFirstSurveyModel.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDFirstSurveyModel.h"

@implementation GDFirstSurveyModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{
             @"surveyId":@"id",
             @"firstQuestionList":@"questionRespVos"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{@"firstQuestionList":[GDQuestionModel class]};
}

- (NSMutableArray<GDQuestionModel *> *)firstQuestionList{
    
    if (_firstQuestionList == nil) {
        _firstQuestionList = [[NSMutableArray alloc] init];
    }
    return _firstQuestionList;
}

@end
