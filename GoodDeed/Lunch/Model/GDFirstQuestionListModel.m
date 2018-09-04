//
//  GDFirstQuestionListModel.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDFirstQuestionListModel.h"

@implementation GDFirstQuestionListModel


- (GDQuestionWriteModel *)writeModel{
    
    if (_writeModel == nil) {
        _writeModel = [[GDQuestionWriteModel alloc] init];
        for (int i=0; i<self.firstOptionList.count; i++) {
            [_writeModel.selectedArray addObject:@0];//多选题选项
        }
    }
    
    _writeModel.questionId = self.questionId;
    _writeModel.type = self.type;
    return _writeModel;
}

- (NSArray *)firstOptionList{
    
    if (_firstOptionList == nil) {
        _firstOptionList = [[NSArray alloc] init];
    }
    
    return _firstOptionList;
}
@end
