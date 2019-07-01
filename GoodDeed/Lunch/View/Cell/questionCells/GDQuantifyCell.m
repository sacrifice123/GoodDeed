//
//  GDQuantifyCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuantifyCell.h"
#import "GDSlider.h"

@interface GDQuantifyCell()

@property (nonatomic, strong) GDSlider *slider;
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
        
        self.slider = [[GDSlider alloc] init];
        self.slider.value = 0.5;
        self.slider.minimumValue = 1;
        self.slider.maximumValue = 3;
        self.slider.continuous = NO;
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
        [self.slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.slider addGestureRecognizer:tap];
        
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

- (void)refreshData:(GDQuestionModel *)model{
    
    self.model = model;
    [self.titleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i=0; i<model.options.count; i++) {
        
        CGFloat space = (SCREEN_WIDTH-80)/(model.options.count-1.0);
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i*space, 0, 1, 11)];
        line.backgroundColor = [UIColor colorWithHexString:@"#B7B7B7"];
        [self.titleView addSubview:line];
        
        UILabel *label = [[UILabel alloc] init];
        GDOptionModel *optionModel = model.options[i];
        label.text = optionModel.optionName;
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
    NSString *tempStr = [self numberFormat:sender.value];
    [sender setValue:tempStr.floatValue];
    if (self.model.options.count>tempStr.integerValue-1) {
        GDOptionModel *option = self.model.options[tempStr.integerValue-1];
        //self.model.writeModel.optionId = option.optionId;
        [self.model.writeModel.optionOrders addObject:option.order];
    }
    [self finishAnswer];
    
}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
    
    [self.slider setValue:self.slider.value];
    NSInteger index = self.slider.value-1;
    if (self.model.options.count>index) {
        GDOptionModel *option = self.model.options[index];
      //  self.model.writeModel.optionId = option.optionId;
        [self.model.writeModel.optionOrders addObject:option.order];
    }
    [self finishAnswer];
}

- (NSString *)numberFormat:(float)num
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"0"];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
}

@end
