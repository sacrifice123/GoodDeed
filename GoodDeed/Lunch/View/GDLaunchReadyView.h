//
//  GDLaunchReadyView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuestionBaseView.h"

@protocol GDLaunchReadyViewDelegate <NSObject>

- (void)readyClickedEvent:(BOOL)isAnimation;

@end

@interface GDLaunchReadyView : GDQuestionBaseView

@property (nonatomic, weak) id<GDLaunchReadyViewDelegate>delegate;
@end
