//
//  GDStackRangeAddOptionTableViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/9/6.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDStackRankAddOptionTableViewCell.h"

@implementation GDStackRankAddOptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tipLabel.layer.cornerRadius = 33.5/2.f;
    self.tipLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
