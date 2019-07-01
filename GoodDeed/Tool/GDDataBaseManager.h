//
//  GDDataBaseManager.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDSurveyModel.h"

@interface GDDataBaseManager : NSObject

+ (GDDataBaseManager *)sharedManager;
- (void)createDatabase;
- (void)insert:(GDUserModel *)model;
- (void)update:(GDUserModel *)model;
- (GDUserModel *)query:(NSString *)uid;
- (void)deleteData;
- (GDUserModel *)queryUserData;

//创建草稿问卷本地缓存
//+ (void)createSurveyTable;
+ (void)saveSurvey:(GDSurveyModel *)model;
+ (NSMutableArray *)survey_queryAll;
+ (GDSurveyModel *)survey_query:(NSString *)surveyId;
//+ (void)survey_delete:(NSString *)surveyId :(NSString *)questionId;
+ (void)survey_delete:(NSString *)surveyId;
@end
