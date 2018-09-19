//
//  GDSurveyTypePopView+Selected.m
//  GoodDeed
//
//  Created by HK on 2018/8/10.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDSurveyTypePopView+Selected.h"

@implementation GDSurveyTypePopView (Selected)

// 单选
+ (GDSurveyTypePopView *)showChooseOnePopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                                  dismiss:(dispatch_block_t)dismiss
{
    return [GDSurveyTypePopView showSurveyTypePopViewWithTopImage:[UIImage imageNamed:@"pop_choose_one_no_image"]
                                                          topName:@"单选题（无图）"
                                                         botImage:[UIImage imageNamed:@"pop_choose_one_image"]
                                                          botName:@"单选题（有图）"
                                                          selected:selected
                                                          dismiss:dismiss];
        
}

// 多选
+ (GDSurveyTypePopView *)showChooseMultiplePopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                                       dismiss:(dispatch_block_t)dismiss
{
    
    return [GDSurveyTypePopView showSurveyTypePopViewWithTopImage:[UIImage imageNamed:@"pop_choose_mult_no_image"]
                                                          topName:@"多选题（无图）"
                                                         botImage:[UIImage imageNamed:@"pop_choose_mult_image"]
                                                          botName:@"多选题（有图）"
                                                         selected:selected
                                                          dismiss:dismiss];
}

// 滑动
+ (GDSurveyTypePopView *)showSlidingScalePopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                                     dismiss:(dispatch_block_t)dismiss
{
    return [GDSurveyTypePopView showSurveyTypePopViewWithTopImage:[UIImage imageNamed:@"pop_slide_no_image"]
                                                          topName:@"滑动（无图）"
                                                         botImage:[UIImage imageNamed:@"pop_slide_image"]
                                                          botName:@"滑动（有图）"
                                                         selected:selected
                                                          dismiss:dismiss];
}

// 定量
+ (GDSurveyTypePopView *)showBoundedRangePopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                                     dismiss:(dispatch_block_t)dismiss
{
    return [GDSurveyTypePopView showSurveyTypePopViewWithTopImage:[UIImage imageNamed:@"pop_bound_no_image"]
                                                          topName:@"定量（无图）"
                                                         botImage:[UIImage imageNamed:@"pop_bound_image"]
                                                          botName:@"定量（有图）"
                                                         selected:selected
                                                          dismiss:dismiss];
}

// 排序
+ (GDSurveyTypePopView *)showStackRankPopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                                  dismiss:(dispatch_block_t)dismiss
{
    return [GDSurveyTypePopView showSurveyTypePopViewWithTopImage:[UIImage imageNamed:@"pop_rank_no_image"]
                                                          topName:@"排序（无图）"
                                                         botImage:[UIImage imageNamed:@"pop_rank_image"]
                                                          botName:@"排序（有图）"
                                                         selected:selected
                                                          dismiss:dismiss];
}

// 填写
+ (GDSurveyTypePopView *)showTextPopViewWithSelected:(GDSurveyTypePopViewSelectedBlock)selected
                                             dismiss:(dispatch_block_t)dismiss
{
    return [GDSurveyTypePopView showSurveyTypePopViewWithTopImage:[UIImage imageNamed:@"pop_text_no_image"]
                                                          topName:@"填写（无图）"
                                                         botImage:[UIImage imageNamed:@"pop_text_image"]
                                                          botName:@"填写（有图）"
                                                         selected:selected
                                                          dismiss:dismiss];
}

@end
