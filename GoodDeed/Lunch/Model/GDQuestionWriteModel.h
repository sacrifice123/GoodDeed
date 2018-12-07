//
//  GDQuestionWriteModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"
typedef NS_ENUM(NSInteger, GDSurveyType) {
    
    GDReadyType = 0,    //准备
    GDSingleType,       //单选题1
    GDMultipleType,     //多选题2
    GDSlideType,        //滑动题3
    GDQuantitativeType, //定量题4
    GDSortType,         //排序题5
    GDSelectType,       //勾选图片题6
    GDWriteType         //填写题7
};

@interface GDQuestionWriteModel : GDBaseModel

@property (nonatomic,copy) NSString *content;//type为7填写题内容
@property (nonatomic,strong) NSMutableArray *selectedArray;//type为2选中选项
@property (nonatomic,copy) NSString *optionId;//如果是填写题为0
@property (nonatomic,copy) NSString *optionOrder;//type1是选中的选项，type3滑动题 左到右（1-6 7-11） （type为5为选项顺序 例：选项如果选项3排在第1位，则optionOrder的值为1.optionId为选项3的id)
@property (nonatomic,copy) NSString *questionId;
@property (nonatomic,assign) GDSurveyType type;

//@property (nonatomic,copy) NSString *cardId;//新增
@end
