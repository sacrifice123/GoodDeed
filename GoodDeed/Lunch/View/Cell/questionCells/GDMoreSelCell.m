//
//  GDMoreSelCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDMoreSelCell.h"

@interface GDMoreSelCell()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end
@implementation GDMoreSelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GDFirstQuestionListModel *)model{
    
    if (model.firstOptionList.count>model.index) {
        self.contentLabel.text = model.firstOptionList[model.index];
    }
}

@end
