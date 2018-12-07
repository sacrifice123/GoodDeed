//
//  GDSurveyDefine.h
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#ifndef GDSurveyDefine_h
#define GDSurveyDefine_h


typedef NS_ENUM(NSInteger, GDSurveyEditType) {
    GDSurveyTypeCoverInfo,       // 封面信息
    GDSurveyTypeChooseType,      // 选择类型
    GDSurveyTypeEditChooseType,  // 编辑选择类型
    GDSurveyTypeChooseOne,       // 单选
    GDSurveyTypeChooseMultiple,  // 多选
    GDSurveyTypeSlidingScale,    // 滑动
    GDSurveyTypeBoundedRange,    // 定量
    GDSurveyTypeStackRank,       // 排序
    GDSurveyTypeImageVote,       // 勾选图片
    GDSurveyTypeText,            //  填写
};

#endif /* GDSurveyDefine_h */
