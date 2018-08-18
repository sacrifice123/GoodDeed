//
//  GDFirstQuestionListModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"

typedef NS_ENUM(NSInteger, GDSurveyType) {
    
    GDReadyType = 0,    //准备
    GDSingleType,       //单选题
    GDMultipleType,     //多选题
    GDSlideType,        //滑动题
    GDQuantitativeType, //定量题
    GDSortType,         //排序题
    GDSelectType,       //勾选图片题
    GDWriteType         //填写题
};

@interface GDFirstQuestionListModel : GDBaseModel

@property (nonatomic,strong) NSArray *firstOptionList;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *isSkip;
@property (nonatomic,copy) NSString *questionName;
@property (nonatomic,copy) NSString *sort;
@property (nonatomic,assign) GDSurveyType type;


@end
