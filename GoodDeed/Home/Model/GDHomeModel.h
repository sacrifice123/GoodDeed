//
//  GDHomeModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDCardModel.h"

typedef NS_ENUM(NSInteger,GDHomeCellType) {
    GDHomeType  = 0,
    GDHomeWelcomeType,
    GDHomeKnowType,
    GDHomeTeamType,
    GDHomeTeamFinishType,
    GDHomeCardType,
    GDHomeSurveyType
};

@interface GDHomeModel : NSObject

@property (nonatomic, assign) GDHomeCellType type;
@property (nonatomic,strong) GDCardModel *cardModel;//card使用

@end
