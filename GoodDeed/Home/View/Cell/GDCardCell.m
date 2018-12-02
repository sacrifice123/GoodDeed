//
//  GDCardCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/10/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDCardCell.h"
#import "WkwebViewController.h"

@interface GDCardCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headBgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *organImgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
    
@property (strong, nonatomic) GDCardModel *model;
@property (strong, nonatomic) GDSurveyTaskModel *taskModel;
    
@end
@implementation GDCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;

    
}

- (void)setCardModel:(GDHomeModel *)cardModel{
    self.model = cardModel.cardModel;
    self.taskModel = cardModel.taskModel;
    
}

- (void)setModel:(GDCardModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    [self.moreButton setTitle:model.hrefName forState:0];
    self.contentLabel.text = model.cardNote;
    [self.organImgView gd_setImageWithUrlStr:model.backgroundImgUrl];
    [self.button setTitle:model.buttonName forState:0];
    self.button.backgroundColor = [UIColor colorWithHexString:model.buttonColor];;

    
}

//点击查看更多跳转外链
- (IBAction)learnMore:(id)sender {
    
    WkwebViewController *webVc = [[WkwebViewController alloc] init];
    webVc.url = self.model.hrefUrl;
    UIViewController *vc = [GDHelper getSuperVc:self];
    [vc.navigationController pushViewController:webVc animated:YES];
    
}

//1.如果是注册登录后推送的card，点击切换组织机构
//2.如果是回答问卷里推送的card，点击跳转外链
- (IBAction)switchToCause:(id)sender {
    
    if (self.model.isHome) {//点击完成问卷
        WkwebViewController *webVc = [[WkwebViewController alloc] init];
        webVc.url = self.model.buttonHref;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (self.taskModel) {
            [dic setObject:self.taskModel forKey:@"task"];
        }
        webVc.taskData = dic;
        UIViewController *vc = [GDHelper getSuperVc:self];
        [vc.navigationController pushViewController:webVc animated:YES];

    }else{//切换公益机构
        
        
    }
    
    
}

@end
