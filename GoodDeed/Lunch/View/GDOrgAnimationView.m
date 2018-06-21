//
//  GDOrgAnimationView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDOrgAnimationView.h"

#define bgHeight 233
@interface GDOrgAnimationView()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *bgView;

@end
@implementation GDOrgAnimationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:self.bgView];
        self.bgView.frame = CGRectMake(SCREEN_WIDTH-169, -bgHeight, 164, bgHeight);
       
        [self.bgView addSubview:self.imgView];
        [self bringSubviewToFront:self.bgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView).offset(18);
            make.width.equalTo(@(132));
            make.height.equalTo(@(120));
            make.centerX.equalTo(self.bgView);
            
        }];
        
        __weak typeof(self) weakSelf = self;
        self.block = ^{
            [weakSelf animationStart];
        };
        [self layoutIfNeeded];
    }
    return self;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIImageView *)imgView{
    
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (void)animationStart{

    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = CGRectMake(SCREEN_WIDTH-169, 0, 164, bgHeight);
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        NSMutableArray <UIImage *> *array = [[NSMutableArray alloc] init];
        for (int i=0; i<18; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"animation_%i.jpg",i+1]];
            [array addObject:image];
        }
        self.imgView.animationImages = array;
        self.imgView.animationDuration = 5;
        self.imgView.animationRepeatCount = 1;
        [self.imgView startAnimating];

    }];
}

@end
