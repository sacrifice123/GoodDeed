//
//  GDSurveyModel.m
//  GoodDeed
//
//  Created by 张涛 on 2019/5/11.
//  Copyright © 2019年 GoodDeed. All rights reserved.
//

#import "GDSurveyModel.h"

@implementation GDSurveyModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
   
    return @{
             @"surveyId":@"id",
             @"uid":@"creatorId"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{@"questions":[GDQuestionModel class]};
}


@end
