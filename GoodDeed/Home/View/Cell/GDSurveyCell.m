//
//  GDSurveyCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/8.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSurveyCell.h"
#import "GDSurveyModel.h"
#import "GDDataBaseManager.h"

@interface GDSurveyCell()
@property (weak, nonatomic) IBOutlet UIView *transitionView;
@property (weak, nonatomic) IBOutlet UILabel *surveyTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *surveyBgImgView;
@property (strong, nonatomic) GDSurveyModel *model;

@end
@implementation GDSurveyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

- (void)setCardModel:(GDHomeModel *)cardModel{
    
    GDSurveyModel *model = cardModel.surveyModel;
    [self.surveyBgImgView sd_setImageWithURL:[NSURL URLWithString:model.backgroundImageUrl]];
    self.surveyTitleLabel.text = model.surveyName;
    self.model = cardModel.surveyModel;
    
}

- (IBAction)preview:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(gotoPreVc::)]) {
        [self.delegate gotoPreVc:self.transitionView :self.model];

    }
    
}

//复制链接
- (IBAction)copyLink:(id)sender {
    
    
}

//删除
- (IBAction)deleteSurvey:(id)sender {
    
    [GDDataBaseManager survey_delete:self.model.surveyId];
    if ([self.delegate respondsToSelector:@selector(survey_reloadData:)]) {
        [self.delegate survey_reloadData:3];
    }
}

@end
