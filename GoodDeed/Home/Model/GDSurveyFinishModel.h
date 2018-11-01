//
//  GDSurveyFinishModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/11/1.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"

@interface GDSurveyFinishModel : GDBaseModel

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *personNum;
@property (nonatomic, copy) NSString *preFinishTime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *surveyId;
@property (nonatomic, copy) NSString *surveyName;

@end
