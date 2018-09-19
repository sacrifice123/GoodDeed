//
//  GDChooseOneModel.h
//  GoodDeed
//
//  Created by HK on 2018/8/12.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDSurveyTypeModel.h"

@interface GDChooseOneModel : GDSurveyTypeModel

// 是否有图
@property (nonatomic) BOOL noImage;

@property (copy, nonatomic) NSString *question;
@property (strong, nonatomic) NSArray *options;

@end
