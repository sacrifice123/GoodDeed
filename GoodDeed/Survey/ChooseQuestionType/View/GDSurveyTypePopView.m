//
//  GDSurveyTypePopView.m
//  GoodDeed
//
//  Created by HK on 2018/8/10.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDSurveyTypePopView.h"
#import "GDSurveyTypeCollectionViewCell.h"

@interface GDSurveyTypePopView ()

@property (strong, nonatomic) GDSurveyTypeCollectionViewCell *topPopView;
@property (strong, nonatomic) GDSurveyTypeCollectionViewCell *botPopView;

@property (strong, nonatomic) MASConstraint *someViewWidthCst;

@end




@implementation GDSurveyTypePopView

+ (GDSurveyTypePopView *)showSurveyTypePopViewWithTopImage:(UIImage *)topImage
                                                   topName:(NSString *)topName
                                                  botImage:(UIImage *)botImage
                                                   botName:(NSString *)botName
                                                   selected:(GDSurveyTypePopViewSelectedBlock)selected
                                                   dismiss:(dispatch_block_t)dismiss
{
    GDSurveyTypePopView *popView = [[GDSurveyTypePopView alloc] initWithTopImage:topImage topName:topName botImage:botImage botName:botName selected:selected dismiss:dismiss];
    [popView show];
    return popView;
}


- (instancetype)initWithTopImage:(UIImage *)topImage
                         topName:(NSString *)topName
                        botImage:(UIImage *)botImage
                         botName:(NSString *)botName
                        selected:(GDSurveyTypePopViewSelectedBlock)selected
                         dismiss:(dispatch_block_t)dismiss
{
    self = [super init];
    if (self) {
        [self setupViews];
        
        _topPopView.imageView.image = topImage;
        _topPopView.nameLabel.text = topName;
        _botPopView.imageView.image = botImage;
        _botPopView.nameLabel.text = botName;
        _selected = selected;
        _dismiss = dismiss;
    }
    
    return self;
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    self.topPopView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.botPopView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.topPopView.transform = CGAffineTransformIdentity;
            self.botPopView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) { }];
}

#pragma mark - Action
- (void)selectedEvent:(UITapGestureRecognizer *)gesture
{
    if (self.selected) {
        self.selected(gesture.view.tag - 100);
    }
    [self dismissEvent];
}

- (void)dismissEvent
{
    if (self.dismiss) {
        self.dismiss();
    }
    [self removeFromSuperview];
    self.selected = nil;
    self.dismiss = nil;
}

#pragma mark - Private

- (void)setupViews
{
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];

    [self addSubview:self.topPopView];
    [self addSubview:self.botPopView];
    
    [self.topPopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@GDScaleValue(181.5));
        make.height.equalTo(@(GDScaleValue(181.5) + 7 + 22.5));
        make.bottom.equalTo(self.mas_centerY).with.offset(GDScaleValue(-25.f));
    }];

    [self.botPopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@GDScaleValue(181.5));
        make.height.equalTo(@(GDScaleValue(181.5) + 7 + 22.5));
        make.top.equalTo(self.mas_centerY).with.offset(GDScaleValue(20.f));
    }];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissEvent)]];
    [self.topPopView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedEvent:)]];
    [self.botPopView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedEvent:)]];
}

#pragma mark - Setter, Getter

- (GDSurveyTypeCollectionViewCell *)topPopView
{
    if (!_topPopView) {
        _topPopView = [GDSurveyTypeCollectionViewCell surveyTypeCollectionViewCell];
        _topPopView.tag = 100;
    }
    
    return _topPopView;
}

- (GDSurveyTypeCollectionViewCell *)botPopView
{
    if (!_botPopView) {
        _botPopView = [GDSurveyTypeCollectionViewCell surveyTypeCollectionViewCell];
        _botPopView.tag = 101;
    }
    return _botPopView;
}

@end
