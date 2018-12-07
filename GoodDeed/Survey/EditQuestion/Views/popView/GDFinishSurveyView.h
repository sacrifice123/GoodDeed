//
//  GDFinishSurveyView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/12/6.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finishClick)(NSInteger tag);
@interface GDFinishSurveyView : UIView

@property (nonatomic, copy) finishClick clickBlock;

- (void)show;

@end
