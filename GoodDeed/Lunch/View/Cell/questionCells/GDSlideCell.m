//
//  GDSlideCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSlideCell.h"

@interface GDSlideCell()
@property (nonatomic, strong) UISlider *slider;

@end
@implementation GDSlideCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"slider_bg.jpg"];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(40);
            make.right.equalTo(self.contentView).offset(-40);
            make.height.equalTo(@12);
        }];

        self.slider = [[UISlider alloc] init];
        self.slider.minimumTrackTintColor = [UIColor clearColor];
        self.slider.maximumTrackTintColor = [UIColor clearColor];
        [self.contentView addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(40);
            make.right.equalTo(self.contentView).offset(-40);
            make.height.equalTo(@12);
        }];
        [self.contentView bringSubviewToFront:self.slider];
        UIImage *image = [self OriginImage:[UIImage imageNamed:@"slider_circle"] scaleToSize:CGSizeMake(76, 76)];
        [self.slider setThumbImage:image forState:0];
        [self.slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchCancel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.slider addGestureRecognizer:tap];
    }
    return self;
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

@end
