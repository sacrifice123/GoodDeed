//
//  GDEditBottomSettingView.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBottomSettingView.h"

@implementation GDEditBottomSettingView

+ (GDEditBottomSettingView *)editBottomSettingViewWithClickEvent:(dispatch_block_t)clickEvent
{
    GDEditBottomSettingView *view = [[[NSBundle mainBundle] loadNibNamed:@"GDEditBottomSettingView" owner:nil options:nil] firstObject];
    view.clickEvent = clickEvent;
    return view;
}

- (IBAction)settingEvent:(id)sender
{
    if (self.clickEvent) {
        self.clickEvent();
    }
}

@end
