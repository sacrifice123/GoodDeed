//
//  GDBaseModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
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

@interface GDBaseModel : NSObject

@end
