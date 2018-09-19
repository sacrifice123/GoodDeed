//
//  GDEditQuestionCollectionViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/9/5.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditQuestionCollectionViewCell.h"

@interface GDEditQuestionCollectionViewCell ()

@property (strong, nonatomic) MASConstraint *textViewHeightCST;
@property (strong, nonatomic) GDTextView *textView;

@end

@implementation GDEditQuestionCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}


- (void)setupViews
{
    
    self.backgroundColor = [UIColor greenColor];
    
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(24);
        make.right.equalTo(self.contentView).with.offset(-24.f);
        make.centerY.equalTo(self.contentView);
        self.textViewHeightCST = make.height.equalTo(@(64.f));
    }];
    
    __weak typeof(self) weak_self = self;
    self.textView.updateHeight = ^(CGSize size) {
        [weak_self.textViewHeightCST uninstall];
        
        [weak_self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (size.height < 64.f) {
                weak_self.textViewHeightCST = make.height.equalTo(@(64.f));
            } else {
                weak_self.textViewHeightCST = make.height.equalTo(@(size.height));
            }
            [weak_self.textView becomeFirstResponder];
        }];
        weak_self.viewModel.cellHeight = size.height;
        if (weak_self.updateHeight) {
            weak_self.updateHeight(weak_self);
        }
    };
}


- (GDTextView *)textView
{
    if (!_textView) {
        _textView = [[GDTextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:20];
        _textView.textColor = [UIColor colorWithHex:0x999999];
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.backgroundColor = [UIColor purpleColor];
        _textView.placeholer = @"点击此处\n准确编辑你的提问";
        _textView.standardHeight = 64.f;
    }
    return _textView;
}


@end
