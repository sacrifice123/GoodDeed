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

//问题列表
- (NSMutableArray *)suveryList{

    return self.surveyModel.questions;
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
 */
+ (void)registerWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(void (^)(BOOL))block {
    
    GDRegisterApi *api = [[GDRegisterApi alloc] initWith:userName password:password];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if (request.responseStatusCode == 200) {
            [self loginWithUserName:userName password:password completionBlock:^(BOOL result) {
                block(result);
            }];
            
        }else{
            //[GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
        }

        
    } failure:^(YTKBaseRequest *request) {
        
        [GDWindow showWithString:@"网络异常"];
    }];
    
}

/*登录
 */
+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password completionBlock:(void (^)(BOOL))block{
    
    GDLoginApi *api = [[GDLoginApi alloc] initWith:userName password:password];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSString *authStr = [request.responseHeaders objectForKey:@"WWW-Authenticate"];
        [[NSUserDefaults standardUserDefaults] setObject:authStr forKey:@"WWW-Authenticate"];

        if (request.responseStatusCode == 200) {
            
            GDUserModel *model = [GDUserModel yy_modelWithDictionary:request.responseJSONObject];
            [[GDDataBaseManager sharedManager] insert:model];
            [GDLunchManager sharedManager].userModel = model;//备用

            block(YES);
        }else{
            [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
        }
        
    } failure:^(YTKBaseRequest *request) {
        NSString *authStr = [request.responseHeaders objectForKey:@"WWW-Authenticate"];
        [[NSUserDefaults standardUserDefaults] setObject:authStr forKey:@"WWW-Authenticate"];
        [GDWindow showWithString:@"网络异常"];
    }];

}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//+ (void)loginWithMail:(NSString *)mail password:(NSString *)password type:(NSNumber *)type token:(NSString *)token completionBlock:(void(^)(BOOL))block{
//
//    [self loginWithUserName:mail password:password completionBlock:^(BOOL result) {
//        block(result);
//    }];
//}

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
            if (request.responseStatusCode == 200) {
                
                GDSurveyModel *surveyModel = [GDSurveyModel yy_modelWithDictionary:jsonData];
                //问题排序
                NSArray *questions = [surveyModel.questions sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

                    GDQuestionModel *model1 = (GDQuestionModel *)obj1;
                    GDQuestionModel *model2 = (GDQuestionModel *)obj2;
                    return model1.order.integerValue>model2.order.integerValue;
                }];
                [surveyModel.questions removeAllObjects];
                [surveyModel.questions addObjectsFromArray:questions];
                
                //选项排序
                for (GDQuestionModel *model in surveyModel.questions ) {
                    NSInteger index = [surveyModel.questions indexOfObject:model];
                    model.sort = (surveyModel.isHome?index+1:index+2);
                    NSArray *options = [model.options sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                        
                        GDOptionModel *model1 = (GDOptionModel *)obj1;
                        GDOptionModel *model2 = (GDOptionModel *)obj2;
                        return model1.order.integerValue>model2.order.integerValue;
                    }];
                    [model.options removeAllObjects];
                    [model.options addObjectsFromArray:options];
                }
                [GDLunchManager sharedManager].surveyModel = surveyModel;

            }else{
                [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
            }

        }
        block([GDLunchManager sharedManager].suveryList);

    } failure:^(YTKBaseRequest *request) {
        
//        NSString *authStr = [request.responseHeaders objectForKey:@"WWW-Authenticate"];
//        [[NSUserDefaults standardUserDefaults] setObject:authStr forKey:@"WWW-Authenticate"];
        block([GDLunchManager sharedManager].suveryList);
        [GDWindow showWithString:@"网络异常"];
    }];
    
}

+ (NSMutableArray *)dictionaryToArray:(NSDictionary *)dict{
    
    NSMutableArray *resultArr = [NSMutableArray array];
    if (dict&&[dict isKindOfClass:[NSDictionary class]]) {
        NSArray *array = [dict allKeys];
        array = [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
            return obj1.integerValue>obj2.integerValue;
        }];
        for (NSNumber *obj in array) {
            [resultArr addObject:[dict objectForKey:obj]];
        }

    }
    return resultArr;
}

/*
 获取公益组织列表
 */
+ (void)getOrganListWithCompletionBlock:(void(^)(NSArray *))block{
    
    GDGetOrganListApi *api = [[GDGetOrganListApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
       
        NSArray *jsonData = [request.responseJSONObject objectForKey:@"list"];
        if (jsonData&&[jsonData isKindOfClass:[NSArray class]]) {
            if (request.responseStatusCode == 200) {
                NSMutableArray *organList = [[NSMutableArray alloc] init];
                for (NSDictionary *obj in jsonData) {
                    GDOrganModel *model = [GDOrganModel yy_modelWithDictionary:obj];
                    [organList addObject:model];
                }
                block(organList);

            }else{
              // [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
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
+ (CGSize)collectionView:(UICollectionView *)collectionView surveyModel:(GDQuestionModel *)model sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = 0.0;
    if (indexPath.section == 0) {//问题描述cell
        height = [GDHelper calculateRectWithFont:20 Withtext:model.questionName Withsize:CGSizeMake(SCREEN_WIDTH-150, MAXFLOAT)].height+90-((model.backgroundImageUrl&&[model.backgroundImageUrl isKindOfClass:[NSString class]]&&model.backgroundImageUrl.length>0)?30:0);
        
    }else{
        switch (model.surveyType) {
            case 1:{
                GDOptionModel *option = model.options[indexPath.row];
                height = [GDHelper calculateRectWithFont:20 Withtext:option.optionName Withsize:CGSizeMake(SCREEN_WIDTH-90, MAXFLOAT)].height+43;

            }
                
                break;
            case 2:{
                GDOptionModel *option = model.options[indexPath.row];
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
                BOOL isHasHeader = (model.backgroundImageUrl&&[model.backgroundImageUrl isKindOfClass:[NSString class]]&&model.backgroundImageUrl.length>0);
                CGFloat sectionOneHeight = [GDHelper calculateRectWithFont:20 Withtext:model.questionName Withsize:CGSizeMake(SCREEN_WIDTH-150, MAXFLOAT)].height+90;
                CGFloat bottomSpace = SCREEN_HEIGHT-(isHasHeader?SCREEN_HEIGHT*0.52:0)-sectionOneHeight;
                 height = (44*model.options.count+35)*2;
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

- (void)finishAnswerWithModel:(GDQuestionModel *)model{
   
    switch (model.surveyType) {
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
                    GDOptionModel *option = model.options[index];
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
    writeModel.answerContent = model.answerContent;
    writeModel.optionId = optionId;
    writeModel.questionId = model.questionId;
    writeModel.type = model.type;
    writeModel.optionOrder = model.optionOrder;
    [self.writeReqVoList addObject:writeModel];

}
@end
