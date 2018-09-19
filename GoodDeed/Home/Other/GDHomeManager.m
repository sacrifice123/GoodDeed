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
                [GDLunchManager sharedManager].userModel.mySurveyNum = [data objectForKey:@"mySurveyNum"];
                [GDLunchManager sharedManager].userModel.uid = [data objectForKey:@"uid"];
                NSDictionary *dic = [data objectForKey:@"organizationRespVo"];
                if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
                    [GDLunchManager sharedManager].userModel.organId = [dic objectForKey:@"id"];
                    [GDLunchManager sharedManager].userModel.imgUrl = [dic objectForKey:@"imgUrl"];
                    [GDLunchManager sharedManager].userModel.name = [dic objectForKey:@"name"];
                }
            }
        }
        
    } failure:^(YTKBaseRequest *request) {
        [GDWindow showWithString:@"网络异常"];
    }];
}

//上传图片
+ (void)uploadImage:(UIImage *)image {

    GDUploadImageApi *api = [[GDUploadImageApi alloc] initWithImage:image];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {


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

+ (void)presentToTargetControllerWith:(UIView *)view targetVc:(UIViewController *)targetVc{
    
    UIViewController *vc = [GDHelper getSuperVc:view];
    [vc presentViewController:targetVc animated:YES completion:nil];
}

+ (void)clearCache{
     [[NSUserDefaults standardUserDefaults] setObject:nil forKey:tokenCache];
     [[NSUserDefaults standardUserDefaults] setObject:nil forKey:animationStatus];
     [[NSUserDefaults standardUserDefaults] setObject:nil forKey:organModelCache];
     [[NSUserDefaults standardUserDefaults] setObject:nil forKey:uidCache];
    
}
@end
