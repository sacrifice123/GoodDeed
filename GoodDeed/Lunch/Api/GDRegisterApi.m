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
    NSString *_userName;
    NSString *_password;
    
}

/*登录
 type: 1邮箱 2手机号 3微信 4新浪 5用户名
 */
- (instancetype)initWith:(NSString *)userName
                password:(NSString *)password
                   {
    if (self == [super init]) {
        _userName = userName;
        _password = password;
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
    NSDictionary *userView = @{//@"5cbc23564754240d520afcdf"
                               @"organizationId":[GDLunchManager sharedManager].userModel.organId?:@"",
                               @"password":_password?:@"",
                               @"username":_userName?:@""
                               };
    [dic setObject:userView forKey:@"userView"];
    
    return dic;
}

@end
