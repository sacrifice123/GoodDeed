//
//  GDSearchOrganApi.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/11.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseApi.h"

@interface GDSearchOrganApi : GDBaseApi

- (instancetype)initWithOrganName:(NSString *)name uid:(NSString *)uid;
@end
