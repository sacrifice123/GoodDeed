//
//  GDSortModel.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/6.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSortModel.h"

@implementation GDSortModel

- (void)setSelected:(BOOL)selected{
    
    _selected = selected;
    self.button.selected = selected;
}

@end
