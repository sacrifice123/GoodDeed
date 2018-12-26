//
//  GDSurveyCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/8.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSurveyCell.h"

@interface GDSurveyCell()
@property (weak, nonatomic) IBOutlet UIView *transitionView;
@property (weak, nonatomic) IBOutlet UILabel *surveyTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *surveyBgImgView;
@property (strong, nonatomic) GDFirstSurveyModel *model;

@end
@implementation GDSurveyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

- (void)setCardModel:(GDHomeModel *)cardModel{
    
    GDFirstSurveyModel *model = cardModel.surveyModel;
    [self.surveyBgImgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    self.surveyTitleLabel.text = model.name;
    self.model = cardModel.surveyModel;
    
}

- (IBAction)preview:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(gotoPreVc::)]) {
        [self.delegate gotoPreVc:self.transitionView :self.model];

    }
    
}


@end
