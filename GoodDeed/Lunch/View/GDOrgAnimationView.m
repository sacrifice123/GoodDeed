//
//  GDOrgAnimationView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDOrgAnimationView.h"
#import "GDPGChooseViewController.h"
#import "GDLunchManager.h"
#import "GDOrganModel.h"

#define bgHeight 233
@interface GDOrgAnimationView()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray *organList;
@property (nonatomic, strong) UIProgressView *progressView;

@end
@implementation GDOrgAnimationView

- (NSArray *)organList{
    
    if (_organList == nil) {
        _organList = [[NSArray alloc] init];
    }
    return _organList;
}

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
        [self.bgView addSubview:self.progressView];
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(10);
             make.right.bottom.equalTo(self.bgView).offset(-10);
            make.height.equalTo(@8.5);
        }];
        __weak typeof(self) weakSelf = self;
        self.animationblock = ^{
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
        _imgView.image = [UIImage imageNamed:@"animation_1.jpg"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewTap:)];
        _imgView.userInteractionEnabled = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [_imgView addGestureRecognizer:tap];
    }
    return _imgView;
}

- (UIProgressView *)progressView{
    
    if (_progressView == nil) {
        _progressView =  [[UIProgressView alloc] init];
        _progressView.layer.cornerRadius = 2;
        _progressView.layer.masksToBounds = YES;
        _progressView.progress = 1/6.0;
        _progressView.trackTintColor = [UIColor blackColor];
        _progressView.progressTintColor = [UIColor greenColor];

    }
    return _progressView;
}

- (void)animationStart{

    //提前请求
    [GDLunchManager getOrganListWithCompletionBlock:^(NSArray *list) {
        self.organList = list;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = CGRectMake(SCREEN_WIDTH-169, 0, 164, bgHeight);
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        NSMutableArray <UIImage *> *array = [[NSMutableArray alloc] init];
        for (int i=1; i<18; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"animation_%i.jpg",i+1]];
            [array addObject:image];
        }
        self.imgView.animationImages = array;
        self.imgView.animationDuration = 3.5;
        self.imgView.animationRepeatCount = 1;
        [self.imgView startAnimating];
        self.imgView.image = [UIImage imageNamed:@"tap_image"];


    }];
}

- (void)imgViewTap:(UITapGestureRecognizer *)gesture{
    
    UIImageView *view = (UIImageView *)gesture.view;
    __weak typeof(self) weakSelf = self;
    if (!view.isAnimating) {//轮播停止后点击选择公益组织
        UIViewController *vc = [GDHelper getSuperVc:view];
        GDPGChooseViewController *pgVc = [[GDPGChooseViewController alloc] init];
        for (GDOrganModel *model in self.organList) {
            model.isSelected = NO;
        }
        pgVc.organList = self.organList;
        [vc presentViewController:pgVc animated:YES completion:^{
            
            weakSelf.finishBlock(YES);
        }];
    }
    
}
@end
