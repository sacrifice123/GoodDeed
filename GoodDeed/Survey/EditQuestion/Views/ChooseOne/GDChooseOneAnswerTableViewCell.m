//
//  GDChooseOneAnswerTableViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDChooseOneAnswerTableViewCell.h"
#import "GDTextView.h"
#import "GDEditTextViewModel.h"

@interface GDChooseOneAnswerTableViewCell ()

@property (strong, nonatomic) MASConstraint *textViewHeightCST;

@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) GDTextView *textView;

@end

@implementation GDChooseOneAnswerTableViewCell
@synthesize viewModel = _viewModel;
@synthesize updateHeight = _updateHeight;
@synthesize deleteEvent = _deleteEvent;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    
    return self;
}


- (void)setViewModel:(GDEditBaseViewModel *)viewModel
{
    if ([viewModel isKindOfClass:[GDEditTextViewModel class]]) {
        _viewModel = viewModel;
        

        GDEditTextViewModel *answer = (GDEditTextViewModel *)viewModel;
        self.textView.placeholer = answer.placeholder;
        if (answer.text.length > 0) {
            self.textView.text = answer.text;
        }
        CGSize textViewSize = [self.textView textViewSize];
        answer.cellHeight = textViewSize.height + 17.5 * 2;
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (textViewSize.height < 36.f) {
                self.textViewHeightCST = make.height.equalTo(@(36.f));
            } else {
                self.textViewHeightCST = make.height.equalTo(@(textViewSize.height));
            }
        }];
        if (self.updateHeight) self.updateHeight(self);
        __weak typeof(answer) weak_answer = answer;
        self.textView.didChanged = ^(NSString *text) {
            weak_answer.text = text;
        };
        
        self.deleteButton.hidden = !answer.deleteEnabel;
    }
}

- (void)deleteAction
{
    if (self.deleteEvent) self.deleteEvent(self, self.viewModel);
}


- (void)setupViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorWithHex:0xEFEFEF];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 45.f, 0, 45.f));
    }];

    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@36);
    }];
    
    [self addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top).with.offset(-8);
    }];
    
    
    __weak typeof(self) weak_self = self;
    self.textView.updateHeight = ^(CGSize size) {
        [weak_self.textViewHeightCST uninstall];
        [weak_self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            weak_self.textViewHeightCST = make.height.equalTo(@(size.height));
            [weak_self.textView becomeFirstResponder];
        }];
        weak_self.viewModel.cellHeight = size.height + 17.5 * 2;
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
        _textView.textColor = [UIColor colorWithHex:0x333333];
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.standardHeight = 36.f;
        _textView.backgroundColor = [UIColor clearColor];
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
