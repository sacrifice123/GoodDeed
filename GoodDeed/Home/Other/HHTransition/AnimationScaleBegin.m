//
//  AnimationScaleBegin.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "AnimationScaleBegin.h"
#import "UIViewController+HHTransition.h"
#import "UIView+HHLayout.h"

#define duration 0.5
@implementation AnimationScaleBegin

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (![self responseToSel:@[fromVC,toVC]]) {
        [transitionContext completeTransition:YES];
        return;
    }
    UIColor *containerViewColor = [transitionContext containerView].backgroundColor;
    [transitionContext containerView].backgroundColor = [UIColor whiteColor];
    [[transitionContext containerView] addSubview:toVC.view];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *sourceView = [fromVC hh_transitionAnimationView];
    UIView *destinationView = [toVC hh_transitionAnimationView];
    if (!sourceView || !destinationView) {
        [transitionContext completeTransition:YES];
        return;
    }
    CGPoint sourcePoint = [sourceView convertPoint:CGPointZero toView:nil];
    CGPoint destinationPoint = [destinationView convertPoint:CGPointZero toView:nil];
    
    UIView *snapShot = [sourceView snapshotViewAfterScreenUpdates:NO];
    [[transitionContext containerView] addSubview:snapShot];
    snapShot.origin = sourcePoint;
    CGFloat heightScale = 1.5;//destinationView.height/sourceView.height;
    CGFloat widthScale = 1.5;//destinationView.width/sourceView.width;
    
    CGRect originFrame = fromView.frame;
    toView.hidden = YES;
    [UIView animateWithDuration:duration animations:^{
        
        snapShot.transform =  CGAffineTransformMakeScale(widthScale,heightScale);
        snapShot.origin = destinationPoint;
        fromView.alpha = 0;
        fromView.transform = snapShot.transform;
      //  CGPoint point = CGPointMake((destinationPoint.x - sourcePoint.x)*widthScale-70, (destinationPoint.y - sourcePoint.y)*heightScale);
        fromView.origin = CGPointMake((destinationPoint.x - sourcePoint.x)*widthScale+100, (destinationPoint.y - sourcePoint.y)*heightScale+200);
        
    } completion:^(BOOL finished) {
        [transitionContext containerView].backgroundColor = containerViewColor;
        [snapShot removeFromSuperview];
        toView.hidden = NO;
        fromView.alpha = 1;
        fromView.transform = CGAffineTransformIdentity;
        fromView.frame = originFrame;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (BOOL)responseToSel:(NSArray <UIViewController *>*)array
{
    if (!array.count) {
        return NO;
    }
    for (UIViewController *vc in array) {
        if (![vc respondsToSelector:@selector(hh_transitionAnimationView)]) {
            return NO;
        }
    }
    return YES;
}

@end
