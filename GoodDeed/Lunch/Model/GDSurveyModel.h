//
//  GDSurveyModel.h
//  GoodDeed
//
//  Created by 张涛 on 2019/5/11.
//  Copyright © 2019年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"
#import "GDQuestionModel.h"

@interface GDSurveyModel : GDBaseModel
@property (nonatomic,assign) BOOL isHome;
@property (nonatomic,copy) NSString *surveyId;//问卷ID
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *surveyName;//问卷名称
@property (nonatomic,copy) NSString *backgroundImageUrl;// 图片路径
@property (nonatomic,copy) NSString *personTypeId;//sys_condition_list对应表中id---
@property (nonatomic,copy) NSString *personNum;//如果type为0则填写人数---
//@property (nonatomic,strong) NSMutableArray <GDQuestionModel *>*questionList;
@property (nonatomic,strong) NSMutableArray <GDQuestionModel *>*questions;
@property (nonatomic,copy) NSString *cardId;
@property (nonatomic,copy) NSString *creatorId;
@property (nonatomic,copy) NSString *surveyStatus;
@property (nonatomic,copy) NSString *preAnswerTime;
@property (nonatomic,copy) NSString *createTime;
@end

