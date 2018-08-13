//
//  UIWindow+HUD.m
//  GoodDeed
//
//  Created by 张涛 on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "UIWindow+HUD.h"

@implementation UIWindow (HUD)

-(MBProgressHUD *)gethudType:(BOOL)isHidden{
    MBProgressHUD *hud = [self viewWithTag:1000000];
    if (isHidden) {
        return hud;
    }
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:self];
        hud.tag = 1000000;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gd_tapHud)];
        [hud addGestureRecognizer:tapGesture];
        [self addSubview:hud];
    }
    return hud;
}

- (void)showString:(NSString *)text forSeconds:(NSTimeInterval)seconds
{
    
    [self hideHud];
    if (!text || ![text isKindOfClass:[NSString class]]) {
        return;
    }
    
    float height;
    height = 76;
    UIView *backView = [self viewWithTag:100000011];
    [backView removeFromSuperview];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(alertHidden:) object:backView];
    if (!backView) {
        backView = [[UIView alloc] init];
        backView.tag = 100000011;
        backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65];
        backView.layer.cornerRadius = 5.0f;
        
    }
    [self addSubview:backView];
    
    [self bringSubviewToFront:backView];
    
    UILabel *label = [backView viewWithTag:100000012];
    if (!label) {
        label = [[UILabel alloc] init];
        label.tag = 100000012;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:label];
    }
    label.text = text;
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size;
    
    float width;
    if (size.width + 30 > 300) {
        width = 300;
    }else{
        width = size.width + 30;
    }
    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(size.height + 5));
        
        make.width.equalTo(@(width - 27));
        make.top.equalTo(backView.mas_top).offset(10);
        make.bottom.equalTo(backView.mas_bottom).offset(-10);
        make.leading.equalTo(backView).offset(11);
        make.trailing.equalTo(backView).offset(-11);
    }];
    
    [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //make.bottom.equalTo(self.mas_bottom).offset(- height);
        make.width.equalTo(@(width));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self layoutIfNeeded];
    [self performSelector:@selector(alertHidden:) withObject:backView afterDelay:seconds];
}

- (void)alertHidden:(UIView *)backView{
    [backView removeFromSuperview];
}

- (void)showHudWithString:(NSString *)text forSeconds:(NSTimeInterval)seconds
{
    [self showHudWithString:text];
    [self hideHudAfterSeconds:seconds];
}

- (void)showWithString:(NSString *)text{
    
    [self showString:text forSeconds:1.5];
}

- (void)showHudWithString:(NSString *)text
{
    NSString *labelText = @"";
    if (text&&[text isKindOfClass:[NSString class]]) {
        labelText = text;
    }
    MBProgressHUD *hud = [self gethudType:NO];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = labelText;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.y = 0;
    [hud showAnimated:YES];
    [self bringSubviewToFront:hud];
}

- (void)gd_tapHud
{
    [[self gethudType:NO] hideAnimated:NO];
}

- (void)hideHud
{
    [[self gethudType:NO] hideAnimated:NO];
}

- (void)hideHudAfterSeconds:(NSTimeInterval)interval
{
    [[self gethudType:YES] hideAnimated:YES afterDelay:interval];
}

@end
