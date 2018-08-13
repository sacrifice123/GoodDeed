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
    self.imgView.layer.borderWidth = 4;

}

- (void)setModel:(GDOrganModel *)model{
    _model = model;
    [self.imgView gd_setImageWithUrlStr:model.imgUrl];
    self.imgView.layer.borderColor = [UIColor colorWithHexString:model.isSelected?@"#2BA9E0":@"FFFFFF"].CGColor;

    
}


@end
