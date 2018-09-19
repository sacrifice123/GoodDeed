//
//  GDStackRangeEmptyViewModel.m
//  GoodDeed
//
//  Created by HK on 2018/9/6.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditRankEmptyViewModel.h"

@implementation GDEditRankEmptyViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.kCellReuseId = kStackRankEmptyCell;
        self.cellDefaultHeight = 25.f;
        self.cellHeight = 25.f;
    }
    return self;
}

@end
