//
//  GDPGChooseCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/26.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDPGChooseCell.h"

@interface GDPGChooseCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@end
@implementation GDPGChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setModel:(GDOrganModel *)model{
    _model = model;
    [self.imgView gd_setImageWithUrlStr:model.imgUrl];
    self.imgView.layer.borderWidth = model.isSelected?4:0.5;
    self.imgView.layer.borderColor = [UIColor colorWithHexString:model.isSelected?@"#2BA9E0":@"#BBBBBB"].CGColor;

    
}


@end
