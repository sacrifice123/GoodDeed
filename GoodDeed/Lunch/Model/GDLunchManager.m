//
//  GDLunchManager.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLunchManager.h"
#import "GDLoginApi.h"
#import "GDGetFirstSurveyApi.h"
#import "GDGetOrganListApi.h"
#import "GDOrganModel.h"
#import "GDSearchOrganApi.h"
#import "GDAddOrganApi.h"
#import "GDQuestionBaseCell.h"
//七个问题cell
#import "GDSingleSelCell.h"
#import "GDMoreSelCell.h"
#import "GDSlideCell.h"
#import "GDSortCell.h"
#import "GDQuantifyCell.h"
#import "GDImageSelCell.h"
#import "GDWriteCell.h"

@implementation GDLunchManager

static GDLunchManager *manager;
+ (GDLunchManager *)sharedManager {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        manager = [[GDLunchManager alloc] init];
        
    });
    
    return manager;
}

- (NSArray *)suveryList{

    return self.surveyModel.firstQuestionList;
}

/*登录
 type: 1邮箱 2手机号 3微信 4新浪 5用户名
 */
+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token completionBlock:(void(^)(BOOL))block{
    
    GDLoginApi *api = [[GDLoginApi alloc] initWith:mail password:password type:type token:token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        
        
    } failure:^(YTKBaseRequest *request) {
        
        [GDWindow showWithString:@"网络异常"];
    }];
    
}


/*
 启动时获取首套问卷
 */
+ (void)getFirstSurveyListWithCompletionBlock:(void(^)(NSArray *))block{
    GDGetFirstSurveyApi *api = [[GDGetFirstSurveyApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[jsonData isKindOfClass:[NSDictionary class]]) {
            if ([[jsonData objectForKey:@"code"] integerValue] == 200&&[jsonData objectForKey:@"data"]) {
                
                GDFirstSurveyModel *surveyModel = [GDFirstSurveyModel yy_modelWithDictionary:[jsonData objectForKey:@"data"]];
                [GDLunchManager sharedManager].surveyModel= surveyModel;
                NSLog(@"%@",surveyModel.firstQuestionList);

            }else{
                [GDWindow showWithString:@"请求失败"];
            }

        }
        block([GDLunchManager sharedManager].suveryList);

    } failure:^(YTKBaseRequest *request) {
        
        block([GDLunchManager sharedManager].suveryList);
        [GDWindow showWithString:@"网络异常"];
    }];
    
}

/*
 获取公益组织列表
 */
+ (void)getOrganListWithCompletionBlock:(void(^)(NSArray *))block{
    
    GDGetOrganListApi *api = [[GDGetOrganListApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
       
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[jsonData isKindOfClass:[NSDictionary class]]) {
            if ([[jsonData objectForKey:@"code"] integerValue] == 200) {
                NSArray *list = [jsonData objectForKey:@"data"];
                if (list&&[list isKindOfClass:[NSArray class]]) {
                    NSMutableArray *organList = [[NSMutableArray alloc] init];
                    for (NSDictionary *obj in list) {
                        GDOrganModel *model = [GDOrganModel yy_modelWithDictionary:obj];
                        [organList addObject:model];
                    }
                    block(organList);
                    NSLog(@"%@",organList);
                }
            }else{
                [GDWindow showWithString:@"请求失败"];
            }

        }

        
    } failure:^(YTKBaseRequest *request) {
        
        [GDWindow showWithString:@"网络异常"];
    }];
    
}

/*
 根据名称搜索公益组织
 */
+ (void)searchOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(NSArray *))block{
    
    GDSearchOrganApi *api = [[GDSearchOrganApi alloc] initWithOrganName:name uid:uid];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[jsonData isKindOfClass:[NSDictionary class]]) {
            if ([[jsonData objectForKey:@"code"] integerValue] == 200) {
                NSArray *list = [jsonData objectForKey:@"data"];
                if (list&&[list isKindOfClass:[NSArray class]]) {
                    NSMutableArray *organList = [[NSMutableArray alloc] init];
                    for (NSDictionary *obj in list) {
                        GDOrganModel *model = [GDOrganModel yy_modelWithDictionary:obj];
                        [organList addObject:model];
                    }
                    block(organList);
                    NSLog(@"%@",organList);
                }
            }else{
                 [GDWindow showWithString:@"请求失败"];
            }

        }else{
            
          //  block(nil);
        }

        
    } failure:^(YTKBaseRequest *request) {
        [GDWindow showWithString:@"网络异常"];
    }];
}

/*
 添加公益组织
 */
+ (void)addOrganWithName:(NSString *)name uid:(NSString *)uid completionBlock:(void(^)(BOOL))block{
    
    GDAddOrganApi *api = [[GDAddOrganApi alloc] initWithOrganName:name uid:uid];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[jsonData isKindOfClass:[NSDictionary class]]) {
            if ([[jsonData objectForKey:@"code"] integerValue] == 200) {
                block(YES);

            }else{
                block(NO);;
            }
            
        }else{
            
            block(NO);
        }
        
    } failure:^(YTKBaseRequest *request) {
        block(NO);
        [GDWindow showWithString:@"网络异常"];
    }];

}

/*
 获取7大问题cell
 */
+ (GDQuestionBaseCell *)getQuestionReuseCellWith:(GDSurveyType)type collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    GDQuestionBaseCell *cell;
    if (indexPath.section == 0) {//问题描述cell
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDQuestionDescCell" forIndexPath:indexPath];
    }else{//7大问题cell
        switch (type) {
            case 1:{
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDSingleSelCell" forIndexPath:indexPath];
                
            }
                
                break;
            case 2:{
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDMoreSelCell" forIndexPath:indexPath];
                
            }
                
                break;
            case 3:{
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDSlideCell" forIndexPath:indexPath];
                
            }
                
                break;
            case 4:{
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDSortCell" forIndexPath:indexPath];
                
            }
                
                break;
            case 5:{
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDQuantifyCell" forIndexPath:indexPath];
            }
                
                break;
            case 6:{
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDImageSelCell" forIndexPath:indexPath];
            }
                
                break;
            case 7:{
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDWriteCell" forIndexPath:indexPath];
            }
                
            default:
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDQuestionBaseCell" forIndexPath:indexPath];
                break;
        }

    }
    return cell;

}
@end
