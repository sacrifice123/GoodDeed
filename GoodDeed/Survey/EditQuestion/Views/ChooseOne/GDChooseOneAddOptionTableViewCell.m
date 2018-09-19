//
//  GDChooseOneAddOptionTableViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/8/26.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDChooseOneAddOptionTableViewCell.h"

@interface GDChooseOneAddOptionTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation GDChooseOneAddOptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = [UIColor colorWithHex:0xCCCCCC].CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:self.tipLabel.bounds].CGPath;
    
    border.frame = self.tipLabel.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@7, @5];
    [self.tipLabel.layer addSublayer:border];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
