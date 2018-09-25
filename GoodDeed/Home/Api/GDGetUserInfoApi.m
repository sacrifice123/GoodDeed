//
//  GDGetUserInfoApi.m
//  GoodDeed
//
//  Created by 张涛 on 2018/9/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGetUserInfoApi.h"

@implementation GDGetUserInfoApi

- (NSString *)requestUrl{
    
    return @"/login/getUserInfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
    return @{
             @"data":@{
                     @"uid":model.uid?:@""
                     },
             @"token":model.token?:@""
             };
    
}
@end
