//
//  GDTextAnswerTableViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/9/4.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDTextAnswerTableViewCell.h"

@implementation GDTextAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, GDScaleValue(30.f), 0, GDScaleValue(30.f)));
    }];
    self.contentView.layer.borderColor = [UIColor colorWithHex:0xCCCCCC].CGColor;
    self.contentView.layer.borderWidth = 1.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
