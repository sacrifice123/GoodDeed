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
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:leftVC];
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
                [GDLunchManager sharedManager].userModel.isCreatedGroup = [data objectForKey:@"isCreatedGroup"];
                [GDLunchManager sharedManager].userModel.mySurveyNum = [data objectForKey:@"mySurveyNum"];
                [GDLunchManager sharedManager].userModel.uid = [data objectForKey:@"uid"];
                NSDictionary *dic = [data objectForKey:@"organizationRespVo"];
                if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
                    [GDLunchManager sharedManager].userModel.organId = [dic objectForKey:@"id"];
                    [GDLunchManager sharedManager].userModel.imgUrl = [dic objectForKey:@"imgUrl"];
                    [GDLunchManager sharedManager].userModel.name = [dic objectForKey:@"name"];
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
//+ (void)uploadImage:(UIImage *)image {
//
//    GDUploadImageApi *api = [[GDUploadImageApi alloc] initWithImage:image];
//    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//
//
//    } failure:^(YTKBaseRequest *request) {
//        [GDWindow showWithString:@"网络异常"];
//    }];
//}

+ (void)uploadImage:(UIImage *)image{
    
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:[NSString stringWithFormat:@"%@%@",GDBaseUrl,@"/image/uploadImage"]];
    
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    
    NSMutableString *body = [[NSMutableString alloc] init];
    
    
    [body appendFormat:@"%@\r\n",MPboundary];
    
    //请求参数
    [body appendFormat:@"Content-Disposition: form-data;name=\"%@\"\r\n\r\n",@"token"];
    
    //参数值
    [body appendFormat:@"%@\r\n", @""];
    
   // NSData *imageData = UIImagePNGRepresentation([UtilTool changeImg:image max:1136]);
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData;
    //将body字符串转化为UTF8格式的二进制
    myRequestData=[NSMutableData data];
    
    
    //上传文件
    [body appendFormat:@"%@\r\n",MPboundary];
    [body appendFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"%@\"\r\n",@"temp.png"];
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    [myRequestData appendData:imageData];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:url]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    //    [request setTimeoutInterval:[DataStore getHttpTimeout]];
    [request setHTTPMethod:@"POST"];
    //设置HTTPHeader中Content-Type的值
    NSString *cttype=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:cttype forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:myRequestData];

    NSURLSession * session = [NSURLSession sharedSession];
    //创建任务
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"----%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"response==%@",response);
    }];
    //开启网络任务
    [task resume];

}


//创建团队
+ (void)createGroupWithHeadUrl:(NSString *)url uidName:(NSString *)uidName name:(NSString *)name completionBlock:(void(^)(GDGroupListModel *))block{
    
    GDCreateGroupApi *api = [[GDCreateGroupApi alloc] initWithHeadUrl:url uidName:uidName name:name];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if ([[request.responseJSONObject objectForKey:@"code"] integerValue]==200) {
            NSDictionary *data = [request.responseJSONObject objectForKey:@"data"];
            if (data&&[data isKindOfClass:[NSDictionary class]]) {
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
    }];
}

//+ (void)uploadImage:(UIImage *)image {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 20;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", @"text/json", nil];
//    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", GDBaseUrl , @"/image/uploadImage"];
//    NSDictionary *dic = @{@"id":@"0"};
//    //根据当前系统时间生成图片名称
//    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//        float size = imageData.length/1024.0/1024.0;
//        if (size>=1) {
//            imageData = UIImageJPEGRepresentation(image, 0.3);
//        }else{
//            imageData = UIImageJPEGRepresentation(image, 0.5);
//        }
//
//        [formData appendPartWithFileData:imageData name:@"image" fileName:@"image" mimeType:@"image/jpeg"];
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//
//        NSLog(@"上传成功");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSLog(@"上传失败");
//    }];
//
//}

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

+ (void)presentToTargetControllerWith:(UIView *)view targetVc:(UIViewController *)targetVc{
    
    UIViewController *vc = [GDHelper getSuperVc:view];
    [vc presentViewController:targetVc animated:YES completion:nil];
}

+ (void)clearCache{
    [[GDDataBaseManager sharedManager] deleteData];
    [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:GDAnimationStatus];
    
}
@end
