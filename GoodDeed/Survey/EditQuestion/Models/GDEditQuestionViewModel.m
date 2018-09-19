//
//  GDEditQuestionViewModel.m
//  GoodDeed
//
//  Created by HK on 2018/8/26.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditQuestionViewModel.h"

@implementation GDEditQuestionViewModel


- (instancetype)initWithPlaceholer:(NSString *)placeholder
{
    self = [super init];
    if (self) {
        self.placeholder = placeholder;
        self.kCellReuseId = kCommonQuestionCell;
        self.cellDefaultHeight = 116.f;
    }
    
    return self;
}

@end
