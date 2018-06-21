//
//  GDQuestionBaseView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/21.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GDQuestionType) {
    GDReadyQuestion = 0,     //答题准备
    GDSingleSelQuestion,     //单选题
    GDMoreSelQuestion,       //多选题
    GDSlideQuestion,         //滑动题
    GDQuantifyQuestion,      //定量题
    GDSortQuestion,          //排序题
    GDImageSelQuestion,      //图片选择题
    GDWriteQuestion          //填写题
};

@interface GDQuestionBaseView : UIView

@property (nonatomic, assign) GDQuestionType type;

@end
