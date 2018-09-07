//
//  GDQuestionBaseCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuestionBaseCell.h"
#import "GDQuestionScrollView.h"

@implementation GDQuestionBaseCell

- (void)enableScroll:(BOOL)isEnable{
    
    GDQuestionScrollView *scrollView = (GDQuestionScrollView *)[GDHelper getTargetView:[GDQuestionScrollView class] view:self];
    if (scrollView) {
        scrollView.scrollEnabled = isEnable;
    }
    
}


@end
