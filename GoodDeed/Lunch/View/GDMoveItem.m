//
//  GDMoveItem.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/4.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDMoveItem.h"
#import "GDQuestionScrollView.h"

@implementation GDMoveItem
{
    UIButton *temButton;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor colorWithHexString:@"#666666"];
        self.font = [UIFont fontWithName:@"PingFangSC-Light" size:20];
        self.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        self.layer.cornerRadius = item_height*0.5;
        self.layer.masksToBounds = YES;
        self.originFrame = frame;
        
    }
    
    return self;
}

- (NSMutableArray *)targetArray{
    
    if (_targetArray== nil) {
        _targetArray = [[NSMutableArray alloc] init];
    }
    return _targetArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.superview bringSubviewToFront:self];
    [self itemTouchesBegan];
    [self enableScroll:NO];
   // self.alpha = 0.3;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self];
    //以前的point
    CGPoint preP = [touch previousLocationInView:self];
    //x轴偏移的量
    CGFloat offsetX = currentP.x - preP.x;
    //Y轴偏移的量
    CGFloat offsetY = currentP.y - preP.y;
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    [self pause];
    [self enableScroll:NO];
   // self.alpha = 1;

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.block) {
        self.block(self.frame);
    }
    [self resume];
    self.layer.cornerRadius = item_height*0.5;
    [self enableScroll:YES];
   // self.alpha = 1;
    
    for (UIButton *btn in self.targetArray) {
        if (self.y<=btn.y+btn.height*0.5) {
            [self stop];
            temButton = btn;
            break;
        }
    }
    if (temButton) {
        for (UIButton *btn in self.targetArray) {
            if (btn == temButton) {
                btn.selected = YES;
                self.frame = btn.frame;

            }else{
                btn.selected = NO;
            }
       
        }
        
    }
    CGPoint center = self.center;
    self.frame = self.originFrame;
    self.center = CGPointMake(center.x, center.y);

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self resume];
    CGPoint center = self.center;
    self.frame = self.originFrame;
    self.center = CGPointMake(center.x, center.y);
    self.layer.cornerRadius = item_height*0.5;
    [self enableScroll:YES];
}

- (void)pause {
    self.layer.speed = 0.0;
}

- (void)resume {
    self.layer.speed = 1.0;
}

- (void)stop{
    
    [self.layer removeAnimationForKey:@"rotation"];
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置属性，周期时长
    [animation setDuration:0.08];
    //抖动角度
    animation.fromValue = @(0);
    animation.toValue = @(0);
    //重复次数，无限大
    animation.repeatCount = 1;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.layer addAnimation:animation forKey:@"rotation"];

}

- (void)itemTouchesBegan {
    CGPoint center = self.center;
    self.frame = CGRectMake(self.x, self.y, self.originFrame.size.width*1.5, self.originFrame.size.height*1.5);
    self.center = center;
    [self shakeItem];
    self.layer.cornerRadius = item_height;

}

//layer.speed
//这个参数的理解比较复杂，我的理解是所在layer的时间与父layer的时间的相对速度，为1时两者速度一样，为2那么父layer过了一秒，而所在layer过了两秒（进行两秒动画）,为0则静止。
//动画设置
- (void)shakeItem{
    [self.layer removeAnimationForKey:@"rotation"];
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置属性，周期时长
    [animation setDuration:0.08];
    //抖动角度
    animation.fromValue = @(-M_PI/160);
    animation.toValue = @(M_PI/160);
    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.layer addAnimation:animation forKey:@"rotation"];
}

- (void)enableScroll:(BOOL)isEnable{
    
    GDQuestionScrollView *scrollView = (GDQuestionScrollView *)[GDHelper getTargetView:[GDQuestionScrollView class] view:self];
    if (scrollView) {
        scrollView.scrollEnabled = isEnable;
    }

}

@end
