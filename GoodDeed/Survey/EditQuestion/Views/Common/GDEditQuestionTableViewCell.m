//
//  GDEditQuestionTableViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/8/26.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditQuestionTableViewCell.h"

@interface GDEditQuestionTableViewCell ()


@property (strong, nonatomic) MASConstraint *textViewHeightCST;
@property (strong, nonatomic) GDTextView *textView;

@end

@implementation GDEditQuestionTableViewCell
@synthesize viewModel = _viewModel;
@synthesize updateHeight = _updateHeight;
@synthesize deleteEvent = _deleteEvent;

+ (GDEditQuestionTableViewCell *)questionTableViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GDEditQuestionTableViewCell" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupViews];
 
}

- (void)setViewModel:(GDEditBaseViewModel *)viewModel
{
    if ([viewModel isKindOfClass:[GDEditQuestionViewModel class]]) {
       _viewModel = viewModel;

        GDEditQuestionViewModel *question = (GDEditQuestionViewModel *)viewModel;
        self.textView.placeholer = question.placeholder;
        
        if (question.text.length > 0) {
            self.textView.text = question.text;
        }

        CGSize textViewSize = [self.textView textViewSize];
        question.cellHeight = textViewSize.height + 30 * 2;
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (textViewSize.height < 64.f) {
                self.textViewHeightCST = make.height.equalTo(@(64.f));
            } else {
                self.textViewHeightCST = make.height.equalTo(@(textViewSize.height));
            }
        }];
        if (self.updateHeight) self.updateHeight(self);
        
        __weak typeof(question) weak_question = question;
        self.textView.didChanged = ^(NSString *text) {
            weak_question.text = text;
        };
    }
}


- (void)setupViews
{
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(45.f);
        make.right.equalTo(self.contentView).with.offset(-45.f);
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
        weak_self.viewModel.cellHeight = size.height + 30 * 2;
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
        _textView.standardHeight = 64.f;
    }
    return _textView;
}



@end
