//
//  GDRegisterApi.h
//  GoodDeed
//
//  Created by 张涛 on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseApi.h"

@interface GDRegisterApi : GDBaseApi

- (instancetype)initWith:(NSString *)mail
                password:(NSString *)password
                    type:(NSNumber *)type;
@end
