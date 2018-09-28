//
//  GDCreateGroupApi.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseApi.h"

@interface GDCreateGroupApi : GDBaseApi

- (id)initWithHeadUrl:(NSString *)url uidName:(NSString *)uidName name:(NSString *)name;

@end
