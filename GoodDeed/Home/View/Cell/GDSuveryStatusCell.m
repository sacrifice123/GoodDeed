//
//  GDSuveryStatusCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSuveryStatusCell.h"

@interface GDSuveryStatusCell()
@property (weak, nonatomic) IBOutlet UIView *knowView;//了解下

@property (weak, nonatomic) IBOutlet UIView *suveryView;//去回答问卷

@property (weak, nonatomic) IBOutlet UILabel *answerNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishTimeLabel;


@end
@implementation GDSuveryStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}


- (void)setCardModel:(GDHomeModel *)cardModel{
   
    self.answerNumLabel.text = cardModel.taskModel.personNum;
    self.finishTimeLabel.text = cardModel.taskModel.preFinishTime;
    self.knowView.hidden = cardModel.isHasSurvery;
    self.suveryView.hidden = !cardModel.isHasSurvery;
    
}

@end
