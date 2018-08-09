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
    
    self.imgView.layer.borderWidth = 0.5;
    self.imgView.layer.borderColor = [UIColor colorWithHexString:@"BBBBBB"].CGColor;
}

- (void)setModel:(GDOrganModel *)model{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",GDBaseUrl,model.imgUrl?:@""]]];
    
}

@end
