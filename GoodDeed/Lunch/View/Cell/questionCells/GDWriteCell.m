//
//  GDWriteCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDWriteCell.h"

@interface GDWriteCell()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeightConstraint;

@end
@implementation GDWriteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.textView.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10);
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
    self.textView.delegate = self;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.textView becomeFirstResponder];
    
}

- (void)setModel:(GDFirstQuestionListModel *)model{
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    CGSize size = [textView sizeThatFits:CGSizeMake(SCREEN_WIDTH-60, MAXFLOAT)];
    self.textHeightConstraint.constant = size.height>45?size.height+5:45;
    [self.contentView layoutIfNeeded];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        if (textView.text&&textView.text.length>0) {
            self.model.writeModel.content = textView.text;
            [self finishAnswer];
            [textView resignFirstResponder];

        }
        return NO;
    }
    
    return YES;
}

@end
