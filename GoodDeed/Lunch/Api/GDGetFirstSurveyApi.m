//
//  GDGetFirstSurveyApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/8.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGetFirstSurveyApi.h"

@implementation GDGetFirstSurveyApi

- (NSString *)requestUrl{
    
    return @"/first/getFirstSurvey";
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
