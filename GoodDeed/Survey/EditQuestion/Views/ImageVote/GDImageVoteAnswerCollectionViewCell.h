//
//  GDImageVoteAnswerCollectionViewCell.h
//  GoodDeed
//
//  Created by HK on 2018/9/5.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDEditImageViewModel.h"

typedef void (^EditTextCollectionCellDeleteEventBlock) (UICollectionViewCell *cell, GDEditBaseViewModel *deleteModel);

@interface GDImageVoteAnswerCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) GDEditImageViewModel *viewModel;
@property (copy, nonatomic) EditTextCollectionCellDeleteEventBlock deleteEvent;

@end
