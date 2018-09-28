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
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneySubLabel;

@end
@implementation GDLeftHeaderView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    __weak typeof(self) weakSelf = self;
    self.imageBlock = ^(UIImage *image) {
        [weakSelf.imageButton setBackgroundImage:image forState:0];
        
    };
    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
    self.totalMoneyLabel.text = model.money;
    self.totalMoneySubLabel.text = model.money;
}


- (IBAction)chooseImage:(id)sender {
    
    if (self.chooseBlock) {
        self.chooseBlock();
    }
}

@end
