//
//  GDHomeManager.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDGroupListModel.h"
#import "GDCardModel.h"
#import "GDSurveyTaskModel.h"

@interface GDHomeManager : NSObject

+ (MMDrawerController *)getRootMMDVc;
+ (void)showDrawer;
+ (void)closeDrawer;
+ (void)closeDrawerWithFull;
+ (void)POPAnimationExecutionWith:(UICollectionView *)collectionView;
+ (UIViewController *)getRootController:(BOOL)isLogin;
+ (void)presentToTargetControllerWith:(UIView *)view targetVc:(UIViewController *)targetVc;
+ (void)clearCache;
+ (void)getUserInfoWithCompletionBlock:(void(^)(BOOL))block;
+ (void)uploadImage:(UIImage *)image;
+ (void)createGroupWithHeadUrl:(NSString *)url uidName:(NSString *)uidName name:(NSString *)name completionBlock:(void(^)(GDGroupListModel *))block;
+ (void)getGroupInfoWithCompletionBlock:(void(^)(NSMutableArray *))block;
+ (void)getCardById:(NSString *)cardId completionBlock:(void(^)(GDCardModel *))block;
+ (void)getRegisterCardWithCompletionBlock:(void(^)(GDCardModel *))block;
+ (void)findMySurveyTaskWithCompletionBlock:(void(^)(GDSurveyTaskModel *))block;
+ (void)getSurveyListWithSurveyId:(NSString *)surveyId completionBlock:(void(^)(NSArray *))block;
+ (void)finishAnswerSurveyWithCompletionBlock:(void(^)(GDSurveyTaskModel *))block;

@end
