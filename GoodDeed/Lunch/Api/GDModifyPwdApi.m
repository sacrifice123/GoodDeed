//
//  GDModifyPwdApi.m
//  GoodDeed
//
//  Created by 张涛 on 2018/10/14.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDModifyPwdApi.h"

@implementation GDModifyPwdApi
{
    NSString *_mail;
    NSString *_newPwd;
}

- (instancetype)initWithMail:(NSString *)mail newPwd:(NSString *)newPwd{
    
    if (self = [super init]) {
        _mail = mail;
        _newPwd = newPwd;
    }
    return self;
}

- (NSString *)requestUrl{
    
    return @"/user/modifyPwd";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    return @{
             @"data":@{
                     @"mail":_mail?:@"",
                     @"uid":@"",
                     @"newPwd":_newPwd?:@"",
                     },
             @"token":@""
             }; 
    
}

@end
