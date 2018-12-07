//
//  GDClickCardButtonApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/12/4.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDClickCardButtonApi.h"

@implementation GDClickCardButtonApi
{
    NSString *_taskId;
}

- (instancetype)initWithTaskId:(NSString *)taskId{
    
    if (self = [super init]) {
        _taskId = taskId;
    }
    return self;
}

- (NSString *)requestUrl{
    
    return @"/clickButton";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
    return @{
             @"data":@{
                     @"taskId":_taskId?:@"",
                     @"uid":model.uid?:@""
                     },
             @"token":model.token?:@""
             };
}

@end
