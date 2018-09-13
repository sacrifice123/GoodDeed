//
//  GDQuestionBaseCell.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDFirstQuestionListModel.h"

@interface GDQuestionBaseCell : UICollectionViewCell

@property (nonatomic, strong) GDFirstQuestionListModel *model;

- (void)enableScroll:(BOOL)isEnable;
- (void)finishAnswer;
- (void)refreshData:(GDFirstQuestionListModel *)model;

@end
