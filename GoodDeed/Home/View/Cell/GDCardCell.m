//
//  GDCardCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDCardCell.h"

@interface GDCardCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headBgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *organImgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation GDCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;

    
}

//点击跳转外链
- (IBAction)learnMore:(id)sender {
    
    
    
}

//1.如果是注册登录后推送的card，点击切换组织机构 2.如果是回答问卷里推送的card，点击跳转外链
- (IBAction)switchToCause:(id)sender {
    
    
    
}

@end
