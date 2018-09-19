//
//  GDSurveyTypePopView+Selected.h
//  GoodDeed
//
//  Created by HK on 2018/8/10.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDSurveyTypePopView.h"
#import "GDSurveyTypeModel.h"

@interface GDSurveyTypePopView (Selected)

// 单选
+ (GDSurveyTypePopView *)showChooseOnePopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                             dismiss:(dispatch_block_t)dismiss;

// 多选
+ (GDSurveyTypePopView *)showChooseMultiplePopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                             dismiss:(dispatch_block_t)dismiss;

// 滑动
+ (GDSurveyTypePopView *)showSlidingScalePopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                                     dismiss:(dispatch_block_t)dismiss;

// 定量
+ (GDSurveyTypePopView *)showBoundedRangePopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                                     dismiss:(dispatch_block_t)dismiss;

// 排序
+ (GDSurveyTypePopView *)showStackRankPopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                                     dismiss:(dispatch_block_t)dismiss;

// 填写
+ (GDSurveyTypePopView *)showTextPopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                                  dismiss:(dispatch_block_t)dismiss;

@end
