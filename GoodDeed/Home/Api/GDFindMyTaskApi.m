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
    
    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
    return [NSString stringWithFormat:@"%@%@",@"/task/",model.uid];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

//- (id)requestArgument{
//    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
//    return @{
//             @"userId":model.uid?:@"",
////             @"page":@(_pageNum),//默认为0
////             @"size":@(_pageSize)//默认为10
//             };
//
//}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    
    NSDictionary *auth = [self authorizationInfoWithMethod:@"GET" urlPath:@"/task"];
    return auth;
}


@end
