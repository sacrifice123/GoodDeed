//
//  GDPGHeaderView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/26.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDPGHeaderView.h"

@implementation GDPGHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)search:(id)sender {
    if (self.block) {
        self.block();
    }
    
}

@end
