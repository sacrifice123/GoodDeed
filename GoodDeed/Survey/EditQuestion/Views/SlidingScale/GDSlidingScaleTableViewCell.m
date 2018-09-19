//
//  GDSlidingScaleTableViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/9/4.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDSlidingScaleTableViewCell.h"
#import "GDTextView.h"

@interface GDSlidingScaleTableViewCell ()

@property (strong, nonatomic) UIView *sliderView;
@property (strong, nonatomic) UIView *indicatorView;
@property (strong, nonatomic) NSArray <UIView *> *scaleViews;
@property (strong, nonatomic) GDTextView *leftTextView;
@property (strong, nonatomic) GDTextView *rightTextView;

@end

@implementation GDSlidingScaleTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.sliderView];
    [self.contentView addSubview:self.indicatorView];
    [self.contentView addSubview:self.leftTextView];
    [self.contentView addSubview:self.rightTextView];
    
    CGFloat indicatorSize = 76.f;
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(@(indicatorSize));
        make.height.equalTo(@(indicatorSize));
    }];
    self.indicatorView.layer.cornerRadius = indicatorSize / 2.f;
    
    CGFloat sliderHeight = 12.f;
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.indicatorView);
        make.left.equalTo(self.contentView).with.offset(GDScaleValue(44.f));
        make.right.equalTo(self.contentView).with.offset(GDScaleValue(-44.f));
        make.height.equalTo(@(sliderHeight));
    }];
    self.sliderView.layer.cornerRadius = sliderHeight / 2.f;
    
    [self.leftTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10.f);
        make.top.equalTo(self.indicatorView.mas_bottom).with.offset(25.f);
        make.height.equalTo(@36.f);
        make.width.equalTo(@GDScaleValue(94.f));
    }];
    
    [self.rightTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-10.f);
        make.centerY.equalTo(self.leftTextView);
        make.height.equalTo(@36.f);
        make.width.equalTo(@GDScaleValue(94.f));
    }];

    NSInteger count = self.scaleViews.count;
    CGFloat margin = GDScaleValue(43);
    CGFloat width = 0.5;
    CGFloat space = (SCREEN_WIDTH - margin * 2 - width * count) / (count - 1);
    UIView *preScaleView = nil;
    for (UIView *view in self.scaleViews) {
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor colorWithHex:0xB7B7B7];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.indicatorView.mas_bottom).with.offset(4.f);
            make.width.equalTo(@(width));
            make.height.equalTo(@(11.f));
            if (view == [self.scaleViews firstObject]) {
                make.left.equalTo(self.contentView).with.offset(margin);
            } else {
                make.left.equalTo(preScaleView.mas_right).with.offset(space);
            }
        }];
        preScaleView = view;
    }
    
    
}

#pragma mark - Setter, Getter
- (UIView *)sliderView
{
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
        _sliderView.backgroundColor = [UIColor colorWithHex:0xDDDDDD];
    }
    return _sliderView;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor colorWithHex:0x2E3192];
    }
    
    return _indicatorView;
}

- (NSArray<UIView *> *)scaleViews
{
    if (!_scaleViews) {
        NSMutableArray *views = [[NSMutableArray alloc] init];
        for (NSInteger index = 0; index < 11; index ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor colorWithHex:0xB7B7B7];
            [views addObject:view];
        }
        _scaleViews = [views copy];
    }
    return _scaleViews;
}

- (GDTextView *)leftTextView
{
    if (!_leftTextView) {
        _leftTextView = [[GDTextView alloc] init];
        _leftTextView.placeholer = @"点击编辑";
        _leftTextView.font = [UIFont systemFontOfSize:20.f];
        _leftTextView.textColor = [UIColor colorWithHex:0x999999];
    }
    return _leftTextView;
}

- (GDTextView *)rightTextView
{
    if (!_rightTextView) {
        _rightTextView = [[GDTextView alloc] init];
        _rightTextView.placeholer = @"点击编辑";
        _rightTextView.font = [UIFont systemFontOfSize:20.f];
        _rightTextView.textColor = [UIColor colorWithHex:0x999999];
    }
    return _rightTextView;
}

@end
