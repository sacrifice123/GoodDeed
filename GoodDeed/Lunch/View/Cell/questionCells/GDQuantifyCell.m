//
//  GDQuantifyCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuantifyCell.h"

@interface GDQuantifyCell()

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *rightLabel;

@end
@implementation GDQuantifyCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"slider_bg.jpg"];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(32);
            make.left.equalTo(self.contentView).offset(40);
            make.right.equalTo(self.contentView).offset(-40);
            make.height.equalTo(@12);
        }];
        
        self.slider = [[UISlider alloc] init];
        self.slider.value = 0.5;
        self.slider.minimumTrackTintColor = [UIColor clearColor];
        self.slider.maximumTrackTintColor = [UIColor clearColor];
        [self.contentView addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(32);
            make.left.equalTo(self.contentView).offset(40);
            make.right.equalTo(self.contentView).offset(-40);
            make.height.equalTo(@12);
        }];
        [self.contentView bringSubviewToFront:self.slider];
        UIImage *image = [UIImage imageNamed:@"slider_arrow"];
        [self.slider setThumbImage:image forState:0];
        [self.slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchCancel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.slider addGestureRecognizer:tap];
        
//        UIView *lineView = [self createGraduationLineWith:11];
//        [self.contentView addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.slider.mas_bottom).offset(38);
//            make.left.equalTo(self.contentView).offset(40);
//            make.right.equalTo(self.contentView).offset(-40);
//            make.height.equalTo(@11);
//        }];
//
//        UILabel *leftLabel = [[UILabel alloc] init];
//        leftLabel.textColor = [UIColor colorWithHexString:@"#999999"];
//        leftLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
//        [self.contentView addSubview:leftLabel];
//        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(lineView.mas_bottom).offset(10);
//            make.left.equalTo(self.contentView).offset(40);
//        }];
//

        self.titleView = [[UIView alloc] init];
        [self.contentView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.slider.mas_bottom).offset(38);
            make.left.equalTo(self.contentView).offset(40);
            make.right.equalTo(self.contentView).offset(-40);
            make.height.equalTo(@50);
        }];

    }
    return self;
}

- (void)setModel:(GDFirstQuestionListModel *)model{
    
    [self.titleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    for (int i=0; i<model.firstOptionList.count; i++) {
        
        CGFloat space = (SCREEN_WIDTH-80)/(model.firstOptionList.count-1.0);
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i*space, 0, 1, 11)];
        line.backgroundColor = [UIColor colorWithHexString:@"#B7B7B7"];
        [self.titleView addSubview:line];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = model.firstOptionList[i];
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        label.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
        [self.titleView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(10);
            make.centerX.equalTo(line.mas_centerX);
        }];

    }
}

- (void)valueChanged:(UISlider *)sender
{
    //只取整数值，固定间距
    //    NSString *tempStr = [self numberFormat:sender.value];
    //    [sender setValue:tempStr.floatValue];
}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
    //    //取得点击点
    //    CGPoint p = [sender locationInView:_slider];
    //    //计算处于背景图的几分之几，并将之转换为滑块的值（1~7）
    //    float tempFloat = (p.x - 15) / 295.0 * 7 + 1;
    //    NSString *tempStr = [self numberFormat:tempFloat];
    //    [_slider setValue:tempStr.floatValue];
}

@end
