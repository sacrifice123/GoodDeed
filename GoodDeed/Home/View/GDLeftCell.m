//
//  GDLeftCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLeftCell.h"
#import "GDLeftModel.h"
#import "GDOrganModel.h"

@interface GDLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *orgnImageView;

@end
@implementation GDLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GDLeftModel *)model{
    
    _model = model;
    self.titleLabel.text = model.title;
    if (model.index.row == 1) {
        self.orgnImageView.hidden = NO;
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:organModelCache];
        [self.orgnImageView gd_setImageWithUrlStr:[dic objectForKey:@"imgUrl"]];
    }else{
        self.orgnImageView.hidden = YES;
    }
}


@end
