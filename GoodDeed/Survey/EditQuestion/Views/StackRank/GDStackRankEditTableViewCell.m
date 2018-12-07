//
//  GDStackRangeEditTableViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/9/6.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDStackRankEditTableViewCell.h"
#import "GDEditTextViewModel.h"

@interface GDStackRankEditTableViewCell () <UITextFieldDelegate>
@end

@implementation GDStackRankEditTableViewCell
@synthesize viewModel = _viewModel;
@synthesize updateHeight = _updateHeight;
@synthesize deleteEvent = _deleteEvent;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textField.layer.cornerRadius = 33.5/2.f;
    self.textField.layer.masksToBounds = YES;
    [self.textField setValue:[UIColor colorWithHex:0x666666] forKeyPath:@"_placeholderLabel.textColor"];
    [self.textField setValue:[UIFont systemFontOfSize:20] forKeyPath:@"_placeholderLabel.font"];
    self.textField.delegate = self;
    
}

- (IBAction)deleteAction:(id)sender {
    if (self.deleteEvent) {
        self.deleteEvent(self, self.viewModel);
    }
}

- (void)setViewModel:(GDEditBaseViewModel *)viewModel
{
    if ([viewModel isKindOfClass:[GDEditTextViewModel class]]) {
        _viewModel = viewModel;
        self.deleteButton.hidden = !viewModel.deleteEnabel;
        self.textField.text = [(GDEditTextViewModel *)viewModel text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *tempStr = [[NSMutableString alloc] initWithString:textField.text];
    [tempStr replaceCharactersInRange:range withString:string];
    [(GDEditTextViewModel *)self.viewModel setText:tempStr];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.deleteButton.hidden = !selected;
    // Configure the view for the selected state
}

@end
