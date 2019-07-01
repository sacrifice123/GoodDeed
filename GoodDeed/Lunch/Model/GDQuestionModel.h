//
//  GDQuestionModel.h
//  GoodDeed
//
//  Created by 张涛 on 2019/5/11.
//  Copyright © 2019年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"
#import "GDOptionModel.h"
#import "GDQuestionWriteModel.h"

@interface GDQuestionModel : GDBaseModel

@property (copy, nonatomic) NSString *surveyId;//本地多表查询使用
//@property (nonatomic,strong) NSMutableArray <GDOptionModel*> *optionList;//问题选项
@property (nonatomic,copy) NSString *backgroundImageUrl;//问题头部图片
@property (nonatomic,assign) BOOL isSkip;//是否跳过(1可以 0不可以)
@property (nonatomic,copy) NSString *questionName;//问题描述
@property (nonatomic,copy) NSString *questionId;//问题id，唯一标识
@property (nonatomic,copy) NSString *order;//排序
@property (nonatomic,assign) NSInteger sort;//排序
@property (nonatomic,copy) NSString *type;//SINGLE, MULTI, SLIDE, QUANTIFY, SORT, CHECK, WRITE 
@property (nonatomic,assign) GDSurveyType surveyType;//问题类型
@property (nonatomic,strong) NSMutableArray <GDOptionModel*>*options;
@property (nonatomic,strong) GDQuestionWriteModel *writeModel;//每次答题结束后记录相关答题内容
@property (nonatomic,assign) NSInteger index;//第几个选项

- (NSString *)setTypeWith:(GDSurveyType )type;
@end

