//
//  HKTextView.m
//  TestText
//
//  Created by HK on 2018/8/12.
//  Copyright © 2018 HK. All rights reserved.
//

#import "GDTextView.h"
//#import "GDEditTableViewController.h"

#define EdgeInsets UIEdgeInsetsMake(8, 8, 8, 8 )


@interface GDTextView () <UITextViewDelegate>


//@property (strong, nonatomic) UILabel *placeholder;


@end

@implementation GDTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endediting:) name:UITextViewTextDidEndEditingNotification object:self];
    }
    
    return self;
}

- (void)endediting:(NSNotification *)notification{
    
    [self updateDeleteEnableWithObject:nil];
//    UITableView *tabView = (UITableView *)[GDHelper getTargetView:[UITableView class] view:self];
//    if (tabView) {
//        for (UITableViewCell *cell in tabView.visibleCells) {
//            cell.selected = NO;
//        }
//    }

}

- (void)updateDeleteEnableWithObject:(UITextView *)obj{
    
    UIViewController *vc = [GDHelper getSuperVc:self];
    NSString *classStr = @"GDEditTableViewController";
    NSString *selStr = @"updateDeleteEnableWith:";
    SEL sel = NSSelectorFromString(selStr);
    if (vc&&[vc isKindOfClass:NSClassFromString(classStr)]) {
        if ([vc respondsToSelector:sel]) {
            [vc performSelector:sel withObject:obj];
        }
    }

//    if ([vc isKindOfClass:[GDEditTableViewController class]]) {
//        GDEditTableViewController *editVc = (GDEditTableViewController *)vc;
//        [editVc updateDeleteEnableWith:obj];
//    }
}

- (void)initialization
{
    self.delegate = self;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginEdit:)]];
    self.adjustsFontForContentSizeCategory = YES;
    self.scrollEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

- (void)beginEdit:(UITapGestureRecognizer *)gesture
{
    if (!self.isFirstResponder) {
        if ([self.text isEqualToString:self.placeholer]) {
            self.selectedRange = NSMakeRange(0, 0);
        } else {
            self.selectedRange = NSMakeRange(self.text.length - 1, 0);
        }
        [self becomeFirstResponder];
    } else {
        if ([self.text isEqualToString:self.placeholer]) {
            self.selectedRange = NSMakeRange(0, 0);
        }
    }
}

#pragma mark - Setter, Getter
- (void)setPlaceholer:(NSString *)placeholer
{
    _placeholer = placeholer;
    self.text = placeholer;
}

- (NSString *)gdText
{

    if ([self.text isEqualToString:self.placeholer]) {
        return @"";
    } else {
        return self.text;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self updateDeleteEnableWithObject:textView];
//    UITableViewCell *cell = (UITableViewCell *)[GDHelper getTargetView:[UITableViewCell class] view:self];
//    if (cell) {
//        cell.selected = YES;
//    }
    // 移动光标到起始位置
//    if ([self.placeholer isEqualToString:textView.text]) {
//        self.selectedRange = NSMakeRange(0, 0);
//    } else {
//        self.selectedRange = NSMakeRange(textView.text.length - 1, 0);
//    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.didEndEdit) {
        self.didEndEdit(self.gdText);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([textView.text isEqualToString:self.placeholer]) {
        if (text.length == 0) {
            return NO;
        } else {
            textView.text = @"";
        }
    }
    
    NSMutableString *mutableText = [[NSMutableString alloc] initWithString:textView.text];
//    if (mutableText&&mutableText.length>0) {
//
//    }else{
//        return NO;
//    }
    [mutableText replaceCharactersInRange:range withString:text];

    if (mutableText.length == 0) {
        textView.text = self.placeholer;
        self.selectedRange = NSMakeRange(0, 0);
        if (self.updateHeight) {
            self.updateHeight([self sizeOfText:textView.text]);
        }
        if (self.didChanged) self.didChanged(nil);
        return NO;
    }

    if (self.didChanged) self.didChanged(mutableText);
    if (self.updateHeight) self.updateHeight([self sizeOfText:mutableText]);

    return YES;
}

- (CGSize)sizeOfText:(NSString *)text
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds) - EdgeInsets.left - EdgeInsets.right, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil].size;
    return CGSizeMake(size.width, size.height + EdgeInsets.top + EdgeInsets.bottom + 0.5);
}


- (CGSize)textViewSize
{
    return [self sizeOfText:self.text];
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
