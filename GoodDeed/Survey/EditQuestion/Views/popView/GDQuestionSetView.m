//
//  GDQuestionSetView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/12/3.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDQuestionSetView.h"
@interface GDQuestionSetView()


@property (strong, nonatomic)  UIView *optionView;
@property (strong, nonatomic)  NSArray *optionArray;

@end

@implementation GDQuestionSetView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self createUI];
    }
    
    return self;
}

- (NSArray *)optionArray{
    
    if (_optionArray == nil) {
        _optionArray = @[
                         @{@"normal":@"survey_random",
                           @"selected":@"survey_random_selected",
                           @"text":@" 随机选项顺序"
                           },
                         @{@"normal":@"survey_jump",
                           @"selected":@"survey_jump_selected",
                           @"text":@" 答题人可跳过这道题"
                           },
                         @{@"normal":@"survey_add",
                           @"selected":@"survey_add_selected",
                           @"text":@" 添加其他选项（可在文本框内输入答案）"
                           }
                         ];
    }
    
    return _optionArray;
}

- (void)createUI{
    
    [self addSubview:self.optionView];
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"survey_setting"];
    [_optionView addSubview:imageV];
    __weak typeof(self) weakSelf = self;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.top.equalTo(weakSelf.optionView).offset(25);
        make.centerX.equalTo(weakSelf.optionView);
    }];
    UIView *temView = imageV;
    for (int i=0; i<3; i++) {
        UIButton *button = [self createOptionButton:i];
        [_optionView addSubview:button];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.optionView).offset(38);
            make.top.equalTo(temView.mas_bottom).offset(18);
            make.height.equalTo(@21);
        }];
        temView = button;
    }

}

- (UIView *)optionView{
    
    if (_optionView == nil) {
        _optionView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
        _optionView.backgroundColor = [UIColor whiteColor];
    }
    return _optionView;
}


- (UIButton *)createOptionButton:(NSInteger)index{
    
    NSDictionary *dic = [self.optionArray objectAtIndex:index];
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:[dic objectForKey:@"text"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#007AFF"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:[dic objectForKey:@"normal"]] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[dic objectForKey:@"selected"]] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)buttonClicked:(UIButton *)button{
    
    button.selected = !button.selected;
}

- (void)show{
    
    [UIView animateWithDuration:0.4f animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
        self.optionView.frame = CGRectMake(0, SCREEN_HEIGHT*0.5, SCREEN_WIDTH, SCREEN_HEIGHT*0.5);
    }];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self];
    if (currentP.y>SCREEN_HEIGHT*0.5) {
        return;
    }
    [UIView animateWithDuration:0.4f animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.optionView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];

}

@end
