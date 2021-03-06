//
//  GDOrgAnimationView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDOrgAnimationView.h"
#import "GDPGChooseViewController.h"
#import "GDOrganModel.h"
#import "UIView+LXShadowPath.h"
#define bgHeight 233
@interface GDOrgAnimationView()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray *organList;
@property (nonatomic, strong) UIProgressView *progressView;

@end
@implementation GDOrgAnimationView

static GDOrgAnimationView *_view;

+ (GDOrgAnimationView *)sharedView {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _view = [[GDOrgAnimationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _view.tag = 666;
        
    });
    if (!_view.isAnimation) {
        _view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }else{
        _view.backgroundColor = [UIColor clearColor];
    }
    return _view;
}

+ (void)destory {
    _view = nil;
}

- (BOOL)isAnimation{
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:GDAnimationStatus] boolValue];
}

- (NSArray *)organList {
    
    if (_organList == nil) {
        _organList = [[NSArray alloc] init];
    }
    return _organList;
}

- (instancetype)initWithFrame:(CGRect)frame {
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
        //[GDHelper addShadowToView:self.bgView withColor:[UIColor colorWithRed:10.0/255 green:0 blue:0 alpha:0.14]];
        [self.bgView  LX_SetShadowPathWith:[UIColor colorWithHexString:@"#777777"] shadowOpacity:0.5 shadowRadius:1.5 shadowSide:LXShadowPathAllSide shadowPathWidth:1.5];

        [self.bgView addSubview:self.progressView];
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(10);
             make.right.bottom.equalTo(self.bgView).offset(-10);
            make.height.equalTo(@8.5);
        }];
        //提前请求
        [GDLunchManager getOrganListWithCompletionBlock:^(NSArray *list) {
            self.organList = list;
        }];

//        __weak typeof(self) weakSelf = self;
//        self.animationblock = ^(NSInteger index) {
//            [weakSelf animationStart:index completion:^(BOOL finished) {
//                
//            }];
//        };
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
        _progressView.trackTintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        _progressView.progressTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];

    }
    return _progressView;
}

- (void)animationStart:(NSInteger)index completion:(void (^)(BOOL))block{

  //  [self.bgView bringSubviewToFront:self.progressView];
    GDSurveyModel *model = [GDLunchManager sharedManager].surveyModel;
    NSArray *suveryList = [GDLunchManager sharedManager].suveryList;
    [UIView animateWithDuration:0.5 animations:^{
        if (self.isAnimation||model.isHome) {
            self.imgView.image = [UIImage imageNamed:@"progress_image"];
            self.progressView.hidden = NO;
            self.progressView.progress = (1.0*index/(suveryList.count+!model.isHome));//(suveryList.count>0?(1.0*index/(suveryList.count+1)):1.0*index/suveryList.count);

        }else{
             self.progressView.hidden = YES;
        }
        self.bgView.frame = CGRectMake(SCREEN_WIDTH-169, 0, 164, bgHeight);
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        if (!self.isAnimation&&!self.imgView.isAnimating&&!model.isHome) {//轮播公益机构图片
            NSMutableArray <UIImage *> *array = [[NSMutableArray alloc] init];
            for (int i=1; i<18; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"animation_%i.jpg",i+1]];
                [array addObject:image];
            }
            self.imgView.animationImages = array;
            self.imgView.animationDuration = 2.0;
            self.imgView.animationRepeatCount = 1;
            [self.imgView startAnimating];
            self.imgView.image = [UIImage imageNamed:@"tap_image"];

        }else{//答题模式
            if ((block&&self.isAnimation)||model.isHome) {
                sleep(1.5);
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.bgView.frame = CGRectMake(SCREEN_WIDTH-169, -bgHeight, 164, bgHeight);
                } completion:^(BOOL finished) {
                    block(YES);
                    [self removeFromSuperview];
                }];

            }

        }

    }];

}

- (void)removeAnimationView{

}
- (void)imgViewTap:(UITapGestureRecognizer *)gesture{
    
    UIImageView *view = (UIImageView *)gesture.view;
    __weak typeof(self) weakSelf = self;
    if (!view.isAnimating&&!self.isAnimation) {//轮播停止后点击选择公益组织
        UIViewController *vc = [GDHelper getSuperVc:view];
        GDPGChooseViewController *pgVc = [[GDPGChooseViewController alloc] init];
        pgVc.isClose = YES;
        for (GDOrganModel *model in self.organList) {
            model.isSelected = NO;
        }
        pgVc.organList = self.organList;
        [vc presentViewController:pgVc animated:YES completion:^{
            weakSelf.finishBlock(YES);
        }];
    }
    
}

- (void)dealloc{
    
    NSLog(@"animation_dealloc");
}
@end
