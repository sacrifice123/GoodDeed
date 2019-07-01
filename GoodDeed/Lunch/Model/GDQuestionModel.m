//
//  GDQuestionModel.m
//  GoodDeed
//
//  Created by 张涛 on 2019/5/11.
//  Copyright © 2019年 GoodDeed. All rights reserved.
//

#import "GDQuestionModel.h"

@implementation GDQuestionModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{
             @"isSkip":@"skip"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{@"options":[GDOptionModel class]};
}

- (GDQuestionWriteModel *)writeModel{
    
    if (_writeModel == nil) {
        _writeModel = [[GDQuestionWriteModel alloc] init];
//        for (int i=0; i<self.options.count; i++) {
//            [_writeModel.selectedArray addObject:@0];//多选题选项
//        }
    }
//    _writeModel.questionId = self.questionId;
//    _writeModel.type = self.surveyType;
    return _writeModel;
}

- (GDSurveyType)surveyType{
    _surveyType = GDReadyType;
    if (_type&&[_type isKindOfClass:[NSString class]]) {
        if ([_type isEqualToString:@"SINGLE"]) {
            _surveyType = GDSingleType;
        }else if ([_type isEqualToString:@"MULTI"]){
            _surveyType = GDMultipleType;
        }else if ([_type isEqualToString:@"SLIDE"]){
            _surveyType = GDSlideType;
        }else if ([_type isEqualToString:@"QUANTIFY"]){
            _surveyType = GDQuantitativeType;
        }else if ([_type isEqualToString:@"SORT"]){
            _surveyType = GDSortType;
        }else if ([_type isEqualToString:@"WRITE"]){
            _surveyType = GDWriteType;
        }else if ([_type isEqualToString:@"CHECK"]){
            _surveyType = GDSelectType;
        }
    }
    return _surveyType;
}

- (NSString *)setTypeWith:(GDSurveyType )type{
    switch (type) {
        case GDSingleType:
            _type = @"SINGLE";
            break;
        case GDMultipleType:
            _type = @"MULTI";
            break;
        case GDSlideType:
            _type = @"SLIDE";
            break;
        case GDQuantitativeType:
            _type = @"QUANTIFY";
            break;
        case GDSortType:
            _type = @"SORT";
            break;
        case GDWriteType:
            _type = @"WRITE";
            break;
        case GDSelectType:
            _type = @"CHECK";
            break;
            
        default:
            break;
    }
    return _type;
    
}

- (NSString *)questionId{
    return _order;
}

//服务端的坑
- (void)setQuestionId:(NSString *)questionId{
    _order = questionId;
}

@end
