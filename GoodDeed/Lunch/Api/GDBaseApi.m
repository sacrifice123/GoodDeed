//
//  GDBaseApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseApi.h"

@implementation GDBaseApi

- (NSString *)baseUrl{
    
    return GDBaseUrl;
}


- (YTKRequestSerializerType)requestSerializerType{
    
    return YTKRequestSerializerTypeJSON;
}

@end
