//
//  GDGetUserInfoApi.m
//  GoodDeed
//
//  Created by 张涛 on 2018/9/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGetUserInfoApi.h"

@implementation GDGetUserInfoApi
{
    NSString *_token;
    NSString *_uid;
}

- (instancetype)initWithUid:(NSString *)uid token:(NSString *)token {
    
    if (self = [super init]) {
        _token= token;
        _uid = uid;
    }
    return self;
}

- (NSString *)requestUrl{
    
    return @"/login/getUserInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    return @{
             @"data":@{
                     @"uid":_uid?:@"",
                     },
             @"token":_token?:@""
             };
    
}
@end
