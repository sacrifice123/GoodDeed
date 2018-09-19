//
//  GDBoundRangeCollectionViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/9/5.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDBoundRangeCollectionViewCell.h"
#import "GDTextView.h"

@interface GDBoundRangeCollectionViewCell ()

@property (strong, nonatomic) UIView *indicatorView;
@property (strong, nonatomic) GDTextView *textView;
@property (strong, nonatomic) UIButton *deleteButton;

@end

@implementation GDBoundRangeCollectionViewCell
@synthesize viewModel = _viewModel;
@synthesize updateHeight = _updateHeight;
@synthesize deleteEvent = _deleteEvent;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setViewModel:(GDBoundRangeItem *)viewModel
{
    _viewModel  = viewModel;
    
    self.deleteButton.hidden = !viewModel.deleteEnabel;
}

- (void)deleteAction
{
    if (self.deleteEvent) self.deleteEvent(self, self.viewModel);
}


- (void)setupViews
{
    [self.contentView addSubview:self.indicatorView];
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.deleteButton];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(@1.f);
        make.height.equalTo(@11.f);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.indicatorView.mas_bottom);
        make.width.lessThanOrEqualTo(@56.f);
        make.bottom.equalTo(self.deleteButton.mas_top);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(@31.f);
        make.height.equalTo(@31.f);
    }];
    
    self.contentView.clipsToBounds = NO;
    self.clipsToBounds = NO;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor colorWithHex:0xB7B7B7];
    }
    
    return _indicatorView;
}

- (GDTextView *)textView
{
    if (!_textView) {
        _textView = [[GDTextView alloc] init];
        _textView.placeholer = @"点击编辑";
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.textColor = [UIColor colorWithHex:0x999999];
        _textView.font = [UIFont systemFontOfSize:20.f];
    }
    return _textView;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"survey_delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}


@end
