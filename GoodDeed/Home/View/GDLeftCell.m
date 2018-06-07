//
//  GDLeftCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLeftCell.h"
#import "GDLeftModel.h"

@interface GDLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation GDLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GDLeftModel *)model{
    
    _model = model;
    self.titleLabel.text = model.title;
    
}


@end
