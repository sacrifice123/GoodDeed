//
//  GDUserModel.h
//  GoodDeed
//
//  Created by 张涛 on 2018/9/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"

@interface GDUserModel : GDBaseModel

@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *headPortrait;//用户头像路径
@property (copy, nonatomic) NSString *money;//用户筹集到的善款
@property (copy, nonatomic) NSString *mySurveyNum;//我的调查问卷数量
@property (copy, nonatomic) NSString *uid;//用户uid
@property (copy, nonatomic) NSString *nowTime;//时间戳（登录后服务端返回的）
@property (assign, nonatomic) BOOL isCreatedGroup;//是否创建团队
@property (copy, nonatomic) NSString *imgUrl;//公益组织图片路径
@property (copy, nonatomic) NSString *name;//公益组织名称
@property (copy, nonatomic) NSString *organId;//公益组织id

@end
