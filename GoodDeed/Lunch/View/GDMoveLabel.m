//
//  GDMoveLabel.m
//  GoodDeed
//
//  Created by 张涛 on 2018/9/2.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDMoveLabel.h"

@implementation GDMoveLabel

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
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
    
}

@end
