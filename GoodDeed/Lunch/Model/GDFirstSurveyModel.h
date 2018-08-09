//
//  GDFirstSurveyModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"
#import "GDFirstQuestionListModel.h"

@interface GDFirstSurveyModel : GDBaseModel

@property (nonatomic,copy) NSString *organId;//公益组织ID
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *personTypeId;
@property (nonatomic,copy) NSString *personNum;
@property (nonatomic,strong) NSArray <GDFirstQuestionListModel *>*firstQuestionList;

@end
