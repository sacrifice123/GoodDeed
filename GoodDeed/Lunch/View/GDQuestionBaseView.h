//
//  GDQuestionBaseView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/21.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDQuestionModel.h"

typedef void(^answerFinishBlock)(NSInteger index);

@interface GDQuestionBaseView : UIView

@property (nonatomic, strong) GDQuestionModel *model;
@property (nonatomic, assign) BOOL isAnswer;
@property (nonatomic, strong) answerFinishBlock finishBlock;

- (void)finishAnswer:(GDQuestionModel *)model;
@end
