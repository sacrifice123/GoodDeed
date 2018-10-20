//
//  GDFindMyTaskApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDFindMyTaskApi.h"

@implementation GDFindMyTaskApi
- (NSString *)requestUrl{
    
    return @"/survey/findMyTask";
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
