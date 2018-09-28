//
//  GDGroupListItemCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGroupListItemCell.h"

@interface GDGroupListItemCell()

@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneySubLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *watchView;

@end
@implementation GDGroupListItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(GDGroupListModel *)model{
    _model = model;
    self.nickLabel.text = model.uidName;
    [self.imageView gd_setImageWithUrlStr:model.imgUrl];
    self.totalMoneyLabel.text = model.money;
    self.totalMoneySubLabel.text = model.money;
    if (self.isMore) {
        self.watchView.hidden = !(model.index.row == 3);
        self.nickLabel.hidden = (model.index.row == 3);

    }
}
@end
