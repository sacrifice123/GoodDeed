//
//  GDFinishSurveyView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/12/6.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDFinishSurveyView.h"

@implementation GDFinishSurveyView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self createUI];
    }
    
    return self;
}


- (void)createUI{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.5, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
    [self addSubview:bgView];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"suvery_finish_bg"];
    [bgView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView);
    }];
    UIButton *sendButton = [[UIButton alloc] init];
    sendButton.tag = 0;
    [sendButton setBackgroundImage:[UIImage imageNamed:@"suvery_finish_send"] forState:0];
    [bgView addSubview:sendButton];
    [sendButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(80);
        make.left.equalTo(bgView).offset(64);
        make.width.height.equalTo(@100);
    }];
     
    UILabel *sendLabel = [[UILabel alloc] init];
    sendLabel.text = @"发送调查\n并得到回应";
    sendLabel.numberOfLines = 0;
    sendLabel.textAlignment = NSTextAlignmentCenter;
    sendLabel.textColor = [UIColor colorWithHexString:@"#006500"];
    sendLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
    [bgView addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sendButton.mas_bottom).offset(10);
        make.centerX.equalTo(sendButton);
    }];
    
    UIButton *addButton = [[UIButton alloc] init];
    addButton.tag = 1;
    [addButton setBackgroundImage:[UIImage imageNamed:@"suvery_finish_add"] forState:0];
    [bgView addSubview:addButton];
    [addButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(80);
        make.right.equalTo(bgView).offset(-64);
        make.width.height.equalTo(@100);
    }];
    UILabel *addLabel = [[UILabel alloc] init];
    addLabel.text = @"添加新的问题";
    addLabel.textColor = [UIColor colorWithHexString:@"#006500"];
    addLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];

    [bgView addSubview:addLabel];
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addButton.mas_bottom).offset(10);
        make.centerX.equalTo(addButton);
    }];
    [self layoutIfNeeded];
    
}

- (void)buttonClicked:(UIButton *)button{
    
    if (self.clickBlock) {
        self.clickBlock(button.tag);
    }
    [self removeFromSuperview];

}

- (void)show{
    
    [UIView animateWithDuration:0.4f animations:^{
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.9f];
       // self.optionView.frame = CGRectMake(0, SCREEN_HEIGHT*0.5, SCREEN_WIDTH, SCREEN_HEIGHT*0.5);
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self];
    if (currentP.y>SCREEN_HEIGHT*0.5) {
        return;
    }
    
    [self removeFromSuperview];
//    [UIView animateWithDuration:0.4f animations:^{
//        self.backgroundColor = [UIColor clearColor];
//        //self.optionView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5);
//
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//
//    }];
    
}

@end
