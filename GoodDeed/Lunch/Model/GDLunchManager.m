//
//  GDLunchManager.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLunchManager.h"
#import "GDLoginApi.h"
@implementation GDLunchManager

+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token block:(void(^)(BOOL))block{
    
    GDLoginApi *api = [[GDLoginApi alloc] initWith:mail password:password type:type token:token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
    } failure:^(YTKBaseRequest *request) {
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
    }];
    
}


@end
