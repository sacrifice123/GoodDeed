//
//  GDQuestionScrollView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/30.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuestionScrollView.h"

@implementation GDQuestionScrollView

//当滑动UISlider时，使UIScrollView不可滑动
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    [self endEditing:YES];//键盘消失
    /*
     直接拖动UISlider，此时touch时间在150ms以内，UIScrollView会认为是拖动自己，从而拦截了event，导致UISlider接受不到滑动的event。但是只要按住UISlider一会再拖动，此时此时touch时间超过150ms，因此滑动的event会发送到UISlider上。
     */
    UIView *view = [super hitTest:point withEvent:event];
    
    if([view isKindOfClass:[UISlider class]])
    {
        //如果响应view是UISlider,则scrollview禁止滑动
        self.scrollEnabled = NO;
    }
    else
    {   //如果不是,则恢复滑动
        self.scrollEnabled = YES;
    }
    return view;
}



@end
