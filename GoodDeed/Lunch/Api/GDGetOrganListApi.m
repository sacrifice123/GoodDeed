//
//  GDGetOrganListApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGetOrganListApi.h"

@implementation GDGetOrganListApi

- (NSString *)requestUrl{
    
    return @"/organ";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

//- (id)requestArgument{
//    return @{
//             @"data":@{
//
//                     },
//             @"token":@""
//             };
//
//}

@end
