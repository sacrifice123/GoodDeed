//
//  GDLunchManager.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDSurveyModel.h"
#import "GDUserModel.h"

#import "GDSurveyModel.h"
@class GDOrganModel,GDQuestionBaseCell;
@interface GDLunchManager : NSObject

@property (nonatomic, strong) NSMutableArray <GDQuestionModel *> *suveryList;//问题列表，surveyModel里获取
@property (nonatomic, strong) NSMutableArray *writeReqVoList;
@property (nonatomic, strong) GDOrganModel *selectOrganModel;
@property (nonatomic, strong) GDSurveyModel *surveyModel;
@property (nonatomic, strong) GDUserModel *userModel;

+ (GDLunchManager *)sharedManager;
+ (void)registerWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(void(^)(BOOL))block;
+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(void(^)(BOOL))block;
+ (void)getFirstSurveyListWithCompletionBlock:(void(^)(NSArray *))block;
+ (void)getOrganListWithCompletionBlock:(void(^)(NSArray *))block;
+ (void)searchOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(NSArray *))block;
+ (void)addOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(BOOL))block;

+ (CGSize)collectionView:(UICollectionView *)collectionView surveyModel:(GDQuestionModel *)model sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
+ (GDQuestionBaseCell *)collectionView:(UICollectionView *)collectionView surveyType:(GDSurveyType)type cellForItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)finishAnswerWithModel:(GDQuestionModel *)model;
+ (void)forgetWithMail:(NSString *)mail  completionBlock:(void(^)(BOOL))block;

@end
