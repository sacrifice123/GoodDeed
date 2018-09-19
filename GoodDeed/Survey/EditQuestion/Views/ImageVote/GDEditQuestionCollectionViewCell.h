//
//  GDEditQuestionCollectionViewCell.h
//  GoodDeed
//
//  Created by HK on 2018/9/5.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDEditTextTypeCellProtocol.h"

typedef void (^EditTextCollectionCellUpdateHeightBlock) (UICollectionViewCell *cell);

@interface GDEditQuestionCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) GDEditBaseViewModel *viewModel;

@property (copy, nonatomic) EditTextCollectionCellUpdateHeightBlock updateHeight;


@end
