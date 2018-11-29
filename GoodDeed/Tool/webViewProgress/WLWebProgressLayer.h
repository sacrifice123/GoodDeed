//
//  WLWebProgressLayer.h
//  WangliBank
//
//  Created by justin on 16/6/22.
//  Copyright © 2016年 zhan infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface WLWebProgressLayer : CAShapeLayer

+ (instancetype)layerWithFrame:(CGRect)frame;

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;

@end
