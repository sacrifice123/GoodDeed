//
//  GDSurveyCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/8.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSurveyCell.h"

@implementation GDSurveyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}
- (IBAction)preview:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(gotoPreVc:)]) {
        [self.delegate gotoPreVc:sender];

    }
    
}


@end
