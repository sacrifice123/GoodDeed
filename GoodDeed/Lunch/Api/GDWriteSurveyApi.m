//
//  GDWriteSurveyApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/11/1.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDWriteSurveyApi.h"

@implementation GDWriteSurveyApi



- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl{
    
    return  @"/survey/writeSurvey";
}

- (id)requestArgument{
    
    NSMutableArray *writeReqVoList = [NSMutableArray array];//;
    for (GDQuestionWriteModel *obj in [GDLunchManager sharedManager].writeReqVoList) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:obj.content forKey:@"content"];
        [dic setObject:@(obj.optionId.integerValue) forKey:@"optionId"];
        [dic setObject:@(obj.optionOrder.integerValue) forKey:@"optionOrder"];
        [dic setObject:@(obj.questionId.integerValue) forKey:@"questionId"];
        [dic setObject:@(obj.type) forKey:@"type"];
        [writeReqVoList addObject:dic];
    }
    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
    
    return @{
             @"data": @{
                         @"surveyId": [GDLunchManager sharedManager].surveyModel.surveyId?:@"",
                         @"uid": model.uid?:@"",
                         @"writeReqVoList": writeReqVoList
                     },
             @"token": model.token?:@""
             
             };
}

@end
