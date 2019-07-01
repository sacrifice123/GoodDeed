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
@property (weak, nonatomic) IBOutlet UIImageView *selectimgView;

@end
@implementation GDMoreSelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshData:(GDQuestionModel *)model{
    self.model = model;
    if (model.options.count>model.index) {
        GDOptionModel *optionModel = model.options[model.index];
        self.contentLabel.text = optionModel.optionName;
        BOOL isSelected = [model.writeModel.optionOrders containsObject:optionModel.order];
        [self setOptionSelectedStatus:isSelected];
    }
}

- (void)setOptionSelectedStatus:(BOOL)isSelected{
       self.contentLabel.textColor = isSelected?[UIColor colorWithHexString:@"#2E3192"]:[UIColor colorWithHexString:@"#999999"];
    self.selectimgView.image = [UIImage imageNamed:isSelected?@"more_selected":@"more_unSelect"];

}

- (void)setHighlighted:(BOOL)highlighted{
    
    self.contentLabel.textColor = highlighted?[UIColor colorWithHexString:@"#2E3192"]:[UIColor colorWithHexString:@"#999999"];
    self.selectimgView.highlighted = highlighted;

}

//- (void)refreshHighlightStatus:(BOOL)isHighlighted{
//
//    self.contentLabel.textColor = isHighlighted?[UIColor colorWithHexString:@"#2E3192"]:[UIColor colorWithHexString:@"#999999"];
//    self.selectButton.highlighted = isHighlighted;
//}

@end
