//
//  GDLoginApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLoginApi.h"

@implementation GDLoginApi
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
                   token:(NSString *)token{
    
    if (self = [super init]) {
        _mail = mail;
        _password = password;
        _type = type;
        _token = token;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl{
    
    return  @"/login/onLogin";
}

- (id)requestArgument{
    return @{
             @"data":@{
                        @"mail":_mail,
                        @"passwork":_password
        
                      },
             @"token":_token
             };
    
}
@end
