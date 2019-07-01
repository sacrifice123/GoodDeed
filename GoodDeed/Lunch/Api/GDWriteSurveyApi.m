//
//  GDWriteSurveyApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/11/1.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDWriteSurveyApi.h"

@implementation GDWriteSurveyApi
{
    NSString *_surveyId;
}

- (instancetype)initWithSurveyId:(NSString *)surveyId{
    if (self == [super init]) {
        _surveyId = surveyId;
    }
    return self;
}



- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPut;
}

- (NSString *)requestUrl{
    
    return  [NSString stringWithFormat:@"%@%@",@"/survey/answerSurvey/",_surveyId];
}

//- (id)requestArgument{
//
//    NSMutableArray *writeReqVoList = [NSMutableArray array];//;
//    for (GDQuestionWriteModel *obj in [GDLunchManager sharedManager].writeReqVoList) {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic setObject:obj.content forKey:@"content"];
//        [dic setObject:@(obj.optionId.integerValue) forKey:@"optionId"];
//        [dic setObject:@(obj.optionOrder.integerValue) forKey:@"optionOrder"];
//        [dic setObject:@(obj.questionId.integerValue) forKey:@"questionId"];
//        [dic setObject:@(obj.type) forKey:@"type"];
//        [writeReqVoList addObject:dic];
//    }
//    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
//
//    return @{
//             @"data": @{
//                         @"surveyId": [GDLunchManager sharedManager].surveyModel.surveyId?:@"",
//                         @"uid": model.uid?:@"",
//                         @"writeReqVoList": writeReqVoList
//                     },
//             @"token": model.token?:@""
//
//             };
//}

- (id)requestArgument{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *resultViews = [[NSMutableArray alloc] init];
    for (GDQuestionModel *model in [GDLunchManager sharedManager].suveryList) {
        NSMutableDictionary *obj = [NSMutableDictionary dictionary];
        [obj setObject:model.writeModel.answerContent?:@"" forKey:@"answerContent"];
        if (model.writeModel.optionOrderAndSortMap) {
            [obj setObject:model.writeModel.optionOrderAndSortMap forKey:@"optionOrderAndSortMap"];
        }
        if (model.writeModel.optionOrders) {
            [obj setObject:model.writeModel.optionOrders forKey:@"optionOrders"];
        }
        [obj setObject:model.writeModel.questionOrder?:@"" forKey:@"questionOrder"];
        [resultViews addObject:obj];
    }
    [dic setObject:resultViews forKey:@"resultViews"];
    return dic;

}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    
    return [self authorizationInfoWithMethod:@"PUT" urlPath:@"/survey/answerSurvey/"];
}

@end
