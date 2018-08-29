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
        
        self.slider = [[UISlider alloc] init];
        [self.contentView addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(40);
            make.right.equalTo(self.contentView).offset(-40);
        }];
        
    }
    return self;
}


@end
