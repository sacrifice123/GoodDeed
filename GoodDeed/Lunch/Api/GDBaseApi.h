//
//  GDBaseApi.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "YTKRequest.h"
#import "NSString+GDMD5.h"

@interface GDBaseApi : YTKRequest

- (NSDictionary *)authorizationInfoWithMethod:(NSString *)method urlPath:(NSString *)path;
@end
