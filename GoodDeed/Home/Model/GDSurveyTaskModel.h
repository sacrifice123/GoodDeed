//
//  GDSurveyTaskModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/22.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"

@interface GDSurveyTaskModel : GDBaseModel

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *money;//赚取的钱
@property (nonatomic, copy) NSString *personNum;//需要的答题人数
@property (nonatomic, copy) NSString *preFinishTime;//预计完成时间（单位是s）
@property (nonatomic, assign) BOOL status;//问卷状态（1完成 0未完成）
@property (nonatomic, copy) NSString *surveyId;//调查问卷id
@property (nonatomic, copy) NSString *surveyName;//问卷名称

@end
