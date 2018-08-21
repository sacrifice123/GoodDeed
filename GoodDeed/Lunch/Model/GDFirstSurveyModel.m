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
             @"surveyId":@"id"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{@"firstQuestionList":[GDFirstQuestionListModel class]};
}

- (NSArray<GDFirstQuestionListModel *> *)firstQuestionList{
    
    if (_firstQuestionList == nil) {
        _firstQuestionList = [[NSArray alloc] init];
    }
    return _firstQuestionList;
}

@end
