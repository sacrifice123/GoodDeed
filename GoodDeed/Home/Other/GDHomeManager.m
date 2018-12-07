//
//  GDHomeManager.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDHomeManager.h"
#import "GDHomeViewController.h"
#import "GDLeftViewController.h"
#import "GDLaunchViewController.h"
#import "GDGetUserInfoApi.h"
#import "GDUserModel.h"
#import "GDUploadImageApi.h"
#import "GDChangeHeadApi.h"
#import "GDCreateGroupApi.h"
#import "GDGetGroupInfoApi.h"
#import <POP.h>
#import "GDGetRegisterCardApi.h"
#import "GDGetCardByIdApi.h"
#import "GDFindMyTaskApi.h"
#import "GDSurveyTaskModel.h"
#import "GDFindSurveyApi.h"
#import "GDWriteSurveyApi.h"
#import "GDClickCardButtonApi.h"

@implementation GDHomeManager

static CGFloat const GDAnimationDelay = 0.1;
static CGFloat const GDSpringFactor = 10;


+ (MMDrawerController *)getRootMMDVc{
    MMDrawerController *mmdc = (MMDrawerController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    return mmdc;
}

+ (void)showDrawer{
    
    [[self getRootMMDVc] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

//抽屉直接退出
+ (void)closeDrawer{
    
    [[self getRootMMDVc] closeDrawerAnimated:YES completion:nil];
    
}

//抽屉推向全屏后退出
+ (void)closeDrawerWithFull{
    
    MMDrawerController *mmdc = [self getRootMMDVc];
    [mmdc setCenterViewController:mmdc.centerViewController withFullCloseAnimation:YES completion:nil];
    
}

//POP动画
+ (void)POPAnimationExecutionWith:(UICollectionView *)collectionView {
    
    NSMutableArray *items = [NSMutableArray arrayWithArray:collectionView.visibleCells];
    [items sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSIndexPath *idx1 = [collectionView indexPathForCell:obj1];
        NSIndexPath *idx2 = [collectionView indexPathForCell:obj2];
        return idx1>idx2;
        
    }];
    for (int i = 0; i<items.count; i++) {
        UICollectionViewCell *item = items[i];
        CGFloat itemEndX = item.x;
        CGFloat itemBeginX = itemEndX + 100;
        CGFloat itemEndY = item.y;
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(itemBeginX, itemEndY, item.width, item.width)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(itemEndX, itemEndY, item.width, item.width)];
        anim.springBounciness = GDSpringFactor*0.5;
        anim.springSpeed = GDSpringFactor*0.5;
        anim.beginTime = CACurrentMediaTime() + GDAnimationDelay *(items.count-i)*0.1;
        [item pop_addAnimation:anim forKey:nil];
    }

}

+ (MMDrawerController *)getHomeMainVC{
    
    GDHomeViewController *home = [[GDHomeViewController alloc] init];
    GDLeftViewController *leftVC = [[GDLeftViewController alloc] init];
    GDBaseNavigationController *homeNav = [[GDBaseNavigationController alloc] initWithRootViewController:home];
    GDBaseNavigationController *leftNav = [[GDBaseNavigationController alloc] initWithRootViewController:leftVC];
    MMDrawerController *mmdc = [[MMDrawerController alloc] initWithCenterViewController:homeNav leftDrawerViewController:leftNav];
    [mmdc setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmdc setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    return mmdc;

}

//isLogin:是否登录（登录状态直接跳到首页）
+ (UIViewController *)getRootController:(BOOL)isLogin{
    
    if (isLogin) {
        return [self getHomeMainVC];
    }else{
        return [[GDBaseNavigationController alloc] initWithRootViewController:[GDLaunchViewController new]];
    }
}

//获取用户信息
+ (void)getUserInfoWithCompletionBlock:(void(^)(BOOL))block{
    
    GDGetUserInfoApi *api = [[GDGetUserInfoApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if (request.responseJSONObject&&[[request.responseJSONObject objectForKey:@"code"] integerValue] == 200) {
            NSDictionary *data = [request.responseJSONObject objectForKey:@"data"];
            if (data) {
                [GDLunchManager sharedManager].userModel.headPortrait = [data objectForKey:@"headPortrait"];
                [GDLunchManager sharedManager].userModel.money = [data objectForKey:@"money"];
                BOOL isCreatedGroup = [[data objectForKey:@"isCreatedGroup"] boolValue];
                [GDLunchManager sharedManager].userModel.isCreatedGroup = isCreatedGroup;
                [GDLunchManager sharedManager].userModel.mySurveyNum = [data objectForKey:@"mySurveyNum"];
                [GDLunchManager sharedManager].userModel.uid = [data objectForKey:@"uid"];
                NSDictionary *dic = [data objectForKey:@"organizationRespVo"];
                if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
                    [GDLunchManager sharedManager].userModel.organId = [dic objectForKey:@"id"];
                    [GDLunchManager sharedManager].userModel.imgUrl = [dic objectForKey:@"imgUrl"];
                    [GDLunchManager sharedManager].userModel.name = [dic objectForKey:@"name"];
                }
                if (isCreatedGroup) {
                    
                }
                block(YES);
            }
        }else{
            [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
            
        }
        
    } failure:^(YTKBaseRequest *request) {
        [GDWindow showWithString:@"网络异常"];
    }];
}

//上传图片
+ (void)uploadImage:(UIImage *)image {

    GDUploadImageApi *api = [[GDUploadImageApi alloc] initWithImage:image];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {

     [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
        
    } failure:^(YTKBaseRequest *request) {
        
        [GDWindow showWithString:@"网络异常"];
    }];
}
//-(void)uploadImage22:(UIImage *)image{
//
//    //请求地址
//    NSMutableString *url = [[NSMutableString alloc] init];
//    [url appendString:GDBaseUrl];
//    [url appendString:@"/image/uploadImage"];
//
//    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
//    //分界线 --AaB03x
//    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
//    //结束符 AaB03x--
//    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
//
//    NSMutableString *body = [[NSMutableString alloc] init];
//
//
//    [body appendFormat:@"%@\r\n",MPboundary];
//
//    　　//请求参数
//   // [body appendFormat:@"Content-Disposition: form-data;name=\"%@\"\r\n\r\n",@"token"];
//
//    　　//参数值
//    //[body appendFormat:@"%@\r\n", [UtilTool getToken]];
//
//    NSData *imageData = UIImagePNGRepresentation(image);
//    //声明myRequestData，用来放入http body
//    NSMutableData *myRequestData;
//    //将body字符串转化为UTF8格式的二进制
//    myRequestData=[NSMutableData data];
//
//
//    [body appendFormat:@"%@\r\n",MPboundary];
//    [body appendFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"%@\"\r\n",@"temp.png"];
//    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
//    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [myRequestData appendData:imageData];
//
//    //声明结束符：--AaB03x--
//    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
//    //加入结束符--AaB03x--
//    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:url]];
//    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    //    [request setTimeoutInterval:[DataStore getHttpTimeout]];
//    [request setHTTPMethod:@"POST"];
//    //设置HTTPHeader中Content-Type的值
//    NSString *cttype=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
//    //设置HTTPHeader
//    [request setValue:cttype forHTTPHeaderField:@"Content-Type"];
//    //设置Content-Length
//    [request setValue:[NSString stringWithFormat:@"%ld", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody:myRequestData];
//    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error: nil];
//}

//创建团队
+ (void)createGroupWithHeadUrl:(NSString *)url uidName:(NSString *)uidName name:(NSString *)name completionBlock:(void(^)(GDGroupListModel *))block{
    
    [GDWindow showHudWithString:@""];
    GDCreateGroupApi *api = [[GDCreateGroupApi alloc] initWithHeadUrl:url uidName:uidName name:name];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [GDWindow hideHud];
        if ([[request.responseJSONObject objectForKey:@"code"] integerValue]==200) {
            NSDictionary *data = [request.responseJSONObject objectForKey:@"data"];
            if (data&&[data isKindOfClass:[NSDictionary class]]) {
                [GDLunchManager sharedManager].userModel.isCreatedGroup = YES;;
                NSArray *memberList = [data objectForKey:@"memberList"];
                NSDictionary *dic = memberList.firstObject;
                GDGroupListModel *model = [[GDGroupListModel alloc] init];
                model.groupId = [data objectForKey:@"id"];
                model.name = [data objectForKey:@"name"];
                if ((dic&&[dic isKindOfClass:[NSDictionary class]])) {
                    model.imgUrl = [dic objectForKey:@"imgUrl"];
                    model.money = [dic objectForKey:@"money"];
                    model.uid = [dic objectForKey:@"uid"];
                    model.uidName = [dic objectForKey:@"uidName"];

                }
                block(model);
            }
       
        }else{
//            [GDWindow showWithString:[request.responseJSONObject objectForKey:@"message"]];
            [GDWindow showWithString:@"请求失败"];

        }
        
    } failure:^(YTKBaseRequest *request) {
        [GDWindow showWithString:@"网络异常"];
        [GDWindow hideHud];
    }];
}


//更换头像
+ (void)changeHeadImage:(NSString *)url{
    
    GDChangeHeadApi*api = [[GDChangeHeadApi alloc] initWithImageUrl:url];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        
    } failure:^(YTKBaseRequest *request) {
        [GDWindow showWithString:@"网络异常"];
    }];
}

+ (void)getGroupInfoWithCompletionBlock:(void(^)(NSMutableArray *))block{
    
    GDGetGroupInfoApi*api = [[GDGetGroupInfoApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if ([[request.responseJSONObject objectForKey:@"code"] integerValue]==200) {
            NSDictionary *data = [request.responseJSONObject objectForKey:@"data"];
            if (data&&[data isKindOfClass:[NSDictionary class]]) {
                NSMutableArray *array = [NSMutableArray array];
               
                NSDictionary *myCreateGroup = [data objectForKey:@"myCreateGroup"];
                if (myCreateGroup&&[myCreateGroup isKindOfClass:[NSDictionary class]]) {
                    NSArray *createList = [myCreateGroup objectForKey:@"memberList"];
                    if (createList&&[createList isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *obj in createList) {
                            GDGroupListModel *model = [[GDGroupListModel alloc] init];
                            model.groupId = [myCreateGroup objectForKey:@"id"];
                            model.name = [myCreateGroup objectForKey:@"name"];
                            model.imgUrl = [obj objectForKey:@"imgUrl"];
                            model.money = [obj objectForKey:@"money"];
                            model.uid = [obj objectForKey:@"uid"];
                            model.uidName = [obj objectForKey:@"uidName"];
                            [array addObject:model];
                        }
                    }
                }
                
                NSDictionary *myJoinGList = [data objectForKey:@"myJoinGList"];
                if (myJoinGList&&[myJoinGList isKindOfClass:[NSDictionary class]]) {
                    NSArray *joinList = [myJoinGList objectForKey:@"memberList"];
                    if (joinList&&[joinList isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *obj in joinList) {
                            GDGroupListModel *model = [[GDGroupListModel alloc] init];
                            model.groupId = [myCreateGroup objectForKey:@"id"];
                            model.imgUrl = [obj objectForKey:@"imgUrl"];
                            model.money = [obj objectForKey:@"money"];
                            model.uid = [obj objectForKey:@"uid"];
                            model.uidName = [obj objectForKey:@"uidName"];
                            [array addObject:model];
                        }

                    }
               
                }

                block(array);
            }
        }
        
    } failure:^(YTKBaseRequest *request) {
        [GDWindow showWithString:@"网络异常"];
    }];

    
}

//根据cardId获取card
+ (void)getCardById:(NSString *)cardId completionBlock:(void(^)(GDCardModel *))block{

    GDGetCardByIdApi *api = [[GDGetCardByIdApi alloc] initWithCardId:cardId];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[jsonData isKindOfClass:[NSDictionary class]]) {
            if ([[jsonData objectForKey:@"code"] integerValue] == 200) {
                
                NSDictionary *dic = [jsonData objectForKey:@"data"];
                if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
                    GDCardModel *model = [GDCardModel yy_modelWithDictionary:dic];
                    block(model);
                }
            }else{
                block(nil);
                [GDWindow showWithString:[jsonData objectForKey:@"message"]];
            }
            
        }else{
            
        }
    } failure:^(YTKBaseRequest *request) {
        block(nil);
        [GDWindow showWithString:@"网络异常"];
    }];
    
}

//获取注册后的card（不针对用户，每个用户一样的）
+ (void)getRegisterCardWithCompletionBlock:(void(^)(GDCardModel *))block{
    
    GDGetRegisterCardApi *api = [[GDGetRegisterCardApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[jsonData isKindOfClass:[NSDictionary class]]) {
            if ([[jsonData objectForKey:@"code"] integerValue] == 200) {
                
                NSDictionary *dic = [jsonData objectForKey:@"data"];
                if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
                    GDCardModel *model = [GDCardModel yy_modelWithDictionary:dic];
                    block(model);
                }
                
            }else{
                [GDWindow showWithString:[jsonData objectForKey:@"message"]];
            }
            
        }else{
            
        }
    } failure:^(YTKBaseRequest *request) {
        [GDWindow showWithString:@"网络异常"];
    }];
    
}

//查询我是否有可回答的问卷
+ (void)findMySurveyTaskWithCompletionBlock:(void(^)(NSArray *))block{
 
    GDFindMyTaskApi *api = [[GDFindMyTaskApi alloc] initWithPageNum:1 pageSize:10];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[jsonData isKindOfClass:[NSDictionary class]]) {
            if ([[jsonData objectForKey:@"code"] integerValue] == 200) {
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                NSArray *data = [jsonData objectForKey:@"data"];
                if (data&&[data isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *obj in data) {
                        
                        GDHomeModel *homeModel = [[GDHomeModel alloc] init];
                        homeModel.isHasSurvery = YES;
                        if ([[obj objectForKey:@"card"] boolValue]) {//card
                            NSDictionary *dic = [obj objectForKey:@"cardRespVo"];
                            GDCardModel *model = [GDCardModel yy_modelWithDictionary:dic];
                            homeModel.cardModel = model;
                            homeModel.type = GDHomeCardType;
                            homeModel.cardModel.isHome = YES;
                        }else{
                            NSDictionary *dic = [obj objectForKey:@"taskRespVo"];
                            GDSurveyTaskModel *model = [GDSurveyTaskModel yy_modelWithDictionary:dic];
                            homeModel.taskModel = model;
                            homeModel.type = GDHomeSuveryStatusType;
                        }
                        [array addObject:homeModel];

                    }
                    block(array);
                    
                }
         
            }else{

                [GDWindow showWithString:[jsonData objectForKey:@"message"]];
                block(nil);
            }

        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [GDWindow showWithString:@"网络异常"];
        block(nil);
    }];
    
}

//根据surveryId查询问卷
+ (void)getSurveyListWithSurveyId:(NSString *)surveyId completionBlock:(void(^)(NSArray *))block{
    
    GDFindSurveyApi *api = [[GDFindSurveyApi alloc] initWithSurveyId:(NSString *)surveyId];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *jsonData = request.responseJSONObject;
        if (jsonData&&[jsonData isKindOfClass:[NSDictionary class]]) {
            if ([[jsonData objectForKey:@"code"] integerValue] == 200&&[jsonData objectForKey:@"data"]) {
                
                GDFirstSurveyModel *surveyModel = [GDFirstSurveyModel yy_modelWithDictionary:[jsonData objectForKey:@"data"]];
                surveyModel.isHome = YES;
                surveyModel.surveyId = surveyId;
                NSArray *list = [surveyModel.firstQuestionList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    
                    GDFirstQuestionListModel *model1 = (GDFirstQuestionListModel *)obj1;
                    GDFirstQuestionListModel *model2 = (GDFirstQuestionListModel *)obj2;
                    return model1.sort>model2.sort;
                }];
                [surveyModel.firstQuestionList removeAllObjects];
                [surveyModel.firstQuestionList addObjectsFromArray:list];
                for (int i=0; i<surveyModel.firstQuestionList.count; i++) {
                    GDFirstQuestionListModel *model = surveyModel.firstQuestionList[i];
                    model.sort = i+1;
                }
                [GDLunchManager sharedManager].surveyModel= surveyModel;
                 NSLog(@"home==%@",surveyModel.firstQuestionList);
                
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

//首页回答问卷结束
+ (void)finishAnswerSurveyWithCompletionBlock:(void(^)(GDSurveyTaskModel *,GDCardModel *))block{
    
    GDWriteSurveyApi *api = [[GDWriteSurveyApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
       
        if (request.responseJSONObject&&[[request.responseJSONObject objectForKey:@"code"] integerValue] == 200) {
            NSDictionary *data = [request.responseJSONObject objectForKey:@"data"];
            if (data&&[data isKindOfClass:[NSDictionary class]]) {
                GDSurveyTaskModel *model = [GDSurveyTaskModel yy_modelWithDictionary:data];
                [self getSurveyOptionCardWithCompletionBlock:^(GDCardModel *cardModel) {
                    cardModel.surveyId = model.surveyId;//标示哪个问卷下的得到的card
                    block(model,cardModel);

                }];
            }
        }else{
            block(nil,nil);
        }
        
    } failure:^(YTKBaseRequest *request) {
        [GDWindow showWithString:@"网络异常"];
        block(nil,nil);
    }];
}


//最多只会有一个card
+ (void)getSurveyOptionCardWithCompletionBlock:(void(^)(GDCardModel *))block{
    NSMutableArray *surveyList = [GDLunchManager sharedManager].suveryList;
    NSMutableArray *array = [NSMutableArray new];
    NSMutableArray *writeList = [GDLunchManager sharedManager].writeReqVoList;
  
    for (GDFirstQuestionListModel*obj in surveyList) {
        NSArray *optionList = obj.firstOptionList;
        for (GDOptionModel *model in optionList) {
            
            for (GDQuestionWriteModel *writeModel in writeList) {
                if ([model.optionId isEqualToString:writeModel.optionId]&&model.cardId&&![model.cardId isEqualToString:@"0"]) {
                    [array addObject:model.cardId];
                    
                }

            }
     
        }
   
    }
    if (array.count>0) {//有card
        [self getCardById:array.firstObject completionBlock:^(GDCardModel *cardModel) {
            block(cardModel);
        }];
        
    }else{//选项里没有card
       block(nil);
    }

}

//点击完成问卷后的cardButton
+ (void)cardButtonClick:(NSString *)taskId completionBlock:(void(^)(GDSurveyTaskModel *))block{
    
    GDClickCardButtonApi *api = [[GDClickCardButtonApi alloc] initWithTaskId:taskId];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *data = request.responseJSONObject;
        if ([[data objectForKey:@"code"] integerValue] == 200) {
            GDSurveyTaskModel *model = [GDSurveyTaskModel yy_modelWithDictionary:[data objectForKey:@"data"]];
            block(model);
        }else{
            [GDWindow showWithString:[data objectForKey:@"message"]];
        }
    } failure:^(YTKBaseRequest *request) {
        [GDWindow showWithString:@"网络异常"];
    }];

}

+ (void)presentToTargetControllerWith:(UIView *)view targetVc:(UIViewController *)targetVc{
    
    UIViewController *vc = [GDHelper getSuperVc:view];
    [vc presentViewController:targetVc animated:YES completion:nil];
}

+ (void)clearCache{
    [[GDDataBaseManager sharedManager] deleteData];
    [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:GDAnimationStatus];
    
}
@end
