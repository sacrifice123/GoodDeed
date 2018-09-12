//
//  GDQuestionBaseView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/21.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDFirstQuestionListModel.h"

typedef void(^answerFinishBlock)(NSInteger index);

@interface GDQuestionBaseView : UIView

@property (nonatomic, strong) GDFirstQuestionListModel *model;
@property (nonatomic, assign) BOOL isAnswer;
@property (nonatomic, strong) answerFinishBlock finishBlock;

- (void)finishAnswer:(GDFirstQuestionListModel *)model;
@end
