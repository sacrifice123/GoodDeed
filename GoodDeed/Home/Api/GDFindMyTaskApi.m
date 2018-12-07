//
//  GDFindMyTaskApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDFindMyTaskApi.h"

@implementation GDFindMyTaskApi{
    
    NSInteger _pageNum;
    NSInteger _pageSize;
}

- (id)initWithPageNum:(NSInteger )pageNum pageSize:(NSInteger)pageSize{
    if (self = [super init]) {
        _pageNum = pageNum;
        _pageSize = pageSize;
    }
    return self;
}

- (NSString *)requestUrl{
    
    return @"/survey/findMyTaskOrCard";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
    return @{
             @"data":@{
                     @"uid":model.uid?:@"",
                     @"pageNum":@(_pageNum),
                     @"pageSize":@(_pageSize)
                     },
             @"token":model.token?:@""
             };
    
}

@end
