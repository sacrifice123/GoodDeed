//
//  GDChooseMultipleAnswerTableViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDChooseMultipleAnswerTableViewCell.h"

@interface GDChooseMultipleAnswerTableViewCell ()

@property (strong, nonatomic) MASConstraint *textViewHeightCST;
@property (strong, nonatomic) UIImageView *selectImageView;
@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) GDTextView *textView;

@end


@implementation GDChooseMultipleAnswerTableViewCell
@synthesize viewModel = _viewModel;
@synthesize updateHeight = _updateHeight;
@synthesize deleteEvent = _deleteEvent;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    
    return self;;
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
        answer.cellHeight = textViewSize.height;
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

- (void)setupViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.selectImageView];
    [self.contentView addSubview:self.textView];
    [self addSubview:self.deleteButton];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(61.f);
        make.top.equalTo(self.contentView).with.offset(0.5);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
    }];

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectImageView.mas_right).with.offset(10.f);
        make.right.equalTo(self.deleteButton.mas_left).with.offset(-10.f);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@36);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-42.5);
        make.height.equalTo(@31);
        make.width.equalTo(@31);
    }];
    
    
    __weak typeof(self) weak_self = self;
    self.textView.updateHeight = ^(CGSize size) {
        [weak_self.textViewHeightCST uninstall];
        [weak_self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            weak_self.textViewHeightCST = make.height.equalTo(@(size.height));
            [weak_self.textView becomeFirstResponder];
        }];
        weak_self.viewModel.cellHeight = size.height;
        if (weak_self.updateHeight) {
            weak_self.updateHeight(weak_self);
        }
    };
}

- (void)deleteAction
{
    if (self.deleteEvent) self.deleteEvent(self, self.viewModel);
}

- (UIImageView *)selectImageView
{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"survey_multp_option"]];
    }
    return _selectImageView;
}

- (GDTextView *)textView
{
    if (!_textView) {
        _textView = [[GDTextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:20];
        _textView.textColor = [UIColor colorWithHex:0x999999];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.standardHeight = 36.f;
        //_textView.backgroundColor = [UIColor greenColor];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.deleteButton.hidden = !selected;
    
}


@end
