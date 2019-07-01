//
//  NSString+GDMD5.h
//  GoodDeed
//
//  Created by 张涛 on 2019/4/28.
//  Copyright © 2019年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GDMD5)
+ (NSString *) md5:(NSString *) str;
+ (NSString *) md5Hex:(NSString *) str;
//- (NSString *) sha1:(NSString *)input;
@end

NS_ASSUME_NONNULL_END
