//
//  GDLunchManager.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDOrganModel;
@interface GDLunchManager : NSObject

@property (nonatomic, strong) NSArray *suveryList;
@property (nonatomic, strong) GDOrganModel *selectOrganModel;

+ (GDLunchManager *)sharedManager;
+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token completionBlock:(void(^)(BOOL))block;
+ (void)getFirstSurveyListWithCompletionBlock:(void(^)(NSArray *))block;
+ (void)getOrganListWithCompletionBlock:(void(^)(NSArray *))block;
+ (void)searchOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(NSArray *))block;
+ (void)addOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(BOOL))block;
+ (void)addOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(BOOL))block;
@end
