//
//  GDFirstQuestionListModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"
#import "GDQuestionWriteModel.h"
#import "GDOptionModel.h"

@interface GDFirstQuestionListModel : GDBaseModel

@property (copy, nonatomic) NSString *surveyId;//本地多表查询使用

@property (nonatomic,strong) NSArray <GDOptionModel*> *firstOptionList;//问题选项
@property (nonatomic,copy) NSString *imgUrl;//问题头部图片
@property (nonatomic,copy) NSString *isSkip;//是否跳过(1可以 0不可以)
@property (nonatomic,copy) NSString *questionName;//问题描述
@property (nonatomic,copy) NSString *questionId;//问题id，唯一标识
@property (nonatomic,assign) NSInteger sort;//排序
@property (nonatomic,assign) GDSurveyType type;//问题类型

@property (nonatomic,strong) GDQuestionWriteModel *writeModel;//每次答题结束后记录相关答题内容
@property (nonatomic,assign) NSInteger index;//第几个选项

@end
