//
//  GDLeftHeaderView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLeftHeaderView.h"

@interface GDLeftHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end
@implementation GDLeftHeaderView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    __weak typeof(self) weakSelf = self;
    self.imageBlock = ^(UIImage *image) {
        [weakSelf.imageButton setBackgroundImage:image forState:0];
        
    };
}


- (IBAction)chooseImage:(id)sender {
    
    if (self.chooseBlock) {
        self.chooseBlock();
    }
}

@end
