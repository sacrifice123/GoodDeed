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
    
    return @"/organ/findOrgan";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    return @{
             @"data":@{
                     
                     },
             @"token":@""
             };
    
}

@end
