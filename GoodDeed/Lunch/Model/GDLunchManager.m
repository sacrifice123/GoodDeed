//
//  GDLunchManager.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLunchManager.h"
#import "GDLoginApi.h"
#import "GDRegisterApi.h"
#import "GDGetFirstSurveyApi.h"
#import "GDGetOrganListApi.h"
#import "GDOrganModel.h"
#import "GDSearchOrganApi.h"
#import "GDAddOrganApi.h"
#import "GDQuestionBaseCell.h"
#import "GDForgetPwdApi.h"
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

- (NSMutableArray *)writeReqVoList{
    
    if (_writeReqVoList == nil) {
        _writeReqVoList = [[NSMutableArray alloc] init];
    }
    return _writeReqVoList;
}

- (GDOrganModel *)selectOrganModel{
    
    if (_selectOrganModel == nil) {
        _selectOrganModel = [[GDOrganModel alloc] init];
    }
    return _selectOrganModel;
}

- (GDUserModel *)userModel{
    
    if (_userModel == nil) {
        _userModel = [[GDUserModel alloc] init];
    }
    return _userModel;
    //return [[GDDataBaseManager sharedManager] query:@""];
}
/*注册
 type: 1邮箱 2手机号 3微信 4新浪 5用户名
 */
+ (void)registerWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type completionBlock:(void(^)(BOOL))block{
    
    GDRegisterApi *api = [[GDRegisterApi alloc] initWith:mail password:password type:type];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if (request.responseJSONObject&&[[request.responseJSONObject objectForKey:@"code"] integerValue] == 200) {
            [self loginWithMail:mail password:password type:type token:@"" isFirst:YES completionBlock:^(BOOL result) {
                block(result);
            }];
            
        }else{
            [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
        }

        
    } failure:^(YTKBaseRequest *request) {
        
        [GDWindow showWithString:@"网络异常"];
    }];
    
}

/*登录
 type: 1邮箱 2手机号 3微信 4新浪 5用户名
 */
+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token isFirst:(BOOL)isFirst completionBlock:(void(^)(BOOL))block{
    
    GDLoginApi *api = [[GDLoginApi alloc] initWith:mail password:password type:type token:token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if (request.responseJSONObject&&[[request.responseJSONObject objectForKey:@"code"] integerValue] == 200) {
            GDUserModel *model = [GDUserModel new];
            model.token = [request.responseJSONObject objectForKey:@"token"];
            model.nowTime = [[request.responseJSONObject objectForKey:@"data"] objectForKey:@"expireTime"];
            model.uid = [[request.responseJSONObject objectForKey:@"data"] objectForKey:@"uid"];
            [[GDDataBaseManager sharedManager] insert:model];
            [GDLunchManager sharedManager].userModel = model;//备用

            block(YES);
        }else{
            [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [GDWindow showWithString:@"网络异常"];
    }];

}



+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token completionBlock:(void(^)(BOOL))block{
    
    [self loginWithMail:mail password:password type:type token:token isFirst:NO completionBlock:^(BOOL result) {
        block(result);
    }];
}

+ (void)forgetWithMail:(NSString *)mail  completionBlock:(void(^)(BOOL))block{
    
    GDForgetPwdApi *api = [[GDForgetPwdApi alloc] initWithEmail:mail];
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
                surveyModel.firstQuestionList=[surveyModel.firstQuestionList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    
                    GDFirstQuestionListModel *model1 = (GDFirstQuestionListModel *)obj1;
                    GDFirstQuestionListModel *model2 = (GDFirstQuestionListModel *)obj2;
                    return model1.sort>model2.sort;
                }];
                for (int i=0; i<surveyModel.firstQuestionList.count; i++) {
                    GDFirstQuestionListModel *model = surveyModel.firstQuestionList[i];
                    model.sort = i+2;
                }
                [GDLunchManager sharedManager].surveyModel= surveyModel;
               // NSLog(@"%@",surveyModel.firstQuestionList);

            }else{
                [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
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
                   // NSLog(@"%@",organList);
                }
            }else{
               [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
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
                   // NSLog(@"%@",organList);
                }
            }else{
                 [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
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
                block(NO);
                [GDWindow showWithString:[jsonData objectForKey:@"message"]];
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
 获取cell size
 */
+ (CGSize)collectionView:(UICollectionView *)collectionView surveyModel:(GDFirstQuestionListModel *)model sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = 0.0;
    if (indexPath.section == 0) {//问题描述cell
        height = [GDHelper calculateRectWithFont:20 Withtext:model.questionName Withsize:CGSizeMake(SCREEN_WIDTH-150, MAXFLOAT)].height+90-((model.imgUrl&&[model.imgUrl isKindOfClass:[NSString class]]&&model.imgUrl.length>0)?30:0);
        
    }else{
        switch (model.type) {
            case 1:{
                GDOptionModel *option = model.firstOptionList[indexPath.row];
                height = [GDHelper calculateRectWithFont:20 Withtext:option.optionName Withsize:CGSizeMake(SCREEN_WIDTH-90, MAXFLOAT)].height+43;

            }
                
                break;
            case 2:{
                GDOptionModel *option = model.firstOptionList[indexPath.row];
                height = [GDHelper calculateRectWithFont:20 Withtext:option.optionName Withsize:CGSizeMake(SCREEN_WIDTH-150, MAXFLOAT)].height;
                height = (height>35?height:35)+20;
                
            }
                
                break;
            case 3:{
                height = 130;
            }
                
                break;
            case 4:{
                 height = 160;
            }
                
                break;
            case 5:{
                BOOL isHasHeader = (model.imgUrl&&[model.imgUrl isKindOfClass:[NSString class]]&&model.imgUrl.length>0);
                CGFloat sectionOneHeight = [GDHelper calculateRectWithFont:20 Withtext:model.questionName Withsize:CGSizeMake(SCREEN_WIDTH-150, MAXFLOAT)].height+90;
                CGFloat bottomSpace = SCREEN_HEIGHT-(isHasHeader?SCREEN_HEIGHT*0.52:0)-sectionOneHeight;
                 height = (44*model.firstOptionList.count+35)*2;
                 height = height<bottomSpace?bottomSpace:height;
            
            }
                
                break;
            case 6:{
                width = (SCREEN_WIDTH-24*3)*0.5;
                height = width;
            }
                
                break;
            case 7:{
                height = SCREEN_HEIGHT;
            }
                break;
            default:
                break;
        }
        
    }

    return CGSizeMake(width, height);
    
}

/*
 获取7大问题cell
 */
+ (GDQuestionBaseCell *)collectionView:(UICollectionView *)collectionView surveyType:(GDSurveyType)type cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GDQuestionBaseCell *cell;
    if (indexPath.section == 0) {//问题描述cell
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDQuestionDescCell" forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
    }else{//7大问题cell
        switch (type) {
            case 1:{//单选题
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDSingleSelCell" forIndexPath:indexPath];
                
            }
                
                break;
            case 2:{//多选题
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDMoreSelCell" forIndexPath:indexPath];
                
            }
                
                break;
            case 3:{//滑动题
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDSlideCell" forIndexPath:indexPath];
                
            }
                
                break;
            case 4:{//定量题
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDQuantifyCell" forIndexPath:indexPath];
                
            }
                
                break;
            case 5:{//排序题
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDSortCell" forIndexPath:indexPath];
            }
                
                break;
            case 6:{//勾选图片题
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDImageSelCell" forIndexPath:indexPath];
            }
                
                break;
            case 7:{//填写题
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDWriteCell" forIndexPath:indexPath];
            }
                break;
            default:{
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDQuestionBaseCell" forIndexPath:indexPath];
            }
                break;
        }
        
    }
    
    return cell;
    
}

- (void)finishAnswerWithModel:(GDFirstQuestionListModel *)model{
   
    switch (model.type) {
        case 1://单选题
        case 3://滑动题
        case 4://定量题
        case 6://勾选图片题
        case 7://填写题
        {
            for (GDQuestionWriteModel *obj in self.writeReqVoList) {
                if ([obj.questionId isEqualToString:model.writeModel.questionId]) {
                    obj.optionId = model.writeModel.optionId;
                    return;
                }
            }
            [self createWriteModel:model.writeModel optionId:model.writeModel.optionId];
        }
            
            break;
        case 2:{//多选题
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.writeReqVoList];
            for (GDQuestionWriteModel *obj in array) {
                if ([obj.questionId isEqualToString:model.writeModel.questionId]) {
                    obj.optionId = model.writeModel.optionId;
                    [self.writeReqVoList removeObject:obj];
                }
            }

            for (NSNumber *obj in model.writeModel.selectedArray) {
                if ([obj boolValue]) {
                    NSInteger index = [model.writeModel.selectedArray indexOfObject:obj];
                    GDOptionModel *option = model.firstOptionList[index];
                    [self createWriteModel:model.writeModel optionId:option.optionId];
                }
            }
        }
            
            break;
        case 5:{//排序题
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.writeReqVoList];
            for (GDQuestionWriteModel *obj in array) {
                if ([obj.questionId isEqualToString:model.writeModel.questionId]) {
                    obj.optionId = model.writeModel.optionId;
                    [self.writeReqVoList removeObject:obj];
                }
            }

            for (GDQuestionWriteModel *obj in model.writeModel.selectedArray) {
                [self.writeReqVoList addObject:obj];
            }
            
        }
            break;
        default:{
        }
            break;
    }
    
}

- (void)createWriteModel:(GDQuestionWriteModel *)model optionId:(NSString *)optionId{
    
    GDQuestionWriteModel *writeModel = [GDQuestionWriteModel new];
    writeModel.content = model.content;
    writeModel.optionId = optionId;
    writeModel.questionId = model.questionId;
    writeModel.type = model.type;
    writeModel.optionOrder = model.optionOrder;
    [self.writeReqVoList addObject:writeModel];

}
@end
