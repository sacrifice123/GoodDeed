//
//  GDChangeHeadApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDChangeHeadApi.h"

@implementation GDChangeHeadApi{
    NSString *_url;
}

- (id)initWithImageUrl:(NSString *)url {
    if (self = [super init]) {
        _url = url;
    }
    return self;
}
- (NSString *)requestUrl{
    
    return @"/user/changeHead";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    return @{
             @"data":@{
                     @"headUrl":_url?:@"",
                     @"uid":[GDLunchManager sharedManager].userModel.uid?:@""
                     },
             @"token":[GDLunchManager sharedManager].userModel.token?:@""
             };
    
}

@end
