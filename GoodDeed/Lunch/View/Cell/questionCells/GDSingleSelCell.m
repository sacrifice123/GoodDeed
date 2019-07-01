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

- (void)refreshData:(GDQuestionModel *)model{
    
    self.model = model;
    if (model.options.count>model.index) {
        GDOptionModel *optionModel = model.options[model.index];
        self.contentLabel.text = optionModel.optionName;
    }
    if (self.isHighlighted) {
        [self.contentView setBackgroundColor:[UIColor redColor]];
    }else{
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
}


- (void)setHighlighted:(BOOL)highlighted{

    self.contentLabel.backgroundColor = highlighted?[UIColor colorWithHexString:@"#777777"]:[UIColor colorWithHexString:@"#EFEFEF"];
    self.contentLabel.textColor = highlighted?[UIColor whiteColor]:[UIColor colorWithHexString:@"#333333"];

}

- (void)setSelected:(BOOL)selected{
    
    self.contentLabel.backgroundColor =  selected?[UIColor colorWithHexString:@"#2E3192"]:[UIColor colorWithHexString:@"#EFEFEF"];
    self.contentLabel.textColor = selected?[UIColor whiteColor]:[UIColor colorWithHexString:@"#333333"];


}
@end
