//
//  GDGetGroupInfoApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGetGroupInfoApi.h"

@implementation GDGetGroupInfoApi

- (NSString *)requestUrl{
    
    return @"/group/getGroupInfo";
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
