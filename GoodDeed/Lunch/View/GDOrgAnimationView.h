//
//  GDOrgAnimationView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AnimationBlock)(void);
typedef void(^FinishBlock)(BOOL);
@interface GDOrgAnimationView : UIView

@property (nonatomic, strong) AnimationBlock animationblock;
@property (nonatomic, strong) FinishBlock finishBlock;
@end
