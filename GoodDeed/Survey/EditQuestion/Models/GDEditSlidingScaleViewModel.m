//
//  GDEditSlidingScaleViewModel.m
//  GoodDeed
//
//  Created by HK on 2018/9/4.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditSlidingScaleViewModel.h"

@implementation GDEditSlidingScaleViewModel

+ (GDEditSlidingScaleViewModel *)slidingScaleViewModel
{
    GDEditSlidingScaleViewModel *model = [[GDEditSlidingScaleViewModel alloc] init];
    model.type = GDSurveyTypeSlidingScale;
    model.deleteEnabel = NO;
    model.kCellReuseId = kSlidingScaleAnswerCell;
    model.cellDefaultHeight = 137.f;
    return model;
}

@end
