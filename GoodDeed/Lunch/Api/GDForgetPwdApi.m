//
//  GDForgetPwdApi.m
//  GoodDeed
//
//  Created by 张涛 on 2018/10/14.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDForgetPwdApi.h"

@implementation GDForgetPwdApi
{
    NSString *_email;
}

- (instancetype)initWithEmail:(NSString *)email{
    
    if (self = [super init]) {
        _email = email;
    }
    return self;
}

- (NSString *)requestUrl{
    
    return @"/user/forgetPwd";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    return @{
             @"data":_email?:@"",
             @"token":@""
             };
    
}

@end
