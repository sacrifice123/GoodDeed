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
    // Initialization code
}
- (IBAction)preview:(id)sender {
    
    
    [self.delegate gotoPreVc];
    
}


@end
