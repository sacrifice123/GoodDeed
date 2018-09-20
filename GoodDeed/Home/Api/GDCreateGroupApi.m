//
//  GDCreateGroupApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDCreateGroupApi.h"

@implementation GDCreateGroupApi
{
    NSString *_url;
    NSString *_uidName;
    NSString *_name;
}

- (id)initWithHeadUrl:(NSString *)url uidName:(NSString *)uidName name:(NSString *)name{
    if (self = [super init]) {
        _url = url;
        _uidName = uidName;
        _name = name;
    }
    return self;
}
- (NSString *)requestUrl{
    
    return @"/group/createGroup";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    return @{
             @"data":@{
                     @"headUrl":_url?:@"",
                     @"uid":[GDLunchManager sharedManager].userModel.uid?:@"",
                     @"uidName":_uidName?:@"",
                     @"name":_name?:@""
                     },
             @"token":[GDLunchManager sharedManager].userModel.token?:@""
             };
    
}

@end
