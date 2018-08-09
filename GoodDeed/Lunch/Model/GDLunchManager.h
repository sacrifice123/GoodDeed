//
//  GDLunchManager.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDLunchManager : NSObject
@property (nonatomic, strong)NSArray *suveryList;

+ (GDLunchManager *)sharedManager;
+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token completionBlock:(void(^)(BOOL))block;
+ (void)getFirstSurveyListWithCompletionBlock:(void(^)(NSArray *))block;
+ (void)getOrganListWithCompletionBlock:(void(^)(NSArray *))block;

@end
