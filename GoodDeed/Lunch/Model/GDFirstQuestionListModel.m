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
    }
    
    _writeModel.questionId = self.questionId;
    _writeModel.type = self.type;
    return _writeModel;
}
@end
