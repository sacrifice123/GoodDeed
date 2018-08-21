//
//  GDHelper.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDHelper : NSObject

+ (CGSize)calculateRectWithFont:(CGFloat)textfont Withtext:(NSString*)text Withsize:(CGSize)size;
+ (void)showHud;
+ (void)hideHud;
+ (void)showHudWith:(NSString *)text;
+ (NSDictionary *)dictionaryFromModel:(NSObject *)model;
@end
