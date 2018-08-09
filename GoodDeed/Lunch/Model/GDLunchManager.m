//
//  GDLunchManager.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLunchManager.h"
#import "GDLoginApi.h"
#import "GDGetFirstSurveyApi.h"
#import "GDFirstSurveyModel.h"
#import "GDGetOrganListApi.h"
#import "GDOrganModel.h"

@implementation GDLunchManager

static GDLunchManager *manager;
+ (GDLunchManager *)sharedManager {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        manager = [[GDLunchManager alloc] init];
        
    });
    
    return manager;
}

- (NSArray *)suveryList{
    if (_suveryList == nil) {
        _suveryList = [[NSArray alloc] init];
    }
    return _suveryList;
}

/*登录
 type: 1邮箱 2手机号 3微信 4新浪 5用户名
 */
+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token completionBlock:(void(^)(BOOL))block{
    
    GDLoginApi *api = [[GDLoginApi alloc] initWith:mail password:password type:type token:token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        
        
    } failure:^(YTKBaseRequest *request) {
        
        [GDWindow showHudWithString:@"网络异常"];
    }];
    
}


/*
 启动时获取首套问卷
 */
+ (void)getFirstSurveyListWithCompletionBlock:(void(^)(NSArray *))block{
    GDGetFirstSurveyApi *api = [[GDGetFirstSurveyApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[[jsonData objectForKey:@"code"] integerValue] == 200) {
            NSArray *list = [[jsonData objectForKey:@"data"] objectForKey:@"firstQuestionList"];
            if (list&&[list isKindOfClass:[NSArray class]]) {
                NSMutableArray *suveryList = [[NSMutableArray alloc] init];
                for (NSDictionary *obj in list) {
                    GDFirstQuestionListModel *model = [GDFirstQuestionListModel yy_modelWithDictionary:obj];
                    [suveryList addObject:model];
                }
                [GDLunchManager sharedManager].suveryList = suveryList;
                NSLog(@"%@",suveryList);
            }
        }else{
            [GDWindow showHudWithString:@"请求失败"];
        }
        
        block([GDLunchManager sharedManager].suveryList);
    } failure:^(YTKBaseRequest *request) {
        
        block([GDLunchManager sharedManager].suveryList);
        [GDWindow showHudWithString:@"网络异常"];
    }];
    
}

+ (void)getOrganListWithCompletionBlock:(void(^)(NSArray *))block{
    
    GDGetOrganListApi *api = [[GDGetOrganListApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
       
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[[jsonData objectForKey:@"code"] integerValue] == 200) {
            NSArray *list = [jsonData objectForKey:@"data"];
            if (list&&[list isKindOfClass:[NSArray class]]) {
                NSMutableArray *organList = [[NSMutableArray alloc] init];
                for (NSDictionary *obj in list) {
                    GDOrganModel *model = [GDOrganModel yy_modelWithDictionary:obj];
                    [organList addObject:model];
                }
                block(organList);
                NSLog(@"%@",organList);
            }
        }else{
            [GDWindow showHudWithString:@"请求失败"];
        }

        
    } failure:^(YTKBaseRequest *request) {
        
    }];
    
}

@end
