//
//  GDOrgAnimationView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AnimationBlock)(void);

@interface GDOrgAnimationView : UIView

@property (nonatomic, strong) AnimationBlock block;

@end
