//
//  GDSuveryStatusCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSuveryStatusCell.h"
#import "GDLaunchQuestionController.h"

@interface GDSuveryStatusCell()
@property (weak, nonatomic) IBOutlet UIView *knowView;//了解下
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnLabel;

@property (weak, nonatomic) IBOutlet UIView *suveryView;//去回答问卷

@property (weak, nonatomic) IBOutlet UILabel *answerNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *finishImgView;
@property (weak, nonatomic) IBOutlet UIButton *GoButton;

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
    self.finishImgView.hidden = !cardModel.isFinishAnswer;
    self.GoButton.hidden = cardModel.isFinishAnswer;
    self.earnLabel.hidden = !cardModel.isFinishAnswer;
    if (cardModel.isHasSurvery) {
        self.contentLabel.text = cardModel.taskModel.surveyName;
        self.earnLabel.text = cardModel.taskModel.money;

    }else{
        self.contentLabel.text = @"让我们互相了解一下吧?";

    }
}

//去回答问题
- (IBAction)GoAndAnswerQuestion:(id)sender {
    UIViewController *vc = [GDHelper getSuperVc:self];
    if (vc) {
        GDLaunchQuestionController *quesVc = [[GDLaunchQuestionController alloc] init];
        quesVc.isHome = YES;
        [vc.navigationController pushViewController:quesVc animated:YES];
    }
    
}


@end
