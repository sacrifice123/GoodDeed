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

@implementation GDLunchManager

static GDLunchManager *manager;
+ (GDLunchManager *)sharedManager {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        manager = [[GDLunchManager alloc] init];
        
    });
    
    return manager;
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
            block(nil);
        }else{
            [GDWindow showHudWithString:@"请求失败"];
        }
        
        
    } failure:^(YTKBaseRequest *request) {
        
        [GDWindow showHudWithString:@"网络异常"];
    }];
    
}
@end
