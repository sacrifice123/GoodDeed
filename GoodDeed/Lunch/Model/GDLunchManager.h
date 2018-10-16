//
//  GDLunchManager.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDFirstSurveyModel.h"
#import "GDUserModel.h"

@class GDOrganModel,GDFirstSurveyModel,GDFirstQuestionListModel,GDQuestionBaseCell,GDCardModel;
@interface GDLunchManager : NSObject

@property (nonatomic, strong) NSArray <GDFirstQuestionListModel *> *suveryList;
@property (nonatomic, strong) NSMutableArray *writeReqVoList;
@property (nonatomic, strong) GDOrganModel *selectOrganModel;
@property (nonatomic, strong) GDFirstSurveyModel *surveyModel;
@property (nonatomic, strong) GDUserModel *userModel;

+ (GDLunchManager *)sharedManager;
+ (void)registerWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type completionBlock:(void(^)(BOOL))block;
+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token completionBlock:(void(^)(BOOL))block;
+ (void)getFirstSurveyListWithCompletionBlock:(void(^)(NSArray *))block;
+ (void)getOrganListWithCompletionBlock:(void(^)(NSArray *))block;
+ (void)searchOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(NSArray *))block;
+ (void)addOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(BOOL))block;

+ (CGSize)collectionView:(UICollectionView *)collectionView surveyModel:(GDFirstQuestionListModel *)model sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
+ (GDQuestionBaseCell *)collectionView:(UICollectionView *)collectionView surveyType:(GDSurveyType)type cellForItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)finishAnswerWithModel:(GDFirstQuestionListModel *)model;
+ (void)forgetWithMail:(NSString *)mail  completionBlock:(void(^)(BOOL))block;
+ (void)getCardById:(NSString *)cardId completionBlock:(void(^)(GDCardModel *))block;
+ (void)getRegisterCardWithCompletionBlock:(void(^)(GDCardModel *))block;

@end
