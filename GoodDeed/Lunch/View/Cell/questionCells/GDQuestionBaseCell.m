//
//  GDQuestionBaseCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuestionBaseCell.h"
#import "GDQuestionScrollView.h"
#import "GDQuestionBaseView.h"

@implementation GDQuestionBaseCell

- (void)enableScroll:(BOOL)isEnable{
    
    GDQuestionScrollView *scrollView = (GDQuestionScrollView *)[GDHelper getTargetView:[GDQuestionScrollView class] view:self];
    if (scrollView) {
        scrollView.scrollEnabled = isEnable;
    }
    
}
//每题答题结束
- (void)finishAnswer{
    
    GDQuestionBaseView *view = (GDQuestionBaseView *)[GDHelper getTargetView:[GDQuestionBaseView class] view:self];
    [view finishAnswer:view.model];
    
}

@end
