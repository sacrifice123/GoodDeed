//
//  GDQuestionDescCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuestionDescCell.h"

@interface GDQuestionDescCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation GDQuestionDescCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshData:(GDQuestionModel *)model{
    
    self.model = model;
    self.titleLabel.text = model.questionName;
}

@end
