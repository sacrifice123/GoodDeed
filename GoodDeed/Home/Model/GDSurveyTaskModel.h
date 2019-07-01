//
//  GDSurveyTaskModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/22.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"

//查询用户可回答或者已经回答的问卷
@interface GDSurveyTaskModel : GDBaseModel

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *money;//赚取的钱
@property (nonatomic, copy) NSString *personNum;//需要的答题人数
@property (nonatomic, copy) NSString *preFinishTime;//预计完成时间（单位是s）
@property (nonatomic, assign) BOOL firstSurvey;//是否是首套问卷
@property (nonatomic, assign) BOOL status;//问卷状态（yes完成 no未完成）
@property (nonatomic, copy) NSString *surveyId;//调查问卷id
@property (nonatomic, copy) NSString *surveyName;//问卷名称
@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSString *taskStatus;//UNFINISHED/FINISHED
@property (nonatomic, copy) NSString *donation;//回答该问卷可以捐赠的钱数
@end
