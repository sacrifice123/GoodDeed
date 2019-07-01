//
//  GDGetRegisterCardApi.m
//  GoodDeed
//
//  Created by 张涛 on 2018/10/16.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGetRegisterCardApi.h"

@implementation GDGetRegisterCardApi

- (NSString *)requestUrl{
    
    return @"/card/homePageCard";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    
    return [self authorizationInfoWithMethod:@"GET" urlPath:@"/card/homePageCard"];
}
@end
