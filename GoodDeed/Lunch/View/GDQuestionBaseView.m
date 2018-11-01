//
//  GDQuestionBaseView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/21.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDQuestionBaseView.h"

@implementation GDQuestionBaseView


- (void)finishAnswer:(GDFirstQuestionListModel *)model{
    
    if (self.finishBlock) {
        self.isAnswer = YES;
        self.finishBlock(model.sort);
        [[GDLunchManager sharedManager] finishAnswerWithModel:model];
    }
    
}   

- (BOOL)isAnimation{
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:GDAnimationStatus] boolValue];
}
@end
