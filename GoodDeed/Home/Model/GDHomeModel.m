//
//  GDHomeModel.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDHomeModel.h"

@implementation GDHomeModel


- (GDSurveyTaskModel *)taskModel{
    
    if (_taskModel == nil) {
        _taskModel = [[GDSurveyTaskModel alloc] init];
    }
    
    return _taskModel;
}

@end
