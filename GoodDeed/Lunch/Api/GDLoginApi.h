//
//  GDLoginApi.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseApi.h"

@interface GDLoginApi : GDBaseApi

- (instancetype)initWith:(NSString *)mail password:(NSString *)password;
@end
