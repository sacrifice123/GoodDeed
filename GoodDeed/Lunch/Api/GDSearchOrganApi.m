//
//  GDSearchOrganApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/11.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSearchOrganApi.h"

@implementation GDSearchOrganApi
{
    NSString *_organName;
    NSString *_uid;
}

- (instancetype)initWithOrganName:(NSString *)name uid:(NSString *)uid{
    
    if (self = [super init]) {
        _organName = name;
        _uid = uid;
    }
    return self;
}

- (NSString *)requestUrl{
    
    return @"/organ/findOrganByName";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    return @{
             @"data":@{
                     @"organName":_organName,
                     @"uid":_uid
                     },
             @"token":@""
             };
    
}

@end
