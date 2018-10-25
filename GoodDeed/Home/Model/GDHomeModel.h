//
//  GDHomeModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDCardModel.h"
#import "GDSurveyTaskModel.h"

typedef NS_ENUM(NSInteger,GDHomeCellType) {
    GDHomeType  = 0,
    GDHomeWelcomeType,
    GDHomeSuveryStatusType,
    GDHomeTeamType,
    GDHomeTeamFinishType,
    GDHomeCardType,
    GDHomeSurveyType
};

@interface GDHomeModel : NSObject

@property (nonatomic, assign) GDHomeCellType type;
@property (nonatomic,strong) GDCardModel *cardModel;//card使用
@property (nonatomic,strong) GDSurveyTaskModel *taskModel;
@property (nonatomic, assign) BOOL isHasSurvery;//是否含有问卷
@end
