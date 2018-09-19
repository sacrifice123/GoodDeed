//
//  GDSurveyTypeModel.h
//  GoodDeed
//
//  Created by HK on 2018/8/10.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDSurveyDefine.h"


@interface GDSurveyTypeModel : NSObject

@property (nonatomic) GDSurveyEditType type;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithType:(GDSurveyEditType)type;

@end
