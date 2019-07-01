//
//  GDSlideCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSlideCell.h"
#import "GDSlider.h"

@interface GDSlideCell()
@property (nonatomic, strong) GDSlider *slider;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end
@implementation GDSlideCell


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
        self.slider.maximumValue = 11;
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
        UIImage *image = [UIImage imageNamed:@"slider_circle"];
        [self.slider setThumbImage:image forState:0];
        [self.slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.slider addGestureRecognizer:tap];
        
        UIView *lineView = [self createGraduationLineWith:11];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.slider.mas_bottom).offset(38);
            make.left.equalTo(self.contentView).offset(40);
            make.right.equalTo(self.contentView).offset(-40);
            make.height.equalTo(@11);
        }];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        leftLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
        [self.contentView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(40);
        }];
        self.leftLabel = leftLabel;
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        rightLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
        [self.contentView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-40);
        }];
        self.rightLabel = rightLabel;

        

    }
    return self;
}

- (void)refreshData:(GDQuestionModel *)model{
    
    self.model = model;
    GDOptionModel *leftOption = model.options.firstObject;
    self.leftLabel.text = leftOption.optionName;
    GDOptionModel *rightOption = model.options.lastObject;
    self.rightLabel.text = rightOption.optionName;

}

//滑动
- (void)valueChanged:(UISlider *)sender
{
    //只取整数值，固定间距
    NSString *tempStr = [self numberFormat:sender.value];
    [sender setValue:tempStr.floatValue];
    self.model.writeModel.optionOrder = tempStr;
    GDOptionModel *option = self.model.options[(tempStr.floatValue<=6&&tempStr.floatValue>=1)?0:1];
    //self.model.writeModel.optionId = option.optionId;
    [self.model.writeModel.optionOrders addObject:option.order];
    [self finishAnswer]; 
}

//点击
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [self.slider setValue:self.slider.value];
    self.model.writeModel.optionOrder = [NSString stringWithFormat:@"%f",self.slider.value];
    GDOptionModel *option = self.model.options[(self.slider.value<=6&&self.slider.value>=1)?0:1];
    //self.model.writeModel.optionId = option.optionId;
    [self.model.writeModel.optionOrders addObject:option.order];
    [self finishAnswer];
}


/**
 *  四舍五入
 *
 *  @param num 待转换数字
 *
 *  @return 转换后的数字
 */
- (NSString *)numberFormat:(float)num
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"0"];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
}

- (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}

/*
 value:刻度数
 */
- (UIView *)createGraduationLineWith:(NSInteger)value{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, 11)];
    for (int i=0; i<value; i++) {
        
        CGFloat space = (SCREEN_WIDTH-80)/(value-1.0);
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i*space, 0, 1, 11)];
        line.backgroundColor = [UIColor colorWithHexString:@"#B7B7B7"];
        [view addSubview:line];
    }
    return view;
}

@end
