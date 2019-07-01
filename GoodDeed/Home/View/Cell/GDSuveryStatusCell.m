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
   
    _model = cardModel.taskModel;
    self.answerNumLabel.text = cardModel.taskModel.personNum;
    self.finishTimeLabel.text = cardModel.taskModel.preFinishTime;
    self.knowView.hidden = cardModel.isHasSurvery;
    self.suveryView.hidden = !cardModel.isHasSurvery;
    self.finishImgView.hidden = !cardModel.taskModel.status;
    self.GoButton.hidden = cardModel.taskModel.status;
    self.earnLabel.hidden = !cardModel.taskModel.status;
    if (cardModel.isHasSurvery) {
        self.contentLabel.text = cardModel.taskModel.surveyName;
        self.earnLabel.text = cardModel.taskModel.money;

    }else{
        self.contentLabel.text = @"让我们互相了解一下吧?";

    }
}



//去回答问题
- (IBAction)GoAndAnswerQuestion:(id)sender {

    if (self.model&&!self.model.status) {//有未回答完的问卷
        //查询问卷问题
        [GDHomeManager getSurveyListWithSurveyId:self.model.surveyId completionBlock:^(NSArray *array) {
            if (array&&array.count>0) {
                UIViewController *vc = [GDHelper getSuperVc:self];
                if (vc) {
                    GDLaunchQuestionController *quesVc = [[GDLaunchQuestionController alloc] init];
                    quesVc.isHome = YES;
                    [vc.navigationController pushViewController:quesVc animated:YES];
                }
            }
        }];
    }
}


@end
