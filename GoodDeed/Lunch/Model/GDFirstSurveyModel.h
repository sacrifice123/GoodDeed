//
//  GDFirstSurveyModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"
#import "GDFirstQuestionListModel.h"

//暂时没用
@interface GDFirstSurveyModel : GDBaseModel

@property (nonatomic,copy) NSString *surveyId;//问卷ID
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *name;//问卷名称
@property (nonatomic,copy) NSString *imgUrl;// 图片路径
@property (nonatomic,copy) NSString *type;//类型（0消费者 1我的名单） ,
@property (nonatomic,copy) NSString *personTypeId;//sys_condition_list对应表中id
@property (nonatomic,copy) NSString *personNum;//如果type为0则填写人数
@property (nonatomic,strong) NSArray <GDFirstQuestionListModel *>*firstQuestionList;

@end
