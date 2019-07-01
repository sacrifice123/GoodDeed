//
//  GDFindSurveyApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/23.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDFindSurveyApi.h"

@implementation GDFindSurveyApi
{
    NSString *_surveyId;
}

- (instancetype)initWithSurveyId:(NSString *)surveyId{
    
    if (self = [super init]) {
        _surveyId = surveyId;
    }
    return self;
}

- (NSString *)requestUrl{
    
    return [NSString stringWithFormat:@"/survey/%@",_surveyId?:@""];;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    
    NSDictionary *auth = [self authorizationInfoWithMethod:@"GET" urlPath:@"/survey"];
    return auth;
}

//- (id)requestArgument{
//    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
//    return @{
//             @"data":@{
//                     @"surveyId":_surveyId?:@"",
//                     @"uid":model.uid?:@""
//                     },
//             @"token":model.token?:@""
//             };
//}

@end
