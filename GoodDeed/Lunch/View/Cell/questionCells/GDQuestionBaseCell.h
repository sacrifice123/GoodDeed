//
//  GDQuestionBaseCell.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDQuestionModel.h"

@interface GDQuestionBaseCell : UICollectionViewCell

@property (nonatomic, strong) GDQuestionModel *model;

- (void)enableScroll:(BOOL)isEnable;
- (void)finishAnswer;
- (void)refreshData:(GDQuestionModel *)model;

@end
