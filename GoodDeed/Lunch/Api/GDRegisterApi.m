//
//  GDRegisterApi.m
//  GoodDeed
//
//  Created by 张涛 on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDRegisterApi.h"
#import "GDOrganModel.h"

@implementation GDRegisterApi
{
    NSString *_mail;
    NSString *_password;
    NSNumber *_type;
    NSString *_token;
    
}

/*登录
 type: 1邮箱 2手机号 3微信 4新浪 5用户名
 */
- (instancetype)initWith:(NSString *)mail
                password:(NSString *)password
                    type:(NSNumber *)type
                   {
    if (self == [super init]) {
        _mail = mail;
        _password = password;
        _type = type;
    }
    
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl{
    
    return  @"/login/register";
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
    GDUserModel *model = [[GDDataBaseManager sharedManager] query:GDOrgaUid];
    return @{
        @"data": @{
            @"mail": _mail?:@"",
            @"password":_password?:@"",
            @"resultReqVo": @{
                    @"organId": model.organId?:@"",
                    @"writeReqVo": @{
                            @"surveyId": [GDLunchManager sharedManager].surveyModel.surveyId?:@"",
                            @"uid": [GDLunchManager sharedManager].surveyModel.uid?:@"",
                            @"writeReqVoList": writeReqVoList
                 }
            },
            @"type": _type
        },
        @"token": @""
        
        };
}

@end
