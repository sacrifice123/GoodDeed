//
//  GDCardModel.h
//  GoodDeed
//
//  Created by 张涛 on 2018/10/16.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"

@interface GDCardModel : GDBaseModel

@property (nonatomic, copy) NSString *backgroundImgUrl;
@property (nonatomic, copy) NSString *buttonColor;
@property (nonatomic, copy) NSString *buttonName;
@property (nonatomic, copy) NSString *buttonHref;
@property (nonatomic, copy) NSString *cardNote;
@property (nonatomic, copy) NSString *hrefName;
@property (nonatomic, copy) NSString *hrefUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, assign) BOOL isHome;
@property (nonatomic, strong) NSNumber *registeredCard;
@property (nonatomic, copy) NSString *taskId;//点击button用

@property (nonatomic, copy) NSString *surveyId;//所属调查问卷的id

@end
