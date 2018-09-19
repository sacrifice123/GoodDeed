//
//  GDEditBottomView.m
//  GoodDeed
//
//  Created by HK on 2018/8/15.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBottomView.h"

@implementation GDEditBottomView

+ (GDEditBottomView *)editBottomView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GDEditBottomView" owner:nil options:nil] firstObject];
}

- (IBAction)save:(UIButton *)sender {
    if (self.saveEvent) {
        self.saveEvent();
    }
}

- (IBAction)next:(UIButton *)sender {
    if (self.nextEvent) {
        self.nextEvent();
    }
}

- (IBAction)manage:(UIButton *)sender {
    if (self.manageEvent) {
        self.manageEvent();
    }
}

@end
