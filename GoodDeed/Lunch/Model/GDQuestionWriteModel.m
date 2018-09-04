//
//  GDQuestionWriteModel.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuestionWriteModel.h"

@implementation GDQuestionWriteModel

- (NSMutableArray *)selectedArray{
    
    if (_selectedArray == nil) {
        _selectedArray = [[NSMutableArray alloc] init];
    }
    return _selectedArray;
}

@end
