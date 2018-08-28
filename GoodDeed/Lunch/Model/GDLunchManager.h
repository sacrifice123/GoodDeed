//
//  GDLunchManager.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDOrganModel;
@class GDFirstSurveyModel;
@class GDFirstQuestionListModel;
@interface GDLunchManager : NSObject

@property (nonatomic, strong) NSArray <GDFirstQuestionListModel *> *suveryList;
@property (nonatomic, strong) GDOrganModel *selectOrganModel;
@property (nonatomic, strong) GDFirstSurveyModel *surveyModel;

+ (GDLunchManager *)sharedManager;
+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token completionBlock:(void(^)(BOOL))block;
+ (void)getFirstSurveyListWithCompletionBlock:(void(^)(NSArray *))block;
+ (void)getOrganListWithCompletionBlock:(void(^)(NSArray *))block;
+ (void)searchOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(NSArray *))block;
+ (void)addOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(BOOL))block;
+ (GDQuestionBaseCell *)getQuestionReuseCellWith:(GDSurveyType)type collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
