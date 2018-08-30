//
//  GDWriteCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDWriteCell.h"

@interface GDWriteCell()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
@implementation GDWriteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
}

@end
