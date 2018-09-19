//
//  GDStackRangeIndexViewModel.m
//  GoodDeed
//
//  Created by HK on 2018/9/6.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditRankIndexViewModel.h"

@implementation GDEditRankIndexViewModel

- (instancetype)init
{
    return [self initWithIndex:0];
}

- (instancetype)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.kCellReuseId = kStackRankIndexCell;
        self.cellDefaultHeight = 33.5;
        self.cellHeight = 33.5;
        _index = index;
    }
    return self;
}

@end
