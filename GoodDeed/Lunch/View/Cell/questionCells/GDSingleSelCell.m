//
//  GDSingleSelCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSingleSelCell.h"

@interface GDSingleSelCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation GDSingleSelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //
}


- (void)setModel:(GDFirstQuestionListModel *)model{
    
    if (model.firstOptionList.count>model.index) {
        self.contentLabel.text = model.firstOptionList[model.index];
    }
    if (self.isHighlighted) {
        [self.contentView setBackgroundColor:[UIColor redColor]];
    }else{
         [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
}
@end
