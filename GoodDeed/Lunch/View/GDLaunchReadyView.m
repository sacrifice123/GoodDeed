//
//  GDLaunchReadyView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLaunchReadyView.h"
#import "GDOrgAnimationView.h"

@interface GDLaunchReadyView()
@property (nonatomic,strong) UIButton *readyButton;
@property (nonatomic,assign) BOOL isAnimation;
@end

@implementation GDLaunchReadyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUp];
    }
    return self;
}


- (void)setUp{
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"lunch_quesBg"];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(SCREEN_HEIGHT*0.5+15));
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.text = @"在这里，\n为你热爱的公益事业筹善款。\n准备好了吗？";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(imgView.mas_bottom).offset(46);
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"准备好了" forState:0];
    [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
    button.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(50);
        make.left.equalTo(self).offset(44);
        make.right.equalTo(self).offset(-44);
        make.height.equalTo(@70);
    }];
    self.readyButton = button;
    
}

//准备好了
- (void)buttonClicked{
    
    if ([self.delegate respondsToSelector:@selector(readyClickedEvent:)]) {
        [self.delegate readyClickedEvent:self.isAnimation];
        
    }

    if (!self.isAnimation) {
        self.isAnimation = YES;
        self.readyButton.selected = YES;
        self.readyButton.backgroundColor = [UIColor colorWithHexString:@"##2E3192"];
        GDOrgAnimationView *view = [[GDOrgAnimationView alloc] initWithFrame:self.frame];
        view.tag = 666;
        [self.superview addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        view.animationblock();
        __weak typeof(self) weakSelf = self;
        view.finishBlock = ^(BOOL finish) {
            weakSelf.readyButton.selected = NO;
            weakSelf.readyButton.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        };

    }

}

@end
