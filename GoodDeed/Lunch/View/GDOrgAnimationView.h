//
//  GDOrgAnimationView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AnimationBlock)(NSInteger index);
typedef void(^FinishBlock)(BOOL);
@interface GDOrgAnimationView : UIView

@property (nonatomic, strong) AnimationBlock animationblock;
@property (nonatomic, strong) FinishBlock finishBlock;
@property (nonatomic, assign) BOOL isAnimation;

+ (GDOrgAnimationView *)sharedView;
+ (void)destory;
- (void)animationStart:(NSInteger)index completion:(void (^)(BOOL))block;
@end
